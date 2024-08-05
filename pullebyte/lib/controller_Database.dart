import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class DatabaseController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final String defaultProfilePictureUrl = 'https://example.com/default-profile-picture.png';


  Future<Map<String, dynamic>> getUserProfile(String userId) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      } else {
        throw Exception('Usuário não encontrado');
      }
    } catch (e) {
      throw Exception('Erro ao buscar perfil do usuário: $e');
    }
  }

  Future<String> uploadProfilePicture(String filePath, String userId) async {
    File file = File(filePath);
    try {
      // Upload da imagem para o Firebase Storage
      TaskSnapshot snapshot = await _storage
          .ref('profilePictures/$userId')
          .putFile(file);
      // Obter a URL da imagem
      String downloadUrl = await snapshot.ref.getDownloadURL();
      
      // Salvar a URL da imagem no Firestore
      await _firestore
          .collection('users')
          .doc(userId)
          .update({'profilePictureUrl': downloadUrl});
      
      return downloadUrl;
    } catch (e) {
      throw Exception('Erro ao fazer upload da imagem: $e');
    }
  }

  Future<void> updateProfilePicture(String userId, String profilePictureUrl) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'userInfo.profilePicture': profilePictureUrl,
      });
    } catch (e) {
      throw Exception('Erro ao atualizar foto de perfil: $e');
    }
  }

  Future<void> updateUserProfile(String userId, String name, String email) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'userInfo.name': name,
        'userInfo.email': email,
      });
    } catch (e) {
      throw Exception('Erro ao atualizar perfil do usuário: $e');
    }
  }
  Future<void> signOut() async {
    await _auth.signOut();
  }
  Future<void> addUser(String userId, String email, String username) async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('users').doc(userId).get();
      if (!snapshot.exists) {
        await _firestore.collection('users').doc(userId).set({
          'userInfo': {
            'name': username,
            'email': email,
            'profilePicture': defaultProfilePictureUrl,
            'createdAt': FieldValue.serverTimestamp(),
          },
          'timesSelecionados': [],
        });
      } else {
        print('Usuário já existe no Firestore');
      }
    } catch (e) {
      print('Erro ao adicionar usuário: $e');
    }
  }


  Future<void> updateOldUsersWithProfilePicture() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').get();
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>?;
        Map<String, dynamic> updates = {};
        if (data != null) {
          if (!data.containsKey('profilePicture')) {
            updates['profilePicture'] = defaultProfilePictureUrl;
          }
          if (!data.containsKey('timesSelecionados')) {
            updates['timesSelecionados'] = [];
          }
          if (updates.isNotEmpty) {
            await _firestore.collection('users').doc(doc.id).update(updates);
          }
        }
      }
    } catch (e) {
      print('Erro ao atualizar usuários antigos: $e');
    }
  }

  // Método para autenticação
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Erro ao fazer login: $e');
      return null;
    }
  }
  Future<void> resetEmail(String newEmail, String currentPassword) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(credential);
        await user.updateEmail(newEmail);
        await _firestore.collection('users').doc(user.uid).update({
          'userInfo.email': newEmail,
        });
      }
    } catch (e) {
      throw Exception('Erro ao redefinir e-mail: $e');
    }
  }

  // Método para cadastro
  Future<User?> registerWithEmailAndPassword(String email, String password, String username) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // Adicione o nome de usuário ao perfil do usuário
      await user?.updateDisplayName(username);
      await user?.reload();
      user = _auth.currentUser;

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}