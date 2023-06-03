import 'package:flutter/material.dart';
import '../palletes/pallete.dart';
import 'components/Sidebar.dart';
import 'models/Categorias.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'dart:convert';

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
              icon: Icon(Icons.arrow_back, color: Color(0xffffffff)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: ImageWidget(),
          endDrawer: Sidebar(),
        ),
      );
  }
}

class ImageWidget extends StatefulWidget {
  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  late Future<Map<String, dynamic>> _categorias;
  late Future<Map<String, dynamic>> _idiomas;
  late Future<Map<String, dynamic>> _publicos;
  late Future<Map<String, dynamic>> _direitos;
  bool _conteudo_adulto = false;
  TextEditingController titulo = TextEditingController();
  TextEditingController descricao = TextEditingController();
  TextEditingController categoria = TextEditingController();
  TextEditingController idioma = TextEditingController();
  TextEditingController publico_alvo = TextEditingController();
  TextEditingController direitos_autor = TextEditingController();
  TextEditingController conteudo_adulto = TextEditingController();
  Map<String, dynamic>? dropdownCategoriaValue;
  Map<String, dynamic>? dropdownIdiomaValue;
  Map<String, dynamic>? dropdownPublicoValue;
  Map<String, dynamic>? dropdownDireitosValue;
  bool dropdownConteudoAdultoValue = false;
  String imageUrl = '';

  Future<Map<String, dynamic>> getCategorias() async {
    final String response = await rootBundle.loadString('assets/data/categoria_data.json');
    return jsonDecode(response);
  }
  Future<Map<String, dynamic>> getIdiomas() async {
    final String response = await rootBundle.loadString('assets/data/idiomas.json');
    return jsonDecode(response);
  }
  Future<Map<String, dynamic>> getDireitos() async {
    final String response = await rootBundle.loadString('assets/data/direitos_autor.json');
    return jsonDecode(response);
  }
  Future<Map<String, dynamic>> getPublicos() async {
    final String response = await rootBundle.loadString('assets/data/publico_alvo.json');
    return jsonDecode(response);
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(children: [
          SizedBox(height: 16),
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
              SizedBox(height: 22),
              TextField(
                onChanged: (value) {
                  updateImage(value);
                },
                style: TextStyle(
                  color: Colors.white, // Defina a cor do texto enquanto você escreve
                ),
                decoration: InputDecoration(
                  labelText: 'URL da capa',
                  filled: true,
                  fillColor: Palette.Inputs.shade100,
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Palette.Inputs.shade50),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffffffff), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.Inputs.shade100, width: 1),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          TextField(
            controller: titulo,
            style: TextStyle(
              color:Colors.white, // Defina a cor do texto enquanto você escreve
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Título da história',
              filled: true,
              fillColor: Palette.Inputs.shade100,
              labelStyle: TextStyle(color: Palette.Inputs.shade50),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffffffff), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.Inputs.shade100, width: 1),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: descricao,
            style: TextStyle(
              color: Colors.white, // Defina a cor do texto enquanto você escreve
            ),
            maxLines: 5,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Sinopse',
              filled: true,
              fillColor: Palette.Inputs.shade100,
              labelStyle: TextStyle(color: Palette.Inputs.shade50),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffffffff), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Palette.Inputs.shade100, width: 1),
              ),
            ),
          ),
          SizedBox(height: 16),

