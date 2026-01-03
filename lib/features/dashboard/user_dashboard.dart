import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: const Text('Create Project'),
              subtitle: const Text('Submit new project request'),
              trailing: const Icon(Icons.add),
              onTap: () {
                context.go('/create-project');
              },
            ),
          ),
        ],
      ),
    );
  }
}
