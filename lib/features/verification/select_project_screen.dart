import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/api_service.dart';
import '../../models/project_model.dart';

class SelectProjectScreen extends StatelessWidget {
  const SelectProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Project'),
      ),
      body: FutureBuilder(
        future: ApiService.getProjects(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final projects = snapshot.data as List;

          return ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];

              return Card(
                margin: const EdgeInsets.all(12),
                child: ListTile(
                  title: Text(project['name']),
                  subtitle: Text(project['location']),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    context.go(
                      '/capture-evidence',
                      extra: ProjectModel(
                        id: project['id'],
                        name: project['name'],
                        location: project['location'],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
