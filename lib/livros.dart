import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'palletes/pallete.dart';
import 'detalhe_livro.dart';
import 'components/Sidebar.dart';

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
    Dio dio = Dio();

    final response = await dio.get('https://worldbooks.serratedevs.com.br/wbcore/public/api/historia/categoria/pesquisa?categoria_id=${widget.categoria_id}');

    var categoriasResponse;

    if (response.statusCode == 200) {

      categoriasResponse = response.data;
    } else {
      throw Exception('Erro ao carregar os livros');
    }
    
    // final String response =
    //     await rootBundle.loadString('assets/data/books_list_data.json');
    // var categoriasResponse = jsonDecode(response);

    List<dynamic> categoriasLivros = [];
    for (var i = 0; i < categoriasResponse['data'].length; i++) {
      if (categoriasResponse['data'][i]['categoria_id'] == widget.categoria_id) {
        categoriasLivros.add(categoriasResponse['data'][i]);
      }
    }

    return categoriasLivros;
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
            style: const TextStyle(
              fontFamily: 'Ubuntu',
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xffffffff)),
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
                          margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
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
                                  SizedBox(
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
                                  const SizedBox(width: 8),
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
                                          const SizedBox(height: 4),
                                          Text(
                                            '${livro['nome_usuario']} (${livro['apelido_usuario']})',
                                            style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              fontSize: 12,
                                              color: Palette.WBColor.shade200,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
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
                                          const SizedBox(height: 10),
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
                                                    visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                                    labelPadding: const EdgeInsets.fromLTRB(2, -4, 2, -4),
                                                    backgroundColor: Palette.WBColor.shade700,
                                                    labelStyle: const TextStyle(
                                                      fontFamily: 'Ubuntu',
                                                      fontSize: 11,
                                                    ),
                                                  );
                                                },
                                              )..addAll([
                                                if (livro['tags'].length > 4)
                                                  Text(
                                                    " +${livro['tags'].length - 4}",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                              ]),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
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
                                                const SizedBox(width: 10), // Espaço vertical entre as colunas
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
                                                const SizedBox(width: 10), // Espaço vertical entre as colunas
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
        endDrawer: const Sidebar(),
      ),
    );
  }
}
