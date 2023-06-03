import 'package:flutter/material.dart';
import 'package:worldbooks/categorias.dart';
import '../palletes/pallete.dart';
import 'package:flutter/services.dart';
import 'components/Sidebar.dart';
import 'models/Categorias.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';

class ReadChapter extends StatefulWidget {
  const ReadChapter({Key? key, required this.chapterId}) : super(key: key);

  final int chapterId;
  _ReadChapterState createState() => _ReadChapterState();
}

class _ReadChapterState extends State<ReadChapter> {
  final ChapterService _chapterService = ChapterService();
  late Future<Map<String, dynamic>> _futureChapter;
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    _futureChapter = _chapterService.getBook(widget.chapterId);
    print('livro: ${widget.chapterId}');
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xffffffff)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: _futureChapter,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> chapter = snapshot.data!['data'];

              chapter['capitulo'] = '<p class="estilo-padrao" style="color: ${Colors.white} !important">${chapter['capitulo']}<p>';

              String texto = "color: rgb(45, 55, 72)";
              RegExp padrao = RegExp(r"rgb\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)");

              chapter['capitulo'] = chapter['capitulo'].replaceAllMapped(padrao, (match) {
                return "rgb (255, 255, 255)";
              });

              Match? corRgb = padrao.firstMatch(texto);

              if (corRgb != null) {
                String valorR = corRgb.group(1)!;
                String valorG = corRgb.group(2)!;
                String valorB = corRgb.group(3)!;
                print("Valores RGB: R=$valorR, G=$valorG, B=$valorB");
              } else {
                print("Não foi encontrado um valor RGB.");
              }

              return SafeArea(
                top: true,
                child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * 0.3,
                            color: Colors.grey, // Cor de fundo da imagem vazia
                            child: imageUrl.isNotEmpty
                            ? Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [Icon(Icons.photo_camera)],
                              ),
                          ),
                        ],
                      ),
                      SizedBox(height: 22),
                      Align(
                        alignment: Alignment.center,
                        child: Text(chapter['titulo'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Palette.WBColor.shade800, 
                              fontSize: 20,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      SizedBox(height: 22),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Html(
                          data: chapter['capitulo'],
                          style: {
                            "body": Style(
                              color: Palette.WBColor.shade800,
                              fontSize: FontSize(15),
                              fontFamily: 'Ubuntu',
                            ),
                            "span": Style(
                              color: Palette.WBColor.shade800,
                              fontSize: FontSize(15),
                              fontFamily: 'Ubuntu',
                            ),
                          },
                        ),
                      ),
                      SizedBox(height: 22),
                    ]),
              );
            } else if (snapshot.hasError) {
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

class ChapterService {
  Future<Map<String, dynamic>> getBook(int bookId) async {
    // final String response =
    //     await rootBundle.loadString('assets/data/book_detailed_data.json');

    // return jsonDecode(response);

    final response = await http.get(Uri.parse(
        'https://worldbooks.serratedevs.com.br/wbcore/public/api/capitulo/$bookId'));

    if (response.statusCode == 200) {
      print('Response: ${jsonDecode(response.body)}');
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao carregar o livro');
    }
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
