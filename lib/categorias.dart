import 'package:flutter/material.dart';
import 'dart:io';
import 'palletes/pallete.dart';
import 'models/Categorias.dart';
import 'package:intl/intl.dart';
import 'palletes/pallete.dart';

final String background_defaut = 'assets/images/cat_cover.jpg';

class CategoriasList extends StatelessWidget {
  final List<Categoria> categorias = [
    Categoria(
        id: '1',
        title: 'Terror',
        background: "assets/images/categorias/terror.png"),
    Categoria(
        id: '2',
        title: 'Romance',
        background: 'assets/images/categorias/romance.png'),
    Categoria(
        id: '3',
        title: 'Ação',
        background: 'assets/images/categorias/acao.png'),
    Categoria(
        id: '4',
        title: 'Mistério',
        background: 'assets/images/categorias/misterio.png'),
    Categoria(
        id: '5',
        title: 'Ficção Científica',
        background: 'assets/images/categorias/ficcao_cientifica.png'),
    Categoria(
        id: '6',
        title: 'Fantasia',
        background: 'assets/images/categorias/fantasia.png'),
    Categoria(
        id: '7',
        title: 'Comédia',
        background: 'assets/images/categorias/comedia.png'),
    Categoria(
        id: '8',
        title: 'Drama',
        background: 'assets/images/categorias/drama.png'),
    Categoria(
        id: '9',
        title: 'Suspense',
        background: 'assets/images/categorias/suspense.png'),
    Categoria(
        id: '10',
        title: 'Aventura',
        background: 'assets/images/categorias/aventura.png'),
  ];

  // CategoriasList(this.categorias);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Palette.WBColor.shade50,
          title: Text(
            'CATEGORIAS',
            style: TextStyle(fontFamily: 'Ubuntu'),
          ),
        ),
        body: ListView.builder(
          itemCount: categorias.length,
          itemBuilder: (ctx, index) {
            final tr = categorias[index];
            return Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(tr.background),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SizedBox(
                  height: 100,
                  child: ListTile(
                    title: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        tr.title,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

    // ListView.builder(
    //   itemCount: categorias.length,
    //   itemBuilder: (ctx, index) {
    //     final tr = categorias[index];
    //     return Card(
    //       elevation: 3,
    //       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
    //       child: ListTile(
    //         title: Text(
    //           tr.title,
    //           style: Theme.of(context).textTheme.headline6,
    //         ),
    //       ),
    //     );
    //   },
    // )
  }
}
