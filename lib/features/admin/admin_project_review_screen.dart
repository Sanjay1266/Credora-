import 'package:flutter/material.dart';
import '../../models/project_model.dart';

class AdminProjectReviewScreen extends StatefulWidget {
  final ProjectModel project;

  const AdminProjectReviewScreen({
    super.key,
    required this.project,
  });

  @override
  State<AdminProjectReviewScreen> createState() =>
      _AdminProjectReviewScreenState();
}

class _AdminProjectReviewScreenState
    extends State<AdminProjectReviewScreen> {
  final TextEditingController _remarksController =
      TextEditingController();

  void _setDecision(String status) {
    setState(() {
      widget.project.adminStatus = status;
      widget.project.adminRemarks =
          _remarksController.text;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Project $status')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Project Review')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              widget.project.name,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Location: ${widget.project.location}'),
            const SizedBox(height: 16),

            Text(
              'Verifier Status: Evidence Reviewed',
              style: TextStyle(color: Colors.green),
            ),

            const SizedBox(height: 16),
            TextField(
              controller: _remarksController,
              decoration: const InputDecoration(
                labelText: 'Admin Remarks',
              ),
            ),

            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green),
                    onPressed: () => _setDecision('approved'),
                    child: const Text('APPROVE'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red),
                    onPressed: () => _setDecision('rejected'),
                    child: const Text('REJECT'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
