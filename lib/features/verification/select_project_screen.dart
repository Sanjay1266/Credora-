import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/mock_projects.dart';
import '../../models/project_model.dart';

class SelectProjectScreen extends StatelessWidget {
  const SelectProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Project')),
      body: ListView.builder(
        itemCount: mockProjects.length,
        itemBuilder: (context, index) {
          final ProjectModel project = mockProjects[index];

          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              title: Text(project.name),
              subtitle: Text(project.location),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                context.go(
                  '/capture-evidence',
                  extra: project,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
