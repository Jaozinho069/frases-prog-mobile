import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _phrases = [];
  String? _selectedPhrase;

  void _showAddPhraseDialog() {
    final TextEditingController dialogController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adicionar Frase'),
          content: TextField(
            controller: dialogController,
            decoration: const InputDecoration(
              hintText: 'Digite uma nova frase',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (dialogController.text.isNotEmpty) {
                  setState(() {
                    _phrases.add(dialogController.text);
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  void _drawPhrase() {
    if (_phrases.isNotEmpty) {
      setState(() {
        _selectedPhrase = "A frase do dia é: ${_phrases[Random().nextInt(_phrases.length)]}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frases Motivacionais'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: _showAddPhraseDialog,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _drawPhrase,
              child: const Text('Sortear Frase'),
            ),
            const SizedBox(height: 20),
            if (_selectedPhrase != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _selectedPhrase!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
