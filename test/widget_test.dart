
import 'package:flutter_test/flutter_test.dart';
import 'package:tp6_receitas/main.dart';

void main() {
  testWidgets('Exibe a tela inicial de receitas', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Consulta de Receitas'), findsOneWidget);
    expect(find.text('Encontre sua próxima receita!'), findsOneWidget);
    expect(find.text('Pesquisar receitas'), findsOneWidget);
  });
}
