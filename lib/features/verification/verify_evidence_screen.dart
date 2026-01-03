import 'dart:io';
import 'package:flutter/material.dart';
import '../../models/evidence_model.dart';
import '../../services/local_storage_service.dart';

class VerifyEvidenceScreen extends StatefulWidget {
  final EvidenceModel evidence;

  const VerifyEvidenceScreen({super.key, required this.evidence});

  @override
  State<VerifyEvidenceScreen> createState() =>
      _VerifyEvidenceScreenState();
}

class _VerifyEvidenceScreenState extends State<VerifyEvidenceScreen> {
  final TextEditingController _remarksController =
      TextEditingController();
  final LocalStorageService storage = LocalStorageService();

  void _updateStatus(String status) {
    storage.updateVerification(
      widget.evidence.id,
      status,
      _remarksController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Marked as $status')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Evidence')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Image.file(File(widget.evidence.imagePath)),
            const SizedBox(height: 12),
            Text('Latitude: ${widget.evidence.latitude}'),
            Text('Longitude: ${widget.evidence.longitude}'),
            Text('Timestamp: ${widget.evidence.timestamp}'),
            const SizedBox(height: 16),
            TextField(
              controller: _remarksController,
              decoration: const InputDecoration(
                labelText: 'Remarks (if any)',
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green),
                    onPressed: () => _updateStatus('passed'),
                    child: const Text('PASS'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red),
                    onPressed: () => _updateStatus('failed'),
                    child: const Text('FAIL'),
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
