import 'package:flutter/material.dart';
import '../../data/mock_projects.dart';
import '../../models/project_model.dart';
import 'admin_project_review_screen.dart';

class AdminProjectListScreen extends StatelessWidget {
  const AdminProjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin – Project Review')),
      body: ListView.builder(
        itemCount: mockProjects.length,
        itemBuilder: (context, index) {
          final ProjectModel project = mockProjects[index];

          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              title: Text(project.name),
              subtitle:
                  Text('Status: ${project.adminStatus}'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        AdminProjectReviewScreen(project: project),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
