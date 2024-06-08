import 'package:flutter/material.dart';

class MeuModalWidget extends StatefulWidget {
  final void Function(String, String) onItemSelected; // Callback

  MeuModalWidget({required this.onItemSelected});

  @override
  _MeuModalWidgetState createState() => _MeuModalWidgetState();
}

class _MeuModalWidgetState extends State<MeuModalWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> alltimes = [
    {
      'nome': 'Flamengo',
      'escudoUrl':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Flamengo_braz_logo.svg/1200px-Flamengo_braz_logo.svg.png'
    },
    {
      'nome': 'Corinthians',
      'escudoUrl':
          'https://upload.wikimedia.org/wikipedia/pt/b/b4/Corinthians_simbolo.png'
    },
    {
      'nome': 'Santa Cruz',
      'escudoUrl':
          'https://upload.wikimedia.org/wikipedia/commons/6/6b/Santa_Cruz_Futebol_Clube_%281915-99%29.png'
    },
    {
      'nome': 'Palmeiras',
      'escudoUrl':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/10/Palmeiras_logo.svg/2048px-Palmeiras_logo.svg.png'
    },
    {
      'nome': 'São Paulo',
      'escudoUrl':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Brasao_do_Sao_Paulo_Futebol_Clube.svg/2054px-Brasao_do_Sao_Paulo_Futebol_Clube.svg.png'
    }
  ];

  List<Map<String, dynamic>> _foundUsers = [];

  @override
  void initState() {
    _foundUsers = List.from(alltimes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _exibirModal(context);
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  void _exibirModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 400,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _searchController,
                    onChanged: (query) {
                      setState(() {
                        _foundUsers = _filterUsers(query);
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Pesquisar',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  SizedBox(height: 10),
                  if (_foundUsers.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Nenhum time encontrado',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  Expanded(
                    child: _foundUsers.isEmpty
                        ? SizedBox() // Se a lista estiver vazia, não renderizar o ListView
                        : ListView.builder(
                            key: UniqueKey(),
                            itemCount: _foundUsers.length,
                            itemBuilder: (context, index) {
                              final user = _foundUsers[index];
                              return _criarItem(
                                  context, user['nome'], user['escudoUrl']);
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  List<Map<String, dynamic>> _filterUsers(String query) {
    List<Map<String, dynamic>> filteredUsers = [];
    if (query.isNotEmpty) {
      for (var user in alltimes) {
        final nome = user['nome'].toString().toLowerCase();
        if (nome.startsWith(query.toLowerCase())) {
          filteredUsers.add(user);
        }
      }
    } else {
      filteredUsers = List.from(alltimes);
    }
    return filteredUsers;
  }

  Widget _criarItem(BuildContext context, String nome, String escudoUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(nome),
        leading: Image.network(escudoUrl),
        onTap: () {
          widget.onItemSelected(nome, escudoUrl);
          Navigator.pop(context);
        },
      ),
    );
  }
}
