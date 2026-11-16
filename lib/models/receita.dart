
class Receita {
  final String id;
  final String nome;
  final String imagem;

  Receita({
    required this.id,
    required this.nome,
    required this.imagem,
  });

  factory Receita.fromJson(Map<String, dynamic> json) {
    return Receita(
      id: json['idMeal'] ?? '',
      nome: json['strMeal'] ?? '',
      imagem: json['strMealThumb'] ?? '',
    );
  }
}
