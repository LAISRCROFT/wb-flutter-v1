import 'package:flutter/material.dart';
import 'palletes/pallete.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class LivroDetalhes extends StatefulWidget {
  const LivroDetalhes({Key? key, required this.livro_id}) : super(key: key);

  final int livro_id;
  _LivroDetalhesState createState() => _LivroDetalhesState();
}

class _LivroDetalhesState extends State<LivroDetalhes> {
  final BookService _bookService = BookService();
  late Future<Map<String, dynamic>> _futureBook;

  @override
  void initState() {
    super.initState();
    _futureBook = _bookService.getBook(widget.livro_id);
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
          title: FutureBuilder<Map<String, dynamic>>(
            future: _futureBook, // a previously-obtained Future<String> or null
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> book = snapshot.data!['data'];

                return Text(
                  '${book['titulo']}',
                  style: TextStyle(fontFamily: 'Ubuntu'),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: _futureBook,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> book = snapshot.data!['data'];

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(
                      book['caminho_capa'],
                      width: 200,
                    ),
                    Text(book['titulo']),
                    Text(
                      '${book['nome_usuario']} (${book['apelido_usuario']})',
                    ),
                    Text(book['descricao']),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: book['capitulos'].length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> chapter = book['capitulos'][index];

                        print(book['capitulos']);

                        return ListTile(
                          title: Text(chapter['titulo']),
                          // subtitle: Text(chapter['descricao']),
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => ChapterDetails(
                            //       chapterId: chapter['id'],
                            //     ),
                            //   ),
                            // );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
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

class BookService {
  Future<Map<String, dynamic>> getBook(int bookId) async {
    final String response =
        await rootBundle.loadString('assets/data/book_detailed_data.json');

    return jsonDecode(response);

    // final response = await http.get(
    //     Uri.parse('http://worldbooks.serratedevs.com.br/wbcore/public/api/historia/$bookId'));

    // if (response.statusCode == 200) {
    //   return jsonDecode(response.body);
    // } else {
    //   throw Exception('Erro ao carregar o livro');
    // }
  }

  // Future<Map<String, dynamic>> getChapter(int chapterId) async {
  //   final response = await http
  //       .get(Uri.parse('http://localhost:8000/api/capitulos/$chapterId'));

  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('Erro ao carregar o capítulo');
  //   }
  // }
}
