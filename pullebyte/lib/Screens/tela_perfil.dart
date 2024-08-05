import 'package:flutter/material.dart';
import 'package:pullebyte/CustomWidgets/MainButton.dart';
import 'package:pullebyte/CustomWidgets/Textinput.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pullebyte/controller_Database.dart'; // Importar o DatabaseController
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newEmailController = TextEditingController();
  bool _accessibilityEnabled = false;
  final DatabaseController _databaseController = DatabaseController();
  String profilePictureUrl = ''; // Definindo a variável profilePictureUrl

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var userProfile = await _databaseController.getUserProfile(user.uid);
      setState(() {
        _nameController.text = userProfile['userInfo']['name'];
        _emailController.text = userProfile['userInfo']['email'];
        profilePictureUrl = userProfile['userInfo']['profilePicture'] ?? '';
      });
    }
  }

  void _showProfilePicture(String profilePictureUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.network(profilePictureUrl),
        );
      },
    );
  }

  Future<void> _pickAndUploadProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      String profilePictureUrl = await _uploadProfilePicture(pickedFile.path, userId);
      await _databaseController.updateProfilePicture(userId, profilePictureUrl);
      setState(() {
        this.profilePictureUrl = profilePictureUrl; // Atualize o estado da tela com a nova URL da foto de perfil
      });
    }
  }

  Future<String> _uploadProfilePicture(String filePath, String userId) async {
    File file = File(filePath);
    try {
      // Upload da imagem para o Firebase Storage
      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref('profilePictures/$userId')
          .putFile(file);
      // Obter a URL da imagem
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Erro ao fazer upload da imagem: $e');
    }
  }

  Future<void> _signOut() async {
    try {
      await _databaseController.signOut();
      Navigator.pushReplacementNamed(context, '/tela_login');
      // Navegar para a tela de login ou outra ação após o logout
    } catch (e) {
      print('Erro ao fazer logout: $e');
    }
  }

  void _savePersonalData() async {
    String name = _nameController.text;
    String newEmail = _newEmailController.text;
    String currentPassword = _currentPasswordController.text;
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      if (newEmail.isEmpty || !newEmail.contains('@')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Por favor, insira um e-mail válido.')),
        );
        return;
      }

      try {
        // Reautenticar o usuário com as credenciais fornecidas
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(credential);

        // Atualizar o e-mail do usuário
        await user.updateEmail(newEmail);
        await user.sendEmailVerification(); // Envia um e-mail de verificação
        await _databaseController.updateUserProfile(user.uid, name, newEmail);

        setState(() {
          _nameController.text = name;
          _emailController.text = newEmail;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Dados salvos com sucesso! Verifique seu novo e-mail para confirmar a alteração.')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar dados: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _resetPassword() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String email = user.email!;
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('E-mail de redefinição de senha enviado!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao enviar e-mail de redefinição de senha: ${e.toString()}')),
      );
    }
  }

  Future<void> _resetEmail() async {
    try {
      String newEmail = _newEmailController.text;
      String currentPassword = _currentPasswordController.text;
      await _databaseController.resetEmail(newEmail, currentPassword);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('E-mail redefinido com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao redefinir e-mail: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final customColorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                icon: SvgPicture.asset('lib/Assets/botao_voltar.svg'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(width: 10),
              Text('Perfil'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 90.0,
                      height: 90.0,
                      decoration: BoxDecoration(
                        color: customColorScheme.primary,
                        borderRadius: BorderRadius.circular(46),
                      ),
                      child: IconButton(
                        iconSize: 100.0,
                        icon: SvgPicture.asset('lib/Assets/Icon_widget.svg'),
                        onPressed: () {
                          _showProfilePicture(profilePictureUrl);
                          // Ação do botão
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 30.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          color: customColorScheme.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          iconSize: 15.0,
                          icon: SvgPicture.asset('lib/Assets/icon_plus_branco.svg'),
                          onPressed: () {
                            _pickAndUploadProfilePicture();
                            // Ação do botão menor
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Dados Pessoais', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Padding(
                        padding: EdgeInsets.all(25.0),
                        child: TextFieldSample(
                          controller: _nameController,
                          hintText: 'Nome',
                          isSenha: false,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(25.0),
                        child: TextFieldSample(
                          controller: _emailController,
                          hintText: 'E-mail',
                          isSenha: false,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(25.0),
                        child: TextFieldSample(
                          controller: _newEmailController,
                          hintText: 'Novo E-mail',
                          isSenha: false,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(25.0),
                        child: TextFieldSample(
                          controller: _currentPasswordController,
                          hintText: 'Senha',
                          isSenha: true,
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 150.0, end: 150.0, bottom: 10.0, top: 10.0),
                        child: MainButton(
                          text: 'Salvar',
                          onPressed: _savePersonalData,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Redefinição de Senha', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 105.0, end: 100.0, bottom: 10.0, top: 10.0),
                        child: MainButton(
                          onPressed: _resetPassword,
                          text: 'Redefinir Senha',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(2),
                child: Padding(
                  padding: EdgeInsets.only(top: 2, bottom: 0, left: 107, right: 107),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Acessibilidade', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Padding(
                        padding: EdgeInsets.all(25.0),
                        child: DropdownButton<bool>(
                          value: _accessibilityEnabled,
                          items: [
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
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.all(10.0),
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