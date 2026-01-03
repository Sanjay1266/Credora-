import 'package:flutter/material.dart';
import '../../models/project_model.dart';
import '../../services/local_storage_service.dart';
import '../../models/evidence_model.dart';
import 'verify_evidence_screen.dart';

class ProjectEvidenceListScreen extends StatelessWidget {
  final ProjectModel project;
  final LocalStorageService storage = LocalStorageService();

  ProjectEvidenceListScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final evidenceList =
        storage.getEvidenceByProject(project.id);

    return Scaffold(
      appBar: AppBar(title: Text(project.name)),
      body: ListView.builder(
        itemCount: evidenceList.length,
        itemBuilder: (context, index) {
          final EvidenceModel evidence = evidenceList[index];

          return Card(
            child: ListTile(
              title: Text('Evidence ${index + 1}'),
              subtitle: Text('Status: ${evidence.status}'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        VerifyEvidenceScreen(evidence: evidence),
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