// CATEGORIA
          Divider(
            thickness: 1,
            color: Palette.WBColor.shade300,
          ),
          Text(
            "Selecione a categoria",
            style: TextStyle(
              color: Palette.InputsShade50,
              fontFamily: 'Ubuntu',
            )
          ),
          SizedBox(height: 2),
          DropdownButtonHideUnderline(
            child: FutureBuilder<Map<String, dynamic>>(
              future: _categorias,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Erro ao carregar as categorias');
                } else if (!snapshot.hasData) {
                  return Text('Nenhuma categoria encontrada');
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
                      borderSide: BorderSide(
                        color: Palette.WBColor.shade400, 
                        width: 0
                      ), 
                    ),
                  ),
                  onChanged: (Map<String, dynamic>? value) {
                    setState(() {
                      dropdownCategoriaValue = value!;
                      categoria.text = value!['id'].toString();
                    });
                  },
                  dropdownColor: Palette.WBColor.shade300,
                  items: categorias.map<DropdownMenuItem<Map<String, dynamic>>>(
                    (categ) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: categ,
                        child: Text(
                          categ["genero"],
                          style: TextStyle(
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
          SizedBox(height: 16),

// IDIOMA
          Divider(
            thickness: 1,
            color: Palette.WBColor.shade300,
          ),
          Text(
            "Selecione o idioma",
            style: TextStyle(
              color: Palette.InputsShade50,
              fontFamily: 'Ubuntu',
            )
          ),
          SizedBox(height: 2),
          DropdownButtonHideUnderline(
            child: FutureBuilder<Map<String, dynamic>>(
              future: _idiomas,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Erro ao carregar as idiomas');
                } else if (!snapshot.hasData) {
                  return Text('Nenhum idioma encontrado');
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
                      borderSide: BorderSide(
                        color: Palette.WBColor.shade400, 
                        width: 0
                      ), 
                    ),
                  ),
                  onChanged: (Map<String, dynamic>? value) {
                    setState(() {
                      dropdownIdiomaValue = value!;
                      idioma.text = value!['id'].toString();
                    });
                  },
                  dropdownColor: Palette.WBColor.shade300,
                  items: idiomas.map<DropdownMenuItem<Map<String, dynamic>>>(
                    (categ) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: categ,
                        child: Text(
                          categ["nome"],
                          style: TextStyle(
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
          SizedBox(height: 16),

// PÚBLICO
          Divider(
            thickness: 1,
            color: Palette.WBColor.shade300,
          ),
          Text(
            "Selecione o público alvo",
            style: TextStyle(
              color: Palette.InputsShade50,
              fontFamily: 'Ubuntu',
            )
          ),
          SizedBox(height: 2),
          DropdownButtonHideUnderline(
            child: FutureBuilder<Map<String, dynamic>>(
              future: _publicos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Erro ao carregar as publicos');
                } else if (!snapshot.hasData) {
                  return Text('Nenhum publico encontrado');
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
                      borderSide: BorderSide(
                        color: Palette.WBColor.shade400, 
                        width: 0
                      ), 
                    ),
                  ),
                  onChanged: (Map<String, dynamic>? value) {
                    setState(() {
                      dropdownPublicoValue = value!;
                      publico_alvo.text = value!['id'].toString();
                    });
                  },
                  dropdownColor: Palette.WBColor.shade300,
                  items: publicos.map<DropdownMenuItem<Map<String, dynamic>>>(
                    (categ) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: categ,
                        child: Text(
                          categ["nome"],
                          style: TextStyle(
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
          SizedBox(height: 16),

// DIREITOS
          Divider(
            thickness: 1,
            color: Palette.WBColor.shade300,
          ),
          Text(
            "Selecione os direitos do autor",
            style: TextStyle(
              color: Palette.InputsShade50,
              fontFamily: 'Ubuntu',
            )
          ),
          SizedBox(height: 2),
          DropdownButtonHideUnderline(
            child: FutureBuilder<Map<String, dynamic>>(
              future: _direitos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Erro ao carregar as direitos');
                } else if (!snapshot.hasData) {
                  return Text('Nenhum direito encontrado');
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
                      borderSide: BorderSide(
                        color: Palette.WBColor.shade400, 
                        width: 0
                      ), 
                    ),
                  ),
                  onChanged: (Map<String, dynamic>? value) {
                    setState(() {
                      dropdownDireitosValue = value!;
                      direitos_autor.text = value!['id'].toString();
                    });
                  },
                  dropdownColor: Palette.WBColor.shade300,
                  items: direitos.map<DropdownMenuItem<Map<String, dynamic>>>(
                    (categ) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: categ,
                        child: Text(
                          categ["nome"],
                          style: TextStyle(
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
          SizedBox(height: 16),

// CONTEúdo adulto
// 
          Divider(
            thickness: 1,
            color: Palette.WBColor.shade300,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Conteúdo adulto?",
                style: TextStyle(
                  color: Palette.InputsShade50,
                  fontFamily: 'Ubuntu',
                )
              ),
              SizedBox(height: 2),
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
          SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => CategoriasList(),
                  //   ),
                  // );
                },
                child: Text("Seguinte"),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  maximumSize: MaterialStateProperty.all(const Size(250, 45)),
                  // padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: _padding_form)),
                  backgroundColor:MaterialStateProperty.all(Palette.WBColor.shade50),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(fontFamily: 'Ubuntu'),
                  ),
                ),
              ),
              // SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => CategoriasList(),
                  //   ),
                  // );
                },
                child: Text("Limpar"),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  maximumSize: MaterialStateProperty.all(const Size(250, 45)),
                  // padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: _padding_form)),
                  backgroundColor:MaterialStateProperty.all(Palette.WBColor.shade300),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(fontFamily: 'Ubuntu'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
        ]),
      ),
    );
  }
}
