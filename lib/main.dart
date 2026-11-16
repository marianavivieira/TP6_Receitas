
import 'package:material_ui/material_ui.dart';

import 'models/receita.dart';
import 'services/receita_service.dart';

// Integrantes: Mariana Alevs Carvalho Vieira

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Consulta de Receitas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
        ),
        useMaterial3: true,
      ),
      home: const TelaReceitas(),
    );
  }
}

class TelaReceitas extends StatefulWidget {
  const TelaReceitas({super.key});

  @override
  State<TelaReceitas> createState() => _TelaReceitasState();
}

class _TelaReceitasState extends State<TelaReceitas> {
  final TextEditingController _controller = TextEditingController();
  final ReceitaService _service = ReceitaService();

  List<Receita> receitas = [];

  bool carregando = false;
  String mensagem = 'Pesquise uma receita para começar!';

  Future<void> pesquisarReceita() async {
    final nome = _controller.text.trim();

    if (nome.isEmpty) {
      setState(() {
        mensagem = 'Digite o nome de uma receita.';
        receitas = [];
      });
      return;
    }

    setState(() {
      carregando = true;
      mensagem = '';
      receitas = [];
    });

    try {
      final resultado = await _service.pesquisarReceitas(nome);

      if (!mounted) return;

      setState(() {
        receitas = resultado;
        carregando = false;

        if (resultado.isEmpty) {
          mensagem = 'Nenhuma receita encontrada.';
        }
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        carregando = false;
        mensagem = 'Não foi possível carregar as receitas.';
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de Receitas'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'Mariana Vieira',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Encontre sua próxima receita!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Digite o nome de um prato para pesquisar.',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              onSubmitted: (_) => pesquisarReceita(),
              decoration: const InputDecoration(
                labelText: 'Nome da receita',
                hintText: 'Ex: Chicken, Pasta...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: carregando ? null : pesquisarReceita,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(15),
              ),
              child: const Text('Pesquisar receitas'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: carregando
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                    )
                  : receitas.isNotEmpty
                      ? ListView.builder(
                          itemCount: receitas.length,
                          itemBuilder: (context, index) {
                            final receita = receitas[index];

                            return Card(
                              margin: const EdgeInsets.only(bottom: 15),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(10),
                                leading: Image.network(
                                  receita.imagem,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.restaurant,
                                      size: 50,
                                    );
                                  },
                                ),
                                title: Text(
                                  receita.nome,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            mensagem,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
