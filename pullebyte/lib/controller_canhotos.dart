import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

const uuid = Uuid();
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseStorage _storage = FirebaseStorage.instance;

class Canhoto {
  String? pulleTitulo;
  DateTime? pulleData;
  double? pulleValor;
  String? pulleTimeEscolhido;
  String? pulleTimeEscolhidoID;
  String? pulleStatus;
  String? pulleImagem = 'https://via.placeholder.com/150';
}

class CanhotosController extends ChangeNotifier {
  List<Map<String, dynamic>> canhotosList = [];

  void addCanhoto({
    required String pulleID,
    required String pulleTitulo,
    required Timestamp pulleData,
    required double pulleValor,
    required String pulleTimeEscolhido,
    required String pulleTimeEscolhidoID,
    String? pulleStatus,
    String? pulleImagem,
  }) async {
    canhotosList.add({
      'id': pulleID,
      'pulleTitle': pulleTitulo,
      'pulleDate': pulleData,
      'pulleValue': pulleValor,
      'pulleChosenTeam': pulleTimeEscolhido,
      'pulleChosenTeamID': pulleTimeEscolhidoID,
      'pulleStatus': pulleStatus,
      'pulleImage': pulleImagem,
    });
    _salvarCanhotosNoFirestore();
    notifyListeners();
  }

  Future<String> updateCanhotoPicture(File filePath, canhotoId) async {
    var user = _auth.currentUser;

    if (user == null) {
      throw Exception('Usuário não autenticado.');
    }

    final filename = path.basename(filePath.path);
    final ref = _storage.ref().child('canhotos/${user.uid}/$canhotoId/$filename');

    // Obter a URL da imagem
    await ref.putFile(filePath).catchError((e) {
      throw Exception('Erro ao enviar imagem para o Firebase Storage: $e');
    });

    try {
      var url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      throw Exception('Erro ao obter URL da imagem: $e');
    }
  }

  Future<void> _salvarCanhotosNoFirestore() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        final docRef = _firestore.collection('canhotos').doc(user.uid);

        if (canhotosList.isEmpty) {
          await docRef.set({'canhotosCadastrados': []}, SetOptions(merge: true));
        } else {
          await docRef.set({'canhotosCadastrados': canhotosList}, SetOptions(merge: true));
        }
      }
    } catch (e) {
      throw Exception('Erro ao salvar filtros no Firestore: $e');
    }
  }

  Future<void> carregarFiltrosDoFirestore() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot doc = await _firestore.collection('canhotos').doc(user.uid).get();
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>?;
          if (data != null && data.containsKey('canhotosCadastrados')) {
            List<dynamic> canhotosSalvos = data['canhotosCadastrados'];
            canhotosList.clear();
            canhotosList.addAll(canhotosSalvos.map((item) => Map<String, dynamic>.from(item)));
          } else {
            // Se o campo não existir, inicialize-o como uma lista vazia
            await FirebaseFirestore.instance.collection('canhotos').doc(user.uid).update({
              'canhotosCadastrados': [],
            });
            canhotosList.clear();
          }
        }
      }
    } catch (e) {
      throw Exception('Erro ao carregar filtros do Firestore: $e');
    }
    notifyListeners();
  }

  void deleteCanhoto(String id) {
    canhotosList.removeWhere((canhoto) => canhoto['id'] == id);
    notifyListeners();
    _salvarCanhotosNoFirestore(); // Salva a lista atualizada no Firestore
  }

  void editCanhoto(String id, Map<String, dynamic> data) {
    // Encontre o índice do canhoto a ser editado
    int index = canhotosList.indexWhere((canhoto) => canhoto['id'] == id);

    // Verifica se o canhoto com o ID fornecido existe
    if (index != -1) {
      canhotosList[index] = {
        'id': id, // mantém o ID do canhoto
        'pulleTitle': data['pulleTitle'] ?? canhotosList[index]['pulleTitle'],
        'pulleDate': data['pulleDate'] ?? canhotosList[index]['pulleDate'],
        'pulleValue': data['pulleValue'] ?? canhotosList[index]['pulleValue'],
        'pulleChosenTeam': data['pulleChosenTeam'] ?? canhotosList[index]['pulleChosenTeam'],
        'pulleChosenTeamID': data['pulleChosenTeamID'] ?? canhotosList[index]['pulleChosenTeamID'],
        'pulleStatus': data['pulleStatus'] ?? canhotosList[index]['pulleStatus'],
        'pulleImage': data['pulleImage'] ?? canhotosList[index]['pulleImage'],
      };

      // Notifica os ouvintes que a lista foi alterada
      notifyListeners();

      // Salva a lista atualizada no Firestore
      _salvarCanhotosNoFirestore();
    } else {
      throw Exception('Canhoto com ID $id não encontrado');
    }
  }
}

//  List<Map<String, dynamic>> get getCanhotos {
//     return Map.from(canhotosList); // Retorna uma cópia para evitar modificações externas
//   }

