import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:pullebyte/CustomWidgets/MainButton.dart';
import 'package:pullebyte/CustomWidgets/Textinput.dart';
import 'package:pullebyte/controller_database.dart'; // Importar o DatabaseController
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pullebyte/theme/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _accessibilityEnabled = false;
  final DatabaseController _databaseController = DatabaseController();
  String profilePictureUrl = 'https://i.yourimageshare.com/uuzM2gyY18.png'; // Definindo a variável profilePictureUrl

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    await Future.delayed(const Duration(seconds: 1));
    User? userData = await _databaseController.getUserProfile();
    setState(() {
      _nameController.text = userData?.displayName ?? '';
      _emailController.text = userData?.email ?? '';
      profilePictureUrl = userData?.photoURL ?? _databaseController.defaultProfilePictureUrl;
      // profilePictureUrl = _databaseController.defaultProfilePictureUrl;
    });
  }

  void _showProfilePicture(String profilePictureUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Center(
            heightFactor: 1.05,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                profilePictureUrl,
                width: 250.0,
                height: 250.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _updateProfilePicture() async {
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
          await _databaseController.updateProfilePicture(file);
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

  Future<void> _signOut() async {
    try {
      await _databaseController.signOut();
      Navigator.pushReplacementNamed(context, '/tela_login');
      // Navegar para a tela de login ou outra ação após o logout
    } catch (e) {
      throw Exception('Erro ao fazer logout: $e');
    }
  }

  void _savePersonalData() async {
    User? userData = await _databaseController.getUserProfile();
    String newName = _nameController.text;
    String newEmail = _emailController.text;

    if (userData?.email != newEmail || userData?.displayName != newName) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Salvando alterações...')),
      );

      try {
        // Atualizar o e-mail do usuário
        if (newEmail != userData?.email) {
          _databaseController.updateUserEmail(newEmail);
        }
        if (newName != userData?.displayName) {
          _databaseController.updateUserName(newName);
        }

        setState(() {
          _nameController.text = newName;
          _emailController.text = newEmail;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Dados salvos com sucesso!\nVerifique seu novo e-mail para confirmar a alteração.')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar dados: ${e.toString()}')),
        );
      }
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Atualize os campos para salvar as alterações.')),
    );
  }

  Future<void> _resetPassword() async {
    User? userData = await _databaseController.getUserProfile();
    try {
      if (userData != null) {
        _databaseController.resetPassword();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Verifique seu e-mail para redefinir a senha.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao enviar e-mail de redefinição de senha: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                icon: const Icon(FeatherIcons.chevronLeft),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 10),
              const Text('Perfil'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    GestureDetector(
                        onTap: () {
                          _showProfilePicture(profilePictureUrl);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.network(
                            profilePictureUrl,
                            width: 170.0,
                            height: 170.0,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return SizedBox(
                                  width: 170.0,
                                  height: 170.0,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                          : null,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        )),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 46.0,
                        height: 46.0,
                        decoration: BoxDecoration(
                          color: customColorScheme.onPrimary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: IconButton(
                            iconSize: 32.0, // Ajuste o tamanho do ícone para caber no container
                            color: customColorScheme.secondary,

                            icon: const Icon(FeatherIcons.plus),
                            onPressed: () {
                              _updateProfilePicture();
                              // Ação do botão menor
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Dados Pessoais',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFieldSample(
                        controller: _nameController,
                        hintText: 'Nome',
                        isSenha: false,
                      ),
                      const SizedBox(height: 10),
                      TextFieldSample(
                        controller: _emailController,
                        hintText: 'E-mail',
                        isSenha: false,
                      ),
                      const SizedBox(height: 10),
                      MainButton(
                        text: 'Salvar',
                        onPressed: _savePersonalData,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Redefinir Senha',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      MainButton(
                        onPressed: _resetPassword,
                        text: 'Redefinir Senha',
                      ),
                      // ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Acessibilidade',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      DropdownButton<bool>(
                        value: _accessibilityEnabled,
                        items: const [
                          DropdownMenuItem(
                            value: true,
                            child: Text('Desabilitado'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Daltonismo'),
                          ),
                        ],
                        onChanged: (bool? newValue) {
                          setState(() {
                            _accessibilityEnabled = newValue ?? false;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      MainButton(
                        text: 'Salvar',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.all(10.0),
                        child: MainButton(
                          onPressed: _signOut,
                          text: 'Logout',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
