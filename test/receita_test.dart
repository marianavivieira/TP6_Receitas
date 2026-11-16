
import 'package:flutter_test/flutter_test.dart';
import 'package:tp6_receitas/models/receita.dart';

void main() {
  group('Testes do modelo Receita', () {
    test('Deve criar uma receita com os dados recebidos', () {
      final json = {
        'idMeal': '52772',
        'strMeal': 'Teriyaki Chicken Casserole',
        'strMealThumb': 'https://exemplo.com/imagem.jpg',
      };

      final receita = Receita.fromJson(json);

      expect(receita.id, '52772');
      expect(receita.nome, 'Teriyaki Chicken Casserole');
      expect(receita.imagem, 'https://exemplo.com/imagem.jpg');
    });

    test('Deve utilizar valores vazios quando os dados forem nulos', () {
      final json = {
        'idMeal': null,
        'strMeal': null,
        'strMealThumb': null,
      };

      final receita = Receita.fromJson(json);

      expect(receita.id, '');
      expect(receita.nome, '');
      expect(receita.imagem, '');
    });
  });
}
