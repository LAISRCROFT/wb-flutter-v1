import 'package:flutter/material.dart';
import 'package:worldbooks/categorias.dart';
import 'package:worldbooks/create_livro.dart';
import 'package:worldbooks/main.dart';
import '../palletes/pallete.dart';
import 'dart:io';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});
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
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Palette.WBColorShade50,
                  ),
                  child: Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/avatar/default.jpg'),
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
                        builder: (context) => CategoriasList(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 2), // Espaçamento entre os itens
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                SizedBox(height: 2),
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
                        builder: (context) => CreateLivro(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.19, 0, 0, 0),
            leading: Icon(
              Icons.logout,
              color: Color(0xfff98d85),
            ),
            title: Text(
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
                  builder: (context) => Login(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}