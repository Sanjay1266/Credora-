import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../models/evidence_model.dart';
import '../../models/project_model.dart';
import '../../services/local_storage_service.dart';

class CaptureEvidenceScreen extends StatefulWidget {
  final ProjectModel project;

  const CaptureEvidenceScreen({
    super.key,
    required this.project,
  });

  @override
  State<CaptureEvidenceScreen> createState() =>
      _CaptureEvidenceScreenState();
}

class _CaptureEvidenceScreenState
    extends State<CaptureEvidenceScreen> {
  File? _image;
  Position? _position;
  String _timestamp = '';
  bool _loading = false;

  final ImagePicker _picker = ImagePicker();
  final LocalStorageService _storage = LocalStorageService();

  Future<void> _capturePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
    );

    if (photo == null) return;

    setState(() {
      _loading = true;
    });

    final position = await _getLocation();

    setState(() {
      _image = File(photo.path);
      _position = position;
      _timestamp =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      _loading = false;
    });
  }

  Future<Position?> _getLocation() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return null;
    }

    LocationPermission permission =
        await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  void _saveEvidence() {
    final evidence = EvidenceModel(
      id: const Uuid().v4(),
      projectId: widget.project.id,
      imagePath: _image!.path,
      latitude: _position!.latitude,
      longitude: _position!.longitude,
      timestamp: _timestamp,
    );

    _storage.saveEvidence(evidence);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Saved offline')),
    );

    setState(() {
      _image = null;
      _position = null;
      _timestamp = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Field Evidence'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              'Project: ${widget.project.name}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _loading ? null : _capturePhoto,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Capture Photo'),
            ),
            const SizedBox(height: 16),
            if (_loading)
              const Center(child: CircularProgressIndicator()),
            if (_image != null) ...[
              Image.file(
                _image!,
                height: 220,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 12),
            ],
            if (_position != null) ...[
              Text('Latitude : ${_position!.latitude}'),
              Text('Longitude: ${_position!.longitude}'),
            ],
            if (_timestamp.isNotEmpty)
              Text('Timestamp: $_timestamp'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed:
                  _image == null || _position == null
                      ? null
                      : _saveEvidence,
              child: const Text('Save Evidence'),
            ),
          ],
        ),
      ),
    );
  }
}
