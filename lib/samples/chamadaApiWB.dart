import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BookList extends StatefulWidget {
  const BookList({Key? key}) : super(key: key);

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  final BookService _bookService = BookService();
  late Future<Map<String, dynamic>> _futureBooks;

  @override
  void initState() {
    super.initState();
    _futureBooks = _bookService.getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Livros'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _futureBooks,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> books = snapshot.data!['data'];

            if(books.isEmpty)
              return Center(
                child: Text('Nenhum livro encontrado'),
              );

            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                Map book = books[index];
                // Map book = TratarInformacoes( books[index] );

                return Card(
                  child: ListTile(
                    leading: Image.network(
                      book['caminho_capa'],
                      width: 50,
                    ),
                    title: Text(book['titulo']),
                    subtitle: Text(book['nome_usuario'] + "(" + book['apelido_usuario'] + ")"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetails(
                            book: book,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
  
  TratarInformacoes(book) {
    var bookTratado = new Map();

    for (var key in book.keys) {
      // print(key);
      // print(book[key]);
      bookTratado[key.toString()] = book[key] ?? '';
    }

    print(  bookTratado['id'] );

    return bookTratado;
  }
}

class BookService {
  Future<Map<String, dynamic>> getBooks() async {
    final response = await http.get(Uri.parse('http://worldbooks.serratedevs.com.br/wbcore/public/api/historia/categoria/pesquisa?categoria_id=2'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha ao carregar os livros');
    }
  }
}

class BookDetails extends StatelessWidget {
  final dynamic book;

  const BookDetails({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book['title']),
      ),
      body: Column(
        children: [
          Image.network(
            book['cover'],
            width: 200,
          ),
          Text(book['title']),
          Text(book['author']),
          Text(book['description']),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BookList(),
  ));
}
