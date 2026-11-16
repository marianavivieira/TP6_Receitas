
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/receita.dart';

class ReceitaService {
  Future<List<Receita>> pesquisarReceitas(String nome) async {
    final url = Uri.parse(
      'https://www.themealdb.com/api/json/v1/1/search.php?s=$nome',
    );

    final resposta = await http.get(url);

    if (resposta.statusCode == 200) {
      final dados = jsonDecode(resposta.body);

      if (dados['meals'] == null) {
        return [];
      }

      final List receitasJson = dados['meals'];

      return receitasJson
          .map((receita) => Receita.fromJson(receita))
          .toList();
    } else {
      throw Exception('Erro ao buscar receitas.');
    }
  }
}
