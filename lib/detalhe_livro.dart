import 'package:flutter/material.dart';
import 'palletes/pallete.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'livros.dart';
import 'models/Livro.dart';

class LivroDetalhes extends StatefulWidget {
  const LivroDetalhes({Key? key, required this.livro_id, required this.livro}) : super(key: key);

  final int livro_id;
  final Map<String, dynamic> livro;
  _LivroDetalhesState createState() => _LivroDetalhesState();
}

class _LivroDetalhesState extends State<LivroDetalhes> {
  final BookService _bookService = BookService();
  late Future<Map<String, dynamic>> _futureBook;
  final bool? _api = true;
  final int _api2 = 1;
  

  @override
  void initState() {
    super.initState();
    _futureBook = _bookService.getBook(widget.livro_id);
    print('livro: ${widget.livro}');
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
          automaticallyImplyLeading: true,
          backgroundColor: Palette.WBColor.shade50,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xffffffff)),
            onPressed: () => Navigator.of(context).pop(),
          ),
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
        body: 
          _api2 == 1 
          ? SafeArea(
            top: true,
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: [
                SizedBox(height: 16),
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
                      widget.livro['caminho_capa'],
                      width: 391,
                      height: 207,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Divider(
                      thickness: 1,
                      color: Palette.WBColor.shade300,
                      indent: 20,
                      endIndent: 20
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-0.05, 0),
                                  child: Icon(
                                    Icons.visibility,
                                    size: 24,
                                    color: Palette.WBColor.shade200,
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.05, 0.05),
                                  child: SelectionArea(
                                    child: Text(
                                      (widget.livro['total_visualizacoes']).toString(),
                                      textAlign: TextAlign.end,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontFamily: 'Ubuntu',
                                        fontSize: 20,
                                        letterSpacing: 1,
                                        color: Palette.WBColor.shade800,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.star_outline,
                                // color:
                                //     FlutterFlowTheme.of(context).secondaryText,
                                size: 24,
                                color: Palette.WBColor.shade200,
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.05, 0.05),
                                child: SelectionArea(
                                  child: Text(
                                    (widget.livro['total_votos']).toString(),
                                    textAlign: TextAlign.end,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontSize: 20,
                                      letterSpacing: 1,
                                      color: Palette.WBColor.shade800,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.list,
                                color: Palette.WBColor.shade200,
                                size: 24,
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.05, 0.05),
                                child: SelectionArea(
                                  child: Text(
                                    (widget.livro['total_capitulos']).toString(),
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontSize: 20,
                                      letterSpacing: 1,
                                      color: Palette.WBColor.shade800,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        label: Text("INICIAR LEITURA"),
                        icon: Icon(
                          Icons.menu_book_sharp,
                          size: 15,
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(
                              MediaQuery.of(context).size.width - 100, 40),
                          padding:
                              EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          primary: Palette.WBColor.shade50,
                          textStyle: TextStyle(
                            fontFamily: 'Ubuntu',
                            color: Colors.white,
                          ),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(0),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-0.2, -0.1),
                        child: Ink(
                          decoration: BoxDecoration(
                            // border: Border.all(width: 0),
                            color: Palette.WBColor.shade50,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(8),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Icon(
                                Icons.add,
                                color: Palette.WBColor.shade600,
                                size: 23,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: 147,
                            height: 22,
                            decoration: BoxDecoration(
                              color: Palette.WBColor.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment:
                                AlignmentDirectional(0, 0.3999999999999999),
                            child: Text(
                              widget.livro['historia_finalizada'] == 0
                                  ? 'Concluída'
                                  : 'Em andamento',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                color: Palette.WBColor.shade600,
                              ),
                              // style:
                              //     FlutterFlowTheme.of(context).bodyMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.4, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              width: 154,
                              height: 22,
                              decoration: BoxDecoration(
                                color: Palette.WBColor.shade50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: AlignmentDirectional(
                                  -0.19999999999999996, 0.3999999999999999),
                              child: Text(
                                widget.livro['conteudo_adulto'] == 0
                                    ? 'Conteúdo adulto'
                                    : 'Conteúdo livre',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  color: Palette.WBColor.shade600,
                                ),
                                // style:
                                //     FlutterFlowTheme.of(context).bodyMedium,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.livro['apelido_usuario'],
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w300,
                        color: Palette.WBColor.shade800,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 9),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Text(
                            widget.livro['descricao'],
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontFamily: 'Ubuntu',
                              color: Palette.WBColor.shade200,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: Icon(
                        Icons.copyright,
                        color: Palette.WBColor.shade800,
                        size: 16,
                      ),
                    ),
                    Text(
                      widget.livro['direito_autoral'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Palette.WBColor.shade800,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Align(
                  alignment: Alignment.center,
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 3,
                    alignment: WrapAlignment.center,
                    children: List.generate(
                      widget.livro['tags'].length, (index) {
                        String tag = widget.livro['tags'][index];
                        return Chip(
                          label: Text(tag),
                          backgroundColor: Palette.WBColor.shade700,
                          labelStyle: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 100,
                  height: 28,
                  decoration: BoxDecoration(
                    // color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  alignment: AlignmentDirectional(0, 0.050000000000000044),
                  child: Text(
                    'ÍNDICE',
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 20,
                      fontWeight: FontWeight.w100,
                      color: Palette.WBColor.shade800
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: widget.livro['capitulos'] != null && widget.livro['capitulos'].isNotEmpty
                      ? List.generate(
                          widget.livro['capitulos'].length,
                          (index) {
                            Map<String, dynamic> capitulo = widget.livro['capitulos'][index];
                            return Wrap(
                              children: [
                                Divider(
                                  thickness: 1,
                                  color: Palette.WBColor.shade700,
                                ),
                                Ink(
                                  child: InkWell(
                                    splashColor: Colors.purple.withAlpha(30),
                                    onTap: () {},
                                    child: ListTile(
                                      title: Text(
                                        "Capítulo ${index + 1}",
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 20,
                                          color: Palette.WBColor.shade800,
                                          // fontWeight: FontWeight.w100,
                                        ),
                                      ),
                                      subtitle: Text(
                                        capitulo['titulo'],
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          color: Palette.WBColor.shade200,
                                        ),
                                      ),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Palette.WBColor.shade300,
                                        size: 20,
                                      ),
                                      dense: false,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                      : [
                          SizedBox(height: 15),
                          Text(
                            "Essa história não possui capítulos",
                            style: TextStyle(
                              color: Palette.WBColor.shade200,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                ),
              ],
            ),
          )

          : FutureBuilder<Map<String, dynamic>>(
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
                            color: Palette.WBColor.shade200,
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
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(-0.05, 0),
                                        child: Icon(
                                          Icons.visibility,
                                          size: 24,
                                          color: Palette.WBColor.shade200,
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0.05, 0.05),
                                        child: SelectionArea(
                                          child: Text(
                                            (book['total_visualizacoes']).toString(),
                                            textAlign: TextAlign.end,
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              fontSize: 20,
                                              letterSpacing: 1,
                                              color: Palette.WBColor.shade800,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.star_outline,
                                      // color:
                                      //     FlutterFlowTheme.of(context).secondaryText,
                                      size: 24,
                                      color: Palette.WBColor.shade200,
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0.05, 0.05),
                                      child: SelectionArea(
                                        child: Text(
                                          (book['total_votos']).toString(),
                                          textAlign: TextAlign.end,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            fontSize: 20,
                                            letterSpacing: 1,
                                            color: Palette.WBColor.shade800,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.list,
                                      color: Palette.WBColor.shade200,
                                      size: 24,
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0.05, 0.05),
                                      child: SelectionArea(
                                        child: Text(
                                          (book['total_capitulos']).toString(),
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            fontSize: 20,
                                            letterSpacing: 1,
                                            color: Palette.WBColor.shade800,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                print('Button pressed ...');
                              },
                              label: Text("INICIAR LEITURA"),
                              icon: Icon(
                                Icons.menu_book_sharp,
                                size: 15,
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width - 100, 40),
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                primary: Palette.WBColor.shade50,
                                textStyle: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  color: Colors.white,
                                ),
                                elevation: 0,
                                // side: BorderSide(
                                //   color: Colors.transparent,
                                //   width: 1,
                                // ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(0),
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(0),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-0.2, -0.1),
                              child: Ink(
                                decoration: BoxDecoration(
                                  // border: Border.all(width: 0),
                                  color: Palette.WBColor.shade50,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(8),
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(8),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: Icon(
                                      Icons.add,
                                      color: Palette.WBColor.shade600,
                                      size: 23,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  width: 147,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    color: Palette.WBColor.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  alignment:
                                      AlignmentDirectional(0, 0.3999999999999999),
                                  child: Text(
                                    book['historia_finalizada']
                                        ? 'Concluída'
                                        : 'Em andamento',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      color: Palette.WBColor.shade600,
                                    ),
                                    // style:
                                    //     FlutterFlowTheme.of(context).bodyMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.4, 0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    width: 154,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      color: Palette.WBColor.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    alignment: AlignmentDirectional(
                                        -0.19999999999999996, 0.3999999999999999),
                                    child: Text(
                                      book['conteudo_adulto']
                                          ? 'Conteúdo adulto'
                                          : 'Conteúdo livre',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Ubuntu',
                                        color: Palette.WBColor.shade600,
                                      ),
                                      // style:
                                      //     FlutterFlowTheme.of(context).bodyMedium,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(book['apelido_usuario'],
                            style: TextStyle(
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w300,
                              color: Palette.WBColor.shade800,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 9),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: Text(
                                  book['descricao'],
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    color: Palette.WBColor.shade200,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                            child: Icon(
                              Icons.copyright,
                              color: Palette.WBColor.shade800,
                              size: 16,
                            ),
                          ),
                          Text(
                            book['direito_autoral'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Palette.WBColor.shade800,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Align(
                        alignment: Alignment.center,
                        child: Wrap(
                          spacing: 5,
                          runSpacing: 3,
                          alignment: WrapAlignment.center,
                          children: List.generate(
                            book['tags'].length, (index) {
                              String tag = book['tags'][index];
                              return Chip(
                                label: Text(tag),
                                backgroundColor: Palette.WBColor.shade700,
                                labelStyle: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 12,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 100,
                        height: 28,
                        decoration: BoxDecoration(
                          // color: FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        alignment: AlignmentDirectional(0, 0.050000000000000044),
                        child: Text(
                          'ÍNDICE',
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 20,
                            fontWeight: FontWeight.w100,
                            color: Palette.WBColor.shade800
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(
                          book['capitulos'].length,
                          (index) {
                            Map<String, dynamic> capitulo =
                                book['capitulos'][index];
                            return Wrap(
                              children: [
                                Divider(
                                  thickness: 1,
                                  color: Palette.WBColor.shade700,
                                ),
                                Ink(
                                  child: InkWell(
                                    splashColor: Colors.purple.withAlpha(30),
                                    onTap: () {},
                                    child: ListTile(
                                      title: Text(
                                        "Capítulo ${index + 1}",
                                        style: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            fontSize: 20,
                                            color: Palette.WBColor.shade800
                                            // fontWeight: FontWeight.w100,
                                            ),
                                      ),
                                      subtitle: Text(
                                        capitulo['titulo'],
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          color: Palette.WBColor.shade200,
                                        ),
                                      ),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Palette.WBColor.shade300,
                                        size: 20,
                                      ),
                                      // tileColor:
                                      //     FlutterFlowTheme.of(context).secondaryBackground,
                                      dense: false,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     Text(book['titulo']),
                  //     Text(
                  //       '${book['nome_usuario']} (${book['apelido_usuario']})',
                  //     ),
                  //     Text(book['descricao']),
                  //     ListView.builder(
                  //       shrinkWrap: true,
                  //       physics: NeverScrollableScrollPhysics(),
                  //       itemCount: book['capitulos'].length,
                  //       itemBuilder: (context, index) {
                  //         Map<String, dynamic> chapter =
                  //             book['capitulos'][index];

                  //         print(book['capitulos']);

                  //         return ListTile(
                  //           title: Text(chapter['titulo']),
                  //           // subtitle: Text(chapter['descricao']),
                  //           onTap: () {
                  //             // Navigator.push(
                  //             //   context,
                  //             //   MaterialPageRoute(
                  //             //     builder: (context) => ChapterDetails(
                  //             //       chapterId: chapter['id'],
                  //             //     ),
                  //             //   ),
                  //             // );
                  //           },
                  //         );
                  //       },
                  //     ),
                  //   ],
                  // )
                  // ],
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
