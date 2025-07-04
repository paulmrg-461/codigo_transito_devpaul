import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Asistente de Tránsito IA')),
      body: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.traffic),
            ),
            title: const Text('Consultar Ley de Tránsito'),
            subtitle: const Text('Asistente IA especializado en Ley 769 de 2002'),
            onTap: () => context.push('/basic-prompt'),
          ),
        ],
      ),
    );
  }
}
