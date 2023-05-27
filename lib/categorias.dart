import 'package:flutter/material.dart';
import 'dart:io';
import 'palletes/pallete.dart';
import 'models/Categorias.dart';
import 'package:intl/intl.dart';
import 'palletes/pallete.dart';
import 'livros.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

final String background_defaut = 'assets/images/cat_cover.jpg';

class CategoriasList extends StatefulWidget {
  @override
  State<CategoriasList> createState() => _CategoriasListState();
}

class _CategoriasListState extends State<CategoriasList> {
  late Future<Map<String, dynamic>> _categorias;

  Object? get livroId => null;

  Future<Map<String, dynamic>> getCategorias() async {
    final String response =
        await rootBundle.loadString('assets/data/categoria_data.json');

    return jsonDecode(response);

    // final response = await http.get(
    //     Uri.parse('http://worldbooks.serratedevs.com.br/wbcore/public/api/categoria'));

    // if (response.statusCode == 200) {
    //   return jsonDecode(response.body);
    // } else {
    //   throw Exception('Erro ao carregar os livros');
    // }
  }

  @override
  void initState() {
    super.initState();
    _categorias = getCategorias();
  }

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
        body: FutureBuilder<Map<String, dynamic>>(
          future: _categorias,
          builder: (context, snapshot) {
            // Contém os dados dos livros
            if (snapshot.hasData) {
              List<dynamic> categorias = snapshot.data!['data'];

              if (categorias.isEmpty) {
                return Center(
                  child: Text('Nenhuma categoria encontrada'),
                );
              }

              return ListView.builder(
                itemCount: categorias.length,
                itemBuilder: (ctx, index) {
                  Map<String, dynamic> categoria = categorias[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: Ink(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(categoria['bg_path_mobile'] != null
                              ? categoria['bg_path_mobile']
                              : background_defaut),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Livros(
                                categoria_id: categoria['id'],
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: 100,
                          child: ListTile(
                            title: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                categoria['genero'],
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            // Sem livros p/ categoria
            else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
