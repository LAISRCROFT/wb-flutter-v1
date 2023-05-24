import 'package:flutter/material.dart';
import 'package:worldbooks/models/Livro.dart';
import 'dart:io';
import 'palletes/pallete.dart';
import 'models/Categorias.dart';
import 'detalhe_livro.dart';
import 'package:intl/intl.dart';
import 'palletes/pallete.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class Livros extends StatefulWidget {
  final livroId;

  Livros(this.livroId);

  @override
  State<Livros> createState() => _LivrosState();
}

class _LivrosState extends State<Livros> {
  late Future<Map<String, dynamic>> _livros;

  Object? get livroId => null;

  Future<Map<String, dynamic>> getBooks() async {
    final String response =
        await rootBundle.loadString('assets/data/books_list_data.json');
    print(this.livroId);
    return jsonDecode(response);
  }

  @override
  void initState() {
    super.initState();
    _livros = getBooks();
    // print("livro id:  ${this.livroId}");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Palette.WBColor.shade50,
          title: Text(
            'LIVROS',
            style: TextStyle(fontFamily: 'Ubuntu'),
          ),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: _livros,
          builder: (context, snapshot) {
            // Contém os dados dos livros
            if (snapshot.hasData) {
              List<dynamic> livros = snapshot.data!['data'];

              if (livros.isEmpty) {
                return Center(
                  child: Text('Nenhum livro encontrado'),
                );
              }

              return ListView.builder(
                itemCount: livros.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> livro = livros[index];
                  // Map<String, dynamic> book = TratarInformacoes( books[index] );

                  return Card(
                    elevation: 2,
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LivroDetalhes(
                              livro_id: livro['id'],
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Image.network(
                          livro['caminho_capa'],
                          width: 50,
                        ),
                        title: Text(livro['titulo']),
                        subtitle: Text(
                          '${livro['nome_usuario']} (${livro['apelido_usuario']})',
                        ),
                        // onTap: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => BookDetails(
                        //         bookId: book['id'],
                        //       ),
                        //     ),
                        //   );
                        // },
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
