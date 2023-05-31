import 'package:flutter/material.dart';
import 'package:worldbooks/models/Livro.dart';
import 'dart:io';
import 'palletes/pallete.dart';
import 'models/Categorias.dart';
import 'detalhe_livro.dart';
import 'package:intl/intl.dart';
import 'palletes/pallete.dart';
import 'components/Sidebar.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'categorias.dart';

class Livros extends StatefulWidget {
  const Livros(
      {Key? key, required this.categoria_id, required this.nome_categoria})
      : super(key: key);

  final int categoria_id;
  final String nome_categoria;

  @override
  State<Livros> createState() => _LivrosState();
}

class _LivrosState extends State<Livros> {
  late Future<List<dynamic>> _livros;

  Object? get livroId => null;

  Future<List<dynamic>> getBooks() async {
    final String response =
        await rootBundle.loadString('assets/data/books_list_data.json');
    var categorias_response = jsonDecode(response);

    List<dynamic> categorias_livros = [];
    for (var i = 0; i < categorias_response['data'].length; i++) {
      if (categorias_response['data'][i]['categoria_id'] == widget.categoria_id) {
        categorias_livros.add(categorias_response['data'][i]);
      }
    }

    return categorias_livros;
  }

  @override
  void initState() {
    super.initState();
    _livros = getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Palette.WBColor.shade400,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Palette.WBColor.shade50,
          title: Text(
            'LIVROS DE ${widget.nome_categoria}',
            style: TextStyle(
              fontFamily: 'Ubuntu',
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xffffffff)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: _livros,
          builder: (context, snapshot) {
            // Contém os dados dos livros
            if (snapshot.hasData) {
              List<dynamic> livros = snapshot.data!;

              if (livros.isEmpty) {
                return Center(
                  child: Text('Nenhum livro encontrado nessa categoria',
                    style: TextStyle(
                      color: Palette.WBColor.shade200
                    )
                  ),
                );
              }

              return ListView.builder(
                itemCount: livros.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> livro = livros[index];

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Card(
                          elevation: 0,
                          margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                          color: Palette.WBColor.shade400,
                          child: InkWell(
                            splashColor: Colors.purple.withAlpha(30),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LivroDetalhes(
                                    livro_id: livro['id'],
                                    livro: livros[index],
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.25,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(3),
                                      child: Image.network(
                                        livro['caminho_capa'],
                                        width: MediaQuery.of(context).size.width * 0.25,
                                        height: MediaQuery.of(context).size.height * 0.20,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            livro['titulo'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.w100,
                                              fontFamily: 'Ubuntu',
                                              color: Palette.WBColor.shade800,
                                              fontSize: 17
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            '${livro['nome_usuario']} (${livro['apelido_usuario']})',
                                            style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              fontSize: 12,
                                              color: Palette.WBColor.shade200,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            '${livro['descricao']}',
                                            style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              color: Palette.WBColor.shade700,
                                              height: 1.1,
                                              fontSize: 12,
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 10),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Wrap(
                                              spacing: 2,
                                              runSpacing: 0,
                                              alignment: WrapAlignment.start,
                                              children: List.generate(
                                                livro['tags'].take(4).length, (index) {
                                                  String tag = livro['tags'][index];
                                                  return Chip(
                                                    label: Text(tag),
                                                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                                    labelPadding: EdgeInsets.fromLTRB(2, -4, 2, -4),
                                                    backgroundColor: Palette.WBColor.shade700,
                                                    labelStyle: TextStyle(
                                                      fontFamily: 'Ubuntu',
                                                      fontSize: 11,
                                                    ),
                                                  );
                                                },
                                              )..addAll([
                                                if (livro['tags'].length > 4)
                                                  Text(
                                                    " +${livro['tags'].length - 4}",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                              ]),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Icon(
                                                          Icons.visibility,
                                                          size: 17,
                                                          color: Palette.WBColor.shade200,
                                                        ),
                                                        Text(
                                                          (livro['total_visualizacoes']).toString(),
                                                          textAlign: TextAlign.end,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            fontFamily: 'Ubuntu',
                                                            fontSize: 12,
                                                            letterSpacing: 1,
                                                            color: Palette.WBColor.shade200,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(width: 10), // Espaço vertical entre as colunas
                                                Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        Icon(
                                                          Icons.star_outline,
                                                          size: 17,
                                                          color: Palette.WBColor.shade200,
                                                        ),
                                                        Text(
                                                          (livro['total_votos']).toString(),
                                                          textAlign: TextAlign.end,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            fontFamily: 'Ubuntu',
                                                            fontSize: 12,
                                                            letterSpacing: 1,
                                                            color: Palette.WBColor.shade200,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(width: 10), // Espaço vertical entre as colunas
                                                Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        Icon(
                                                          Icons.list,
                                                          size: 17,
                                                          color: Palette.WBColor.shade200,
                                                        ),
                                                        Text(
                                                          (livro['total_capitulos']).toString(),
                                                          textAlign: TextAlign.end,
                                                          style: TextStyle(
                                                            fontFamily: 'Ubuntu',
                                                            fontSize: 12,
                                                            letterSpacing: 1,
                                                            color: Palette.WBColor.shade200,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
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
                        ),
                      ),
                      Divider(
                        height: 1, 
                        color: Palette.WBColor.shade300,
                        indent: 10,
                        endIndent: 10,
                      ), // Divisor aqui
                    ],
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
        endDrawer: Sidebar(),
      ),
    );
  }
}
