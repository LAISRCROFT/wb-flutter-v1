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

class CreateCapitulo extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
        body: CreateChapter(formKey: formKey),
        endDrawer: Sidebar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (formKey.currentState?.validate() ?? false) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('Capítulo postado com sucesso!'),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoriasList(),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                maximumSize: MaterialStateProperty.all(const Size(250, 45)),
                                // padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: _padding_form)),
                                backgroundColor:MaterialStateProperty.all(Palette.WBColor.shade50),
                                textStyle: MaterialStateProperty.all(
                                  const TextStyle(fontFamily: 'Ubuntu'),
                                ),
                              ),
                              child: const Text(
                                'Sair',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Ubuntu'
                                )
                              ),
                            ),
                            SizedBox(width: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
          backgroundColor: Palette.WBColor.shade50,
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}

class CreateChapter extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  CreateChapter({required this.formKey});
  @override
  _CreateChapterState createState() => _CreateChapterState();
}

class _CreateChapterState extends State<CreateChapter> {
  String imageUrl = '';
  TextEditingController titulo = TextEditingController();
  TextEditingController capitulo = TextEditingController();
  // final _etEditor = await keyEditor.currentState.getText();
  // QuillController _controller = QuillController.basic();

  @override
  void initState() {
    super.initState();
    capitulo.text = "Era uma vez...";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: ListView(
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
                    children: [
                      Icon(
                        Icons.photo_camera
                      )
                    ],
                  ),
              ),
            ],
          ),
          SizedBox(height: 22),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              controller: titulo,
              textAlign: TextAlign.start,
              style: TextStyle(
                color:Colors.white,
              ),
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                labelText: 'Título do capítulo',
                fillColor: Palette.Inputs.shade50,
                labelStyle: TextStyle(
                  color: Palette.Inputs.shade50,
                  fontFamily: 'Ubuntu',
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Palette.Inputs.shade50,
                    width: 2.0,
                  ),
                ),
                contentPadding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.3, 0, 0, 0),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Palette.InputsShade50,
                    width: 2.0,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Título é obrigatório';
                }
                return null;
              },
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: capitulo,
                  style: TextStyle(
                    color: Colors.white, // Defina a cor do texto enquanto você escreve
                  ),
                  maxLines: null,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    // labelText: 'Conteúdo do capítulo',
                    filled: false,
                    fillColor: Palette.Inputs.shade100,
                    labelStyle: TextStyle(color: Palette.Inputs.shade50),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent, width: 1),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Escreva o seu capítulo';
                    }
                    return null;
                  },
                  autofocus: true,
                ),
              ),
            ]
          ),
          SizedBox(height: 22),
        ]
      ),
    );
  }
}