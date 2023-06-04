import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:worldbooks/create_capitulo.dart';
import 'package:worldbooks/global_data.dart';
import '../palletes/pallete.dart';
import 'components/Sidebar.dart';
import 'models/Chip.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:dio/dio.dart';

class CreateLivro extends StatelessWidget {
  const CreateLivro({super.key});
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
        body: const ImageWidget(),
        endDrawer: const Sidebar(),
      ),
    );
  }
}

class ImageWidget extends StatefulWidget {
  const ImageWidget({super.key});

  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  late Future<Map<String, dynamic>> _categorias;
  late Future<Map<String, dynamic>> _idiomas;
  late Future<Map<String, dynamic>> _publicos;
  late Future<Map<String, dynamic>> _direitos;
  final bool _conteudo_adulto = false;
  TextEditingController titulo = TextEditingController();
  TextEditingController descricao = TextEditingController();
  TextEditingController categoria = TextEditingController();
  TextEditingController idioma = TextEditingController();
  TextEditingController publico_alvo = TextEditingController();
  TextEditingController direitos_autor = TextEditingController();
  TextEditingController conteudo_adulto = TextEditingController();
  final TextEditingController _chipTextController = TextEditingController();
  Map<String, dynamic>? dropdownCategoriaValue;
  Map<String, dynamic>? dropdownIdiomaValue;
  Map<String, dynamic>? dropdownPublicoValue;
  Map<String, dynamic>? dropdownDireitosValue;
  bool dropdownConteudoAdultoValue = false;
  final List<ChipModel> _chipList = [];
  String imageUrl = '';
  final _formKey = GlobalKey<FormState>();

  Future<Map<String, dynamic>> getCategorias() async {
    Dio dio = Dio();

    var response = null;

    try {
      response = await dio.get(
          'https://worldbooks.serratedevs.com.br/wbcore/public/api/categoria');
    } on DioError catch (e) {
      print(e.response!.data);
      Fluttertoast.showToast(
        msg:
            "API request failed! ${e.response?.statusCode} ${e.response?.statusMessage}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      throw Exception(
          'Erro ao carregar as categorias. Exception: ${e.response!.data}');
    }

    return response.data;
  }

  Future<Map<String, dynamic>> getIdiomas() async {
    Dio dio = Dio();

    var response = null;

    try {
      response = await dio.get(
          'https://worldbooks.serratedevs.com.br/wbcore/public/api/idioma');
    } on DioError catch (e) {
      print(e.response!.data);
      Fluttertoast.showToast(
        msg:
            "API request failed! ${e.response?.statusCode} ${e.response?.statusMessage}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      throw Exception(
          'Erro ao carregar os idiomas. Exception: ${e.response!.data}');
    }

    return response.data;
  }

  Future<Map<String, dynamic>> getDireitos() async {
    Dio dio = Dio();

    var response = null;

    try {
      response = await dio.get(
          'https://worldbooks.serratedevs.com.br/wbcore/public/api/direitos_autorais');
    } on DioError catch (e) {
      print(e.response!.data);
      Fluttertoast.showToast(
        msg:
            "API request failed! ${e.response?.statusCode} ${e.response?.statusMessage}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      throw Exception(
          'Erro ao carregar os direitos autorais. Exception: ${e.response!.data}');
    }

    return response.data;
  }

  Future<Map<String, dynamic>> getPublicos() async {
    Dio dio = Dio();

    var response = null;

    try {
      response = await dio.get(
          'https://worldbooks.serratedevs.com.br/wbcore/public/api/publico_alvo');
    } on DioError catch (e) {
      print(e.response!.data);
      Fluttertoast.showToast(
        msg:
            "API request failed! ${e.response?.statusCode} ${e.response?.statusMessage}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      throw Exception(
          'Erro ao carregar o publico alvo. Exception: ${e.response!.data}');
    }

    return response.data;
  }

  void _deleteChip(String name) {
    setState(() {
      _chipList.removeWhere((element) => element.name == name);
    });
  }

  @override
  void initState() {
    super.initState();
    _categorias = getCategorias();
    _idiomas = getIdiomas();
    _direitos = getDireitos();
    _publicos = getPublicos();
    // dropdownCategoriaValue = _categorias.first;
  }

  void updateImage(String url) {
    setState(() {
      imageUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(children: [
          const SizedBox(height: 16),
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.4,
                color: Colors.grey, // Cor de fundo da imagem vazia
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              const SizedBox(height: 22),
              TextFormField(
                onChanged: (value) {
                  updateImage(value);
                },
                style: const TextStyle(
                  color: Colors
                      .white, // Defina a cor do texto enquanto você escreve
                ),
                decoration: InputDecoration(
                  labelText: 'URL da capa',
                  filled: true,
                  fillColor: Palette.Inputs.shade100,
                  border: const OutlineInputBorder(),
                  labelStyle: TextStyle(color: Palette.Inputs.shade50),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffffffff), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Palette.Inputs.shade100, width: 1),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'URL da capa é obrigatória';
                  }
                  return null;
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: titulo,
            style: const TextStyle(
              color:
                  Colors.white, // Defina a cor do texto enquanto você escreve
            ),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Título da história',
              filled: true,
              fillColor: Palette.Inputs.shade100,
              labelStyle: TextStyle(color: Palette.Inputs.shade50),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffffffff), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Palette.Inputs.shade100, width: 1),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Título é obrigatório';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: descricao,
            style: const TextStyle(
              color:
                  Colors.white, // Defina a cor do texto enquanto você escreve
            ),
            maxLines: 5,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Sinopse',
              filled: true,
              fillColor: Palette.Inputs.shade100,
              labelStyle: TextStyle(color: Palette.Inputs.shade50),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffffffff), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Palette.Inputs.shade100, width: 1),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Sinopse é obrigatória';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Divider(
            thickness: 1,
            color: Palette.WBColor.shade300,
          ),

          Wrap(
            spacing: 2,
            runSpacing: -5,
            children: _chipList
                .map(
                  (chip) => Chip(
                    label: Text(chip.name),
                    backgroundColor: Palette.InputsShade50,
                    onDeleted: () => _deleteChip(chip.name),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Flexible(
                child: TextFormField(
                  controller: _chipTextController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Adicione as tags',
                    filled: true,
                    fillColor: Palette.Inputs.shade100,
                    labelStyle: TextStyle(color: Palette.Inputs.shade50),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffffffff), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Palette.Inputs.shade100, width: 1),
                    ),
                  ),
                  textInputAction: TextInputAction.go,
                  style: const TextStyle(
                    color:
                        Colors.white, // Defina a cor do texto enquanto você escreve
                  ),
                  validator: (value) {
                    if (_chipList.length == 0) {
                      if (value == null || value.isEmpty) {
                        return 'Adicione pelo menos uma tag';
                      }
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    setState(() {
                      _chipList.add(
                        ChipModel(name: _chipTextController.text),
                      );
                      _chipTextController.text = '';
                      // print("TAGS: $_chipList");
                    });
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // CATEGORIA
          Divider(
            thickness: 1,
            color: Palette.WBColor.shade300,
          ),
          const Text("Selecione a categoria",
              style: TextStyle(
                color: Palette.InputsShade50,
                fontFamily: 'Ubuntu',
              )),
          const SizedBox(height: 2),
          DropdownButtonHideUnderline(
            child: FutureBuilder<Map<String, dynamic>>(
              future: _categorias,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Erro ao carregar as categorias');
                } else if (!snapshot.hasData) {
                  return const Text('Nenhuma categoria encontrada');
                }
                List<dynamic> categorias = snapshot.data!['data'];
                return DropdownButtonFormField<Map<String, dynamic>>(
                  value: dropdownCategoriaValue,
                  elevation: 0,
                  style: const TextStyle(color: Palette.InputsShade50),
                  isExpanded: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Palette.Inputs.shade100,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Palette.WBColor.shade400, width: 0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Categoria é obrigatória';
                    }
                    return null;
                  },
                  onChanged: (Map<String, dynamic>? value) {
                    setState(() {
                      dropdownCategoriaValue = value!;
                      categoria.text = value['id'].toString();
                    });
                  },
                  dropdownColor: Palette.WBColor.shade300,
                  items: categorias.map<DropdownMenuItem<Map<String, dynamic>>>(
                    (categ) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: categ,
                        child: Text(
                          categ["genero"],
                          style: const TextStyle(
                            fontFamily: 'Ubuntu',
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // IDIOMA
          Divider(
            thickness: 1,
            color: Palette.WBColor.shade300,
          ),
          const Text("Selecione o idioma",
              style: TextStyle(
                color: Palette.InputsShade50,
                fontFamily: 'Ubuntu',
              )),
          const SizedBox(height: 2),
          DropdownButtonHideUnderline(
            child: FutureBuilder<Map<String, dynamic>>(
              future: _idiomas,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Erro ao carregar as idiomas');
                } else if (!snapshot.hasData) {
                  return const Text('Nenhum idioma encontrado');
                }
                List<dynamic> idiomas = snapshot.data!['data'];

                return DropdownButtonFormField<Map<String, dynamic>>(
                  value: dropdownIdiomaValue,
                  elevation: 0,
                  style: const TextStyle(color: Palette.InputsShade50),
                  isExpanded: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Palette.Inputs.shade100,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Palette.WBColor.shade400, width: 0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Idioma é obrigatório';
                    }
                    return null;
                  },
                  onChanged: (Map<String, dynamic>? value) {
                    setState(() {
                      dropdownIdiomaValue = value!;
                      idioma.text = value['id'].toString();
                    });
                  },
                  dropdownColor: Palette.WBColor.shade300,
                  items: idiomas.map<DropdownMenuItem<Map<String, dynamic>>>(
                    (categ) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: categ,
                        child: Text(
                          categ["idioma"],
                          style: const TextStyle(
                            fontFamily: 'Ubuntu',
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // PÚBLICO
          Divider(
            thickness: 1,
            color: Palette.WBColor.shade300,
          ),
          const Text("Selecione o público alvo",
              style: TextStyle(
                color: Palette.InputsShade50,
                fontFamily: 'Ubuntu',
              )),
          const SizedBox(height: 2),
          DropdownButtonHideUnderline(
            child: FutureBuilder<Map<String, dynamic>>(
              future: _publicos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Erro ao carregar as publicos');
                } else if (!snapshot.hasData) {
                  return const Text('Nenhum publico encontrado');
                }
                List<dynamic> publicos = snapshot.data!['data'];
                return DropdownButtonFormField<Map<String, dynamic>>(
                  value: dropdownPublicoValue,
                  elevation: 0,
                  style: const TextStyle(color: Palette.InputsShade50),
                  isExpanded: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Palette.Inputs.shade100,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Palette.WBColor.shade400, width: 0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Público alvo é obrigatório';
                    }
                    return null;
                  },
                  onChanged: (Map<String, dynamic>? value) {
                    setState(() {
                      dropdownPublicoValue = value!;
                      publico_alvo.text = value['id'].toString();
                    });
                  },
                  dropdownColor: Palette.WBColor.shade300,
                  items: publicos.map<DropdownMenuItem<Map<String, dynamic>>>(
                    (categ) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: categ,
                        child: Text(
                          categ["publico"],
                          style: const TextStyle(
                            fontFamily: 'Ubuntu',
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // DIREITOS
          Divider(
            thickness: 1,
            color: Palette.WBColor.shade300,
          ),
          const Text("Selecione os direitos do autor",
              style: TextStyle(
                color: Palette.InputsShade50,
                fontFamily: 'Ubuntu',
              )),
          const SizedBox(height: 2),
          DropdownButtonHideUnderline(
            child: FutureBuilder<Map<String, dynamic>>(
              future: _direitos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Erro ao carregar as direitos');
                } else if (!snapshot.hasData) {
                  return const Text('Nenhum direito encontrado');
                }
                List<dynamic> direitos = snapshot.data!['data'];
                return DropdownButtonFormField<Map<String, dynamic>>(
                  value: dropdownDireitosValue,
                  elevation: 0,
                  style: const TextStyle(color: Palette.InputsShade50),
                  isExpanded: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Palette.Inputs.shade100,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Palette.WBColor.shade400, width: 0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Direitos do autor é obrigatório';
                    }
                    return null;
                  },
                  onChanged: (Map<String, dynamic>? value) {
                    setState(() {
                      dropdownDireitosValue = value!;
                      direitos_autor.text = value['id'].toString();
                    });
                  },
                  dropdownColor: Palette.WBColor.shade300,
                  items: direitos.map<DropdownMenuItem<Map<String, dynamic>>>(
                    (categ) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: categ,
                        child: Text(
                          categ["tipo_autoral"],
                          style: const TextStyle(
                            fontFamily: 'Ubuntu',
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // CONTEúdo adulto
          Divider(
            thickness: 1,
            color: Palette.WBColor.shade300,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("Conteúdo adulto?",
                  style: TextStyle(
                    color: Palette.InputsShade50,
                    fontFamily: 'Ubuntu',
                  )),
              const SizedBox(height: 2),
              Switch(
                activeColor: Palette.WBColor.shade50,
                value: dropdownConteudoAdultoValue,
                onChanged: (value) {
                  setState(() {
                    dropdownConteudoAdultoValue = value;
                    conteudo_adulto.text = value.toString();
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Botões
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    Dio dio = Dio();

                    // Create an array of tags
                    List<String> tags = [];
                    _chipList.forEach((element) {
                      tags.add(element.name);
                    });

                    try {
                      final dataSend = {
                        "caminho_capa": imageUrl,
                        "categoria_id": int.parse(categoria.text),
                        "conteudo_adulto": conteudo_adulto.text == ""
                            ? false
                            : conteudo_adulto.text == "true"
                                ? true
                                : false,
                        "data_atualizacao": "",
                        "data_criacao": "",
                        "descricao": descricao.text,
                        "direitos_autorais_id": int.parse(direitos_autor.text),
                        "historia_finalizada": false,
                        "idioma_id": int.parse(idioma.text),
                        "personagens_principais": "[]",
                        "publico_alvo_id": int.parse(publico_alvo.text),
                        "tags": tags,
                        "titulo": titulo.text,
                        "usuario_id": GlobalData.getUserId(),
                      };

                      print("Data: ${dataSend}");

                      final response = await dio.post(
                          "https://worldbooks.serratedevs.com.br/wbcore/public/api/historia",
                          data: dataSend,
                          options: Options(
                            followRedirects: true,
                            validateStatus: (status) {
                              return status! < 400;
                            },
                            headers: {
                              'X-XSRF-TOKEN': GlobalData.getXsrfToken(),
                              'Authorization':
                                  'Bearer ${GlobalData.getApiToken()}',
                              "Accept": "application/json"
                            },
                          ));

                      if (response.statusCode != 200) {
                        print("Status:  ${response.statusCode}");
                        print("Data: ${response.data}");
                        print("Erro: ${response.statusMessage}");

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
                                const Text(
                                    'Sua história foi criada com sucesso! Deseja criar o 1º capítulo?'),
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
                                                CreateCapitulo(
                                                    livro_id:
                                                        response.data['data']
                                                            ['historia_id']),
                                          ),
                                        );
                                      },
                                      style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        maximumSize: MaterialStateProperty.all(
                                            const Size(250, 45)),
                                        // padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: _padding_form)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Palette.WBColor.shade50),
                                        textStyle: MaterialStateProperty.all(
                                          const TextStyle(fontFamily: 'Ubuntu'),
                                        ),
                                      ),
                                      child: const Text('Sim',
                                          style: TextStyle(
                                            color: Colors.white,
                                          )),
                                    ),
                                    const SizedBox(width: 20),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Voltar',
                                          style: TextStyle(
                                              color: Palette.WBColorShade50)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } on DioError catch (e) {
                      // print(e.response!.data);
                      throw Exception(
                          'Erro ao criar a história. Exception: ${e.response!.data}');
                    }

                    // print("Status:  ${response.statusCode}");
                    // print("Data: ${response.data}");
                  }
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => CreateCapitulo(),
                  //   ),
                  // );
                },
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  maximumSize: MaterialStateProperty.all(const Size(250, 45)),
                  // padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: _padding_form)),
                  backgroundColor:
                      MaterialStateProperty.all(Palette.WBColor.shade50),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(fontFamily: 'Ubuntu'),
                  ),
                ),
                child: const Text("Criar história"),
              ),
              // SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async {
                  _formKey.currentState!.reset();
                  // print(dropdownCategoriaValue);

                  imageUrl = '';
                  titulo.text = '';
                  descricao.text = '';
                  categoria.text = '';
                  publico_alvo.text = '';
                  direitos_autor.text = '';
                  dropdownCategoriaValue = null;
                  dropdownIdiomaValue = null;
                  dropdownPublicoValue = null;
                  dropdownDireitosValue = null;
                  dropdownConteudoAdultoValue = false;

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => CreateCapitulo(),
                  //   ),
                  // );
                },
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  maximumSize: MaterialStateProperty.all(const Size(250, 45)),
                  // padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: _padding_form)),
                  backgroundColor:
                      MaterialStateProperty.all(Palette.WBColor.shade300),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(fontFamily: 'Ubuntu'),
                  ),
                ),
                child: const Text("Limpar"),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ]),
      ),
    );
  }
}
