import 'package:flutter/material.dart';
import 'package:worldbooks/categorias.dart';
import 'package:worldbooks/create_livro.dart';
import 'package:worldbooks/main.dart';
import '../palletes/pallete.dart';

import '../global_data.dart';

class _SidebarState extends State<Sidebar> {
  bool _useDefaultImage = true;
  String _fotoPerfil = "assets/images/avatar/default.jpg";

  @override
  void initState() {
    super.initState();
    _changeFotoPerfil();
  }

  void _changeFotoPerfil() async {
    String fotoPerfil = GlobalData.getFotoPerfil();
    if (fotoPerfil != '') {
      setState(() {
        _fotoPerfil = fotoPerfil;
        _useDefaultImage = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Palette.WBColor.shade300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Palette.WBColorShade50,
                  ),
                  child: Center(
                    child: CircleAvatar(
                      backgroundImage: _useDefaultImage ? AssetImage(_fotoPerfil) : Image.network(_fotoPerfil).image,
                      radius: 50,
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.16, 0, 0, 0),
                  leading: Icon(
                    Icons.auto_stories,
                    color: Palette.WBColor.shade600,
                  ),
                  title: Text(
                    'INICIAR LEITURA',
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      color: Palette.WBColor.shade600,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoriasList(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 2), // Espaçamento entre os itens
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(height: 2),
                ListTile(
                  contentPadding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.12, 0, 0, 0),
                  leading: Icon(
                    Icons.border_color,
                    color: Palette.WBColor.shade600,
                  ),
                  title: Text(
                    'COMEÇAR A ESCREVER',
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      color: Palette.WBColor.shade600,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateLivro(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.19, 0, 0, 0),
            leading: const Icon(
              Icons.logout,
              color: Color(0xfff98d85),
            ),
            title: const Text(
              'LOGOUT',
              style: TextStyle(
                fontFamily: 'Ubuntu',
                color: Color(0xfff98d85),
                fontSize: 16,
                fontWeight: FontWeight.w100,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Login(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

}



class Sidebar extends StatefulWidget {
  const Sidebar({super.key});


  @override
  State<Sidebar> createState() => _SidebarState();

}