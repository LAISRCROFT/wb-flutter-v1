//import 'dart:ffi';

import 'package:flutter/foundation.dart';

class Livro {
  final String id;
  final String titulo;
  final String descricao;
  final int categoria_id;
  final int publico_alvo_id;
  final int idioma_id;
  final int direitos_autorais_id;
  final bool conteudo_adulto;
  final String caminho_capa;
  final int usuario_id;
  final bool historia_finalizada;
  final DateTime data_criacao;
  final DateTime data_atualizacao;
  final String categoria_nome;
  final String direito_autoral;
  final String nome_usuario;
  final String apelido_usuario;
  final int usar_apelido;
  final String foto_perfil;
  final int total_capitulos;
  final int total_visualizacoes;
  final int total_votos;
//  final Array capitulos;
//  final Array tags;

  Livro({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.categoria_id,
    required this.publico_alvo_id,
    required this.idioma_id,
    required this.direitos_autorais_id,
    required this.conteudo_adulto,
    required this.caminho_capa,
    required this.usuario_id,
    required this.historia_finalizada,
    required this.data_criacao,
    required this.data_atualizacao,
    required this.categoria_nome,
    required this.direito_autoral,
    required this.nome_usuario,
    required this.apelido_usuario,
    required this.usar_apelido,
    required this.foto_perfil,
    required this.total_capitulos,
    required this.total_visualizacoes,
    required this.total_votos,
    //required this.capitulos,
    //required this.tags,
  });
}
