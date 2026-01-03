import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VerifierDashboard extends StatelessWidget {
  const VerifierDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifier Dashboard'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: const Text('Field Verification'),
              subtitle: const Text('Capture geo-tagged evidence'),
              trailing: const Icon(Icons.camera_alt),
              onTap: () {
                context.go('/capture-evidence');
              },
            ),
          ),
        ],
      ),
    );
  }
}
