// Uma página em flutter para criar e editar capítulos de uma história
// A página contém um botão para publicar o capítulo ou para cancelar a ação
// Em seguida contenha um campo de texto para o título do capítulo
// E um campo de texto para o conteúdo do capítulo
// O campo de texto do conteúdo deve ser capaz de receber texto formatado
// A página deve ser capaz de receber um capítulo para edição
// Modelo da página em VueJs utilizando o framework quasar:
// https://github.com/brunoserrate/worldsbook/blob/main/wbweb/src/pages/criar_capitulo.vue
// https://github.com/brunoserrate/worldsbook/blob/main/wbweb/src/pages/editar_capitulo.vue

import 'package:flutter/material.dart';

class CreateEditLivros extends StatefulWidget {
  const CreateEditLivros({super.key});

  @override
  _CreateEditLivrosState createState() => _CreateEditLivrosState();
}

class _CreateEditLivrosState extends State<CreateEditLivros> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar capítulo"),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: const Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Título",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: "Conteúdo",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Path: lib\samples\create_edit_livros.dart