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

  final ImagePicker _picker = ImagePicker();

  Future<void> _capturePhoto() async {
    final XFile? photo =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 70);

    if (photo != null) {
      setState(() {
        _image = File(photo.path);
        _timestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      });
      await _getLocation();
    }
  }

  Future<void> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _position = position;
    });
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
              icon: const Icon(Icons.camera_alt),
              label: const Text('Capture Photo'),
              onPressed: _capturePhoto,
            ),
            const SizedBox(height: 16),

            if (_image != null)
              Image.file(_image!, height: 220, fit: BoxFit.cover),

            const SizedBox(height: 16),

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
                          content: Text('Evidence saved (mock upload)'),
                        ),
                      );
                    },
              child: const Text('Submit Evidence'),
            ),
          ],
        ),
      ),
    );
  }
}
