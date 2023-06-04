import 'dart:ffi' as ffi;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:worldbooks/categorias.dart';
import 'package:worldbooks/global_data.dart';
import '../palletes/pallete.dart';
import 'components/Sidebar.dart';

class CreateCapitulo extends StatefulWidget {
  int livro_id = 0;

  CreateCapitulo({super.key, required this.livro_id});

  @override
  State<CreateCapitulo> createState() => _CreateCapituloState();
}

class _CreateCapituloState extends State<CreateCapitulo> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String imageUrl = '';

  TextEditingController titulo = TextEditingController();
  TextEditingController capitulo = TextEditingController();

  @override
  void initState() {
    super.initState();
    capitulo.text = "Era uma vez...";
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
            icon: const Icon(Icons.arrow_back, color: Color(0xffffffff)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Form(
          key: formKey,
          child: ListView(children: [
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
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [Icon(Icons.photo_camera)],
                        ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: titulo,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintStyle: const TextStyle(color: Colors.white),
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
                  contentPadding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.3, 0, 0, 0),
                  focusedBorder: const UnderlineInputBorder(
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
            Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: capitulo,
                  style: const TextStyle(
                    color: Colors
                        .white, // Defina a cor do texto enquanto você escreve
                  ),
                  maxLines: null,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    // labelText: 'Conteúdo do capítulo',
                    filled: false,
                    fillColor: Palette.Inputs.shade100,
                    labelStyle: TextStyle(color: Palette.Inputs.shade50),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 1),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 1),
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
            ]),
            const SizedBox(height: 22),
          ]),
        ),
        endDrawer: const Sidebar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (formKey.currentState?.validate() ?? false) {
              /*
                titulo
                capitulo
                historia_id
                caminho_capa
                votacao
                quantidade_visualizacao
              */

              Dio dio = Dio();

              try {
                final dataSend = {
                  "titulo": titulo.text,
                  "capitulo": capitulo.text,
                  "historia_id": widget.livro_id,
                  "caminho_capa": "",
                  "votacao": 0,
                  "quantidade_visualizacao": 0,
                };

                // print("Data: ${dataSend}");

                final response = await dio.post(
                    "https://worldbooks.serratedevs.com.br/wbcore/public/api/capitulo",
                    data: dataSend,
                    options: Options(
                      followRedirects: true,
                      validateStatus: (status) {
                        return status! < 400;
                      },
                      headers: {
                        'X-XSRF-TOKEN': GlobalData.getXsrfToken(),
                        'Authorization': 'Bearer ${GlobalData.getApiToken()}',
                        "Accept": "application/json"
                      },
                    ));

                if (response.statusCode != 200) {
                  // print("Status:  ${response.statusCode}");
                  // print("Data: ${response.data}");
                  // print("Erro: ${response.statusMessage}");

                  throw Exception('Erro ao criar a história');
                }

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
                                      builder: (context) =>
                                          const CategoriasList(),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  maximumSize: MaterialStateProperty.all(
                                      const Size(250, 45)),
                                  // padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: _padding_form)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Palette.WBColor.shade50),
                                  textStyle: MaterialStateProperty.all(
                                    const TextStyle(fontFamily: 'Ubuntu'),
                                  ),
                                ),
                                child: const Text('Sair',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Ubuntu')),
                              ),
                              const SizedBox(width: 20),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } on DioError catch (e) {
                // print(e.response!.data);
                throw Exception('Erro ao criar capitulo');
              }
            }
          },
          backgroundColor: Palette.WBColor.shade50,
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}

// class CreateChapter extends StatefulWidget {
//   final GlobalKey<FormState> formKey;
//   const CreateChapter({super.key, required this.formKey});
//   @override
//   _CreateChapterState createState() => _CreateChapterState();
// }

// class _CreateChapterState extends State<CreateChapter> {
//   String imageUrl = '';
//   TextEditingController titulo = TextEditingController();
//   TextEditingController capitulo = TextEditingController();
//   // final _etEditor = await keyEditor.currentState.getText();
//   // QuillController _controller = QuillController.basic();

//   @override
//   void initState() {
//     super.initState();
//     capitulo.text = "Era uma vez...";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: widget.formKey,
//       child: ListView(children: [
//         Column(
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width * 1,
//               height: MediaQuery.of(context).size.height * 0.3,
//               color: Colors.grey, // Cor de fundo da imagem vazia
//               child: imageUrl.isNotEmpty
//                   ? Image.network(
//                       imageUrl,
//                       fit: BoxFit.cover,
//                     )
//                   : const Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [Icon(Icons.photo_camera)],
//                     ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 22),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: TextFormField(
//             controller: titulo,
//             textAlign: TextAlign.start,
//             style: const TextStyle(
//               color: Colors.white,
//             ),
//             decoration: InputDecoration(
//               hintStyle: const TextStyle(color: Colors.white),
//               labelText: 'Título do capítulo',
//               fillColor: Palette.Inputs.shade50,
//               labelStyle: TextStyle(
//                 color: Palette.Inputs.shade50,
//                 fontFamily: 'Ubuntu',
//               ),
//               border: UnderlineInputBorder(
//                 borderSide: BorderSide(
//                   color: Palette.Inputs.shade50,
//                   width: 2.0,
//                 ),
//               ),
//               contentPadding: EdgeInsets.fromLTRB(
//                   MediaQuery.of(context).size.width * 0.3, 0, 0, 0),
//               focusedBorder: const UnderlineInputBorder(
//                 borderSide: BorderSide(
//                   color: Palette.InputsShade50,
//                   width: 2.0,
//                 ),
//               ),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Título é obrigatório';
//               }
//               return null;
//             },
//           ),
//         ),
//         Column(children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15),
//             child: TextFormField(
//               controller: capitulo,
//               style: const TextStyle(
//                 color:
//                     Colors.white, // Defina a cor do texto enquanto você escreve
//               ),
//               maxLines: null,
//               decoration: InputDecoration(
//                 border: const UnderlineInputBorder(),
//                 // labelText: 'Conteúdo do capítulo',
//                 filled: false,
//                 fillColor: Palette.Inputs.shade100,
//                 labelStyle: TextStyle(color: Palette.Inputs.shade50),
//                 focusedBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.transparent, width: 1),
//                 ),
//                 enabledBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.transparent, width: 1),
//                 ),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Escreva o seu capítulo';
//                 }
//                 return null;
//               },
//               autofocus: true,
//             ),
//           ),
//         ]),
//         const SizedBox(height: 22),
//       ]),
//     );
//   }
// }
