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
          automaticallyImplyLeading: true,
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

              return SafeArea(
                top: true,
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(-1, -0.1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                        ),
                        child: Image.network(
                          book['caminho_capa'],
                          width: 391,
                          height: 207,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Divider(
                          thickness: 1,
                        ),
                      ],
                    ),
                    Align(
                      alignment: AlignmentDirectional(-0.1, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0.05),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(-0.05, 0),
                                      child: Icon(
                                        Icons.visibility,
                                        // color: FlutterFlowTheme.of(context)
                                        //     .secondaryText,
                                        size: 24,
                                      ),
                                    ),
                                    Align(
                                        // alignment:
                                        //     AlignmentDirectional(0.05, 0.05),
                                        // child: SelectionArea(
                                        //   child: Text(
                                        //     '0',
                                        //     textAlign: TextAlign.end,
                                        //     maxLines: 1,

                                        //     style: FlutterFlowTheme.of(context)
                                        //         .headlineLarge
                                        //         .override(
                                        //           fontFamily: 'Ubuntu',
                                        //           fontSize: 20,
                                        //           letterSpacing: 10,
                                        //         ),
                                        //   ),
                                        // ),
                                        ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Column(
                          //   mainAxisSize: MainAxisSize.max,
                          //   children: [
                          //     Row(
                          //       mainAxisSize: MainAxisSize.max,
                          //       children: [
                          //         Icon(
                          //           Icons.star_outline,
                          //           // color:
                          //           //     FlutterFlowTheme.of(context).secondaryText,
                          //           size: 24,
                          //         ),
                          //         Flexible(
                          //           child: Align(
                          //             alignment:
                          //                 AlignmentDirectional(0.05, 0.05),
                          //             child: SelectionArea(
                          //                 child: Text(
                          //               '0',
                          //               textAlign: TextAlign.end,
                          //               maxLines: 1,
                          //               // style: FlutterFlowTheme.of(context)
                          //               //     .headlineLarge
                          //               //     .override(
                          //               //       fontFamily: 'Ubuntu',
                          //               //       fontSize: 20,
                          //               //       letterSpacing: 10,
                          //               //     ),
                          //             )),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                          // Column(
                          //   mainAxisSize: MainAxisSize.max,
                          //   children: [
                          //     Row(
                          //       mainAxisSize: MainAxisSize.max,
                          //       children: [
                          //         Icon(
                          //           Icons.list,
                          //           // color:
                          //           //     FlutterFlowTheme.of(context).secondaryText,
                          //           size: 24,
                          //         ),
                          //         Flexible(
                          //           child: Align(
                          //             alignment:
                          //                 AlignmentDirectional(0.05, 0.05),
                          //             child: SelectionArea(
                          //                 child: Text(
                          //               '0',
                          //               textAlign: TextAlign.end,
                          //               // style: FlutterFlowTheme.of(context)
                          //               //     .headlineLarge
                          //               //     .override(
                          //               //       fontFamily: 'Ubuntu',
                          //               //       fontSize: 20,
                          //               //       letterSpacing: 10,
                          //               //     ),
                          //             )),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
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
                            Map<String, dynamic> chapter =
                                book['capitulos'][index];

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
                    )
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
