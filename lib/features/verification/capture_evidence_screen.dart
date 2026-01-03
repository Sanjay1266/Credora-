import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class CaptureEvidenceScreen extends StatefulWidget {
  const CaptureEvidenceScreen({super.key});

  @override
  State<CaptureEvidenceScreen> createState() => _CaptureEvidenceScreenState();
}

class _CaptureEvidenceScreenState extends State<CaptureEvidenceScreen> {
  File? _image;
  Position? _position;
  String _timestamp = '';
  bool _loading = false;

  final ImagePicker _picker = ImagePicker();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Capture Field Evidence')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ElevatedButton.icon(
              onPressed: _loading ? null : _capturePhoto,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Capture Photo'),
            ),

            const SizedBox(height: 16),

            if (_loading)
              const Center(child: CircularProgressIndicator()),

            if (_image != null) ...[
              Image.file(_image!, height: 220, fit: BoxFit.cover),
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
              onPressed: _image == null || _position == null
                  ? null
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Evidence captured successfully (mock)'),
                        ),
                      );
                    },
              child: const Text('Save Evidence'),
            ),
          ],
        ),
      ),
    );
  }
}
