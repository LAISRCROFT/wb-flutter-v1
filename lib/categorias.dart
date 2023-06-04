import 'package:flutter/material.dart';
import 'palletes/pallete.dart';
import 'components/Sidebar.dart';
import 'livros.dart';

import 'package:dio/dio.dart';

const String background_defaut = 'assets/images/cat_cover.jpg';

class CategoriasList extends StatefulWidget {
  const CategoriasList({super.key});

  @override
  State<CategoriasList> createState() => _CategoriasListState();
}

class _CategoriasListState extends State<CategoriasList> {
  late Future<Map<String, dynamic>> _categorias;

  Object? get livroId => null;

  Future<Map<String, dynamic>> getCategorias() async {
    Dio dio = Dio();

    final response = await dio.get('https://worldbooks.serratedevs.com.br/wbcore/public/api/categoria');

    if (response.statusCode == 200) {

      return response.data;
    } else {
      throw Exception('Erro ao carregar os livros');
    }
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
        backgroundColor: Palette.WBColor.shade400,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Palette.WBColor.shade50,
          elevation: 0,
          title: const Text(
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

              // print("Categorias : "+ categorias.toString()) ;

              if (categorias.isEmpty) {
                return const Center(
                  child: Text('Nenhuma categoria encontrada'),
                );
              }

              categorias.sort((a, b) => a['genero'].toString().compareTo(b['genero'].toString()));

              return ListView.builder(
                itemCount: categorias.length,
                itemBuilder: (ctx, index) {
                  Map<String, dynamic> categoria = categorias[index];
                  return Card(
                    color: Colors.transparent,
                    elevation: 0,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Palette.WBColor.shade200),
                        image: DecorationImage(
                          image: AssetImage(categoria['bg_path_mobile'] ?? background_defaut),
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0), BlendMode.dstATop),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: InkWell(
                        splashColor: Colors.purple.withAlpha(30),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Livros(
                                categoria_id: categoria['id'],
                                nome_categoria: categoria['genero'],
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
                                    color: Palette.WBColor.shade200),
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
        endDrawer: const Sidebar(),
      ),
    );
  }
}
