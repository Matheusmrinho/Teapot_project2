import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pullebyte/CustomWidgets/MainButton.dart';
import 'package:pullebyte/controller_canhotos.dart';
import 'package:pullebyte/theme/colors.dart';
import 'package:pullebyte/CustomWidgets/Textinput.dart';
import 'package:pullebyte/CustomWidgets/Dropdown.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class CanhotoModal extends StatefulWidget {
  const CanhotoModal({super.key});

  @override
  _CanhotoModalState createState() => _CanhotoModalState();
}

class _CanhotoModalState extends State<CanhotoModal> {
  final TextEditingController _pulleTitleController = TextEditingController();
  final TextEditingController _pulleDateController = TextEditingController();
  final TextEditingController _pulleValueController = TextEditingController();
  final TextEditingController _pulleValueCotacaoController = TextEditingController();
  final TextEditingController _pulleStatusController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  String _photoController = 'https://via.placeholder.com/150';
  String _pulleTimeSelected = '';
  String _pulleTimeSelectedID = '';
  String canhotoID = '';
  final Uuid uuid = Uuid();
  List<Map<String, dynamic>> _foundTimes = [];
  List<Map<String, dynamic>> allTimes = [];

  @override
  void initState() {
    super.initState();
    _fetchTimes();
    canhotoID = uuid.v4();
  }

  Future<void> _fetchTimes() async {
    final response = await http.get(Uri.parse('https://pullebyte.onrender.com/times'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        allTimes = List<Map<String, dynamic>>.from(data);
        _foundTimes = List.from(allTimes);
      });
    } else {
      throw Exception('Erro ao carregar os dados');
    }
  }

  List<Map<String, dynamic>> _filterTimes(String query) {
    if (query.isEmpty) {
      return List.from(allTimes);
    } else {
      return allTimes.where((time) {
        final nome = time['nomeDoTime'].toString().toLowerCase();
        return nome.startsWith(query.toLowerCase());
      }).toList();
    }
  }

  void _onTimeSelected(String nome, String id) {
    setState(() {
      _pulleTimeSelected = nome;
      _pulleTimeSelectedID = id;
      _searchController.text = nome;
      _foundTimes.clear();
    });
  }

  void salvarCanhoto(BuildContext context) {
    Timestamp pulleTimestamp = Timestamp.fromDate(
      DateTime.tryParse(_pulleDateController.text) ?? DateTime.now(),
    );

    context.read<CanhotosController>().addCanhoto(
          pulleID: canhotoID,
          pulleData: pulleTimestamp,
          pulleStatus: _pulleStatusController.text,
          pulleTimeEscolhido: _pulleTimeSelected,
          pulleTimeEscolhidoID: _pulleTimeSelectedID,
          pulleTitulo: _pulleTitleController.text,
          pulleValor: double.parse(_pulleValueController.text),
          pulleImagem: _photoController,
        );

    Navigator.pop(context);
  }

  Widget _criarItem(BuildContext context, String nomeDoTime, String idTime) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(nomeDoTime),
        onTap: () => _onTimeSelected(nomeDoTime, idTime),
      ),
    );
  }

  Future<void> _updateCanhotoPicture(BuildContext context, canhotoId) async {
    final ImagePicker _picker = ImagePicker();
    final ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecione uma opção'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text('Câmera'),
                onTap: () {
                  Navigator.pop(context, ImageSource.camera);
                },
              ),
              ListTile(
                title: const Text('Galeria'),
                onTap: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
    if (source != null) {
      final pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        final File file = File(pickedFile.path);

        try {
          _photoController = await context.read<CanhotosController>().updateCanhotoPicture(file, canhotoId);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Imagem salva com sucesso!')),
          );
        } catch (e) {
          print(e);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao salvar imagem: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: CustomColors.darkergrey,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 145.0, vertical: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                height: 5.0,
                color: CustomColors.primaryColor,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 32.0),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: const Text(
                      'Adicionar Canhoto',
                      style: TextStyle(
                        color: CustomColors.textColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  TextFieldSample(
                    controller: _pulleTitleController,
                    hintText: 'Título da aposta',
                    isSenha: false,
                  ),
                  const SizedBox(height: 21.0),
                  TextFieldSample(
                    controller: _pulleDateController,
                    hintText: 'dd/mm/aaaa',
                    isDate: true,
                    isSenha: false,
                  ),
                  const SizedBox(height: 21.0),
                  TextFieldSample(
                    controller: _pulleValueController,
                    hintText: 'Valor apostado',
                    isSenha: false,
                    isValue: true,
                    isMoney: true,
                  ),
                  const SizedBox(height: 21.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFieldSample(
                        controller: _pulleValueCotacaoController,
                        hintText: 'Cotação',
                        isSenha: false,
                        isValue: true,
                        inputWidth: 0.4,
                      ),
                      const SizedBox(height: 21.0),
                      Dropdown(
                        hintText: 'Situação',
                        numeroDeOpcoes: const ['Ganhou', 'Perdeu', 'Em Andamento'],
                        onChanged: (String? value) {
                          _pulleStatusController.text = value!;
                        },
                        inputWidth: 0.4,
                      ),
                    ],
                  ),
                  const SizedBox(height: 21.0),
                  TextFieldSample(
                    controller: _searchController,
                    hintText: 'Time apostado',
                    isSenha: false,
                    onChanged: (query) {
                      setState(() {
                        _foundTimes = _filterTimes(query);
                      });
                    },
                  ),
                  if (_foundTimes.isNotEmpty && _searchController.text.isNotEmpty)
                    SizedBox(
                      height: 200,
                      width: double.infinity * 0.85,
                      child: ListView.builder(
                        itemCount: _foundTimes.length,
                        itemBuilder: (context, index) {
                          final time = _foundTimes[index];
                          return _criarItem(context, time['nomeDoTime'].toString(), time['idImagem'].toString());
                        },
                      ),
                    ),
                  const SizedBox(height: 21.0),
                  Container(
                    height: 96,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: CustomColors.accentColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: GestureDetector(
                      child: const Center(
                        child: Icon(
                          Icons.add_a_photo_rounded,
                          color: CustomColors.textFieldColor,
                          size: 24.0,
                        ),
                      ),
                      onTap: () => _updateCanhotoPicture(context, canhotoID),
                    ),
                  ),
                  const SizedBox(height: 21.0),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: MainButton(
                      text: 'Salvar',
                      onPressed: () => salvarCanhoto(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
