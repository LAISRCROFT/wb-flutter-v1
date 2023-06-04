// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key, Key? key});

//   static const String _title = 'Flutter Code Sample teste';

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: _title,
//       home: BookList(),
//     );
//   }
// }

// class BookList extends StatefulWidget {
//   const BookList({Key? key}) : super(key: key);

//   @override
//   State<BookList> createState() => _BookListState();
// }

// class _BookListState extends State<BookList> {
//   final BookService _bookService = BookService();
//   late Future<Map<String, dynamic>> _futureBooks;

//   @override
//   void initState() {
//     super.initState();
//     _futureBooks = _bookService.getBooks();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Lista de Livros'),
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: _futureBooks,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<dynamic> books = snapshot.data!['data'];

//             if (books.isEmpty) {
//               return const Center(
//                 child: Text('Nenhum livro encontrado'),
//               );
//             }

//             return ListView.builder(
//               itemCount: books.length,
//               itemBuilder: (context, index) {
//                 Map<String, dynamic> book = books[index];
//                 // Map<String, dynamic> book = TratarInformacoes( books[index] );

//                 return Card(
//                   child: ListTile(
//                     leading: Image.network(
//                       book['caminho_capa'],
//                       width: 50,
//                     ),
//                     title: Text(book['titulo']),
//                     subtitle: Text(
//                       '${book['nome_usuario']} (${book['apelido_usuario']})',
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BookDetails(
//                             bookId: book['id'],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Text('${snapshot.error}');
//           }

//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
// }

// class BookDetails extends StatefulWidget {
//   const BookDetails({Key? key, required this.bookId}) : super(key: key);

//   final int bookId;

//   @override
//   State<BookDetails> createState() => _BookDetailsState();
// }

// class _BookDetailsState extends State<BookDetails> {
//   final BookService _bookService = BookService();
//   late Future<Map<String, dynamic>> _futureBook;

//   @override
//   void initState() {
//     super.initState();
//     _futureBook = _bookService.getBook(widget.bookId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Detalhes do Livro'),
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: _futureBook,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             Map<String, dynamic> book = snapshot.data!['data'];

//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Image.network(
//                     book['caminho_capa'],
//                     width: 200,
//                   ),
//                   Text(book['titulo']),
//                   Text(
//                     '${book['nome_usuario']} (${book['apelido_usuario']})',
//                   ),
//                   Text(book['descricao']),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: book['capitulos'].length,
//                     itemBuilder: (context, index) {
//                       Map<String, dynamic> chapter = book['capitulos'][index];

//                       print(book['capitulos']);

//                       return ListTile(
//                         title: Text(chapter['titulo']),
//                         // subtitle: Text(chapter['descricao']),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => ChapterDetails(
//                                 chapterId: chapter['id'],
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Text('${snapshot.error}');
//           }

//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
// }

// class ChapterDetails extends StatefulWidget {
//   const ChapterDetails({Key? key, required this.chapterId}) : super(key: key);

//   final int chapterId;

//   @override
//   State<ChapterDetails> createState() => _ChapterDetailsState();
// }

// class _ChapterDetailsState extends State<ChapterDetails> {
//   final BookService _bookService = BookService();
//   late Future<Map<String, dynamic>> _futureChapter;

//   @override
//   void initState() {
//     super.initState();
//     _futureChapter = _bookService.getChapter(widget.chapterId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Detalhes do Capítulo'),
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: _futureChapter,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             Map<String, dynamic> chapter = snapshot.data!['data'];

//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Text(chapter['titulo']),
//                   Text(chapter['descricao']),
//                   Text(chapter['conteudo']),
//                 ],
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Text('${snapshot.error}');
//           }

//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
// }

// class BookService {
//   Future<Map<String, dynamic>> getBooks() async {
//     final String response =
//         await rootBundle.loadString('assets/data/books_list_data.json');

//     return jsonDecode(response);

//     // final response = await http.get(
//     //     Uri.parse('http://worldbooks.serratedevs.com.br/wbcore/public/api/historia/categoria/pesquisa?categoria_id=1'));

//     // if (response.statusCode == 200) {
//     //   return jsonDecode(response.body);
//     // } else {
//     //   throw Exception('Erro ao carregar os livros');
//     // }
//   }

//   Future<Map<String, dynamic>> getBook(int bookId) async {
//     final String response =
//         await rootBundle.loadString('assets/data/book_detailed_data.json');

//     return jsonDecode(response);

//     // final response = await http.get(
//     //     Uri.parse('http://worldbooks.serratedevs.com.br/wbcore/public/api/historia/$bookId'));

//     // if (response.statusCode == 200) {
//     //   return jsonDecode(response.body);
//     // } else {
//     //   throw Exception('Erro ao carregar o livro');
//     // }
//   }

//   Future<Map<String, dynamic>> getChapter(int chapterId) async {
//     final response = await http
//         .get(Uri.parse('http://localhost:8000/api/capitulos/$chapterId'));

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Erro ao carregar o capítulo');
//     }
//   }
// }
