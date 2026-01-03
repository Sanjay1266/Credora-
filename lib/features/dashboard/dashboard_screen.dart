// Auto-generated file
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text('Create New Project'),
                subtitle: const Text('Submit a new request for verification'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  context.go('/create-project');
                },
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                title: const Text('Project Status'),
                subtitle: const Text('Track submitted requests'),
                trailing: const Icon(Icons.analytics),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
