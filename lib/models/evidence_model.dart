class EvidenceModel {
  final String id;
  final String projectId;
  final String imagePath;
  final double latitude;
  final double longitude;
  final String timestamp;

  bool synced;
  String status; // pending / passed / failed
  String? remarks;

  EvidenceModel({
    required this.id,
    required this.projectId,
    required this.imagePath,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    this.synced = false,
    this.status = 'pending',
    this.remarks,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'projectId': projectId,
        'imagePath': imagePath,
        'latitude': latitude,
        'longitude': longitude,
        'timestamp': timestamp,
        'synced': synced,
        'status': status,
        'remarks': remarks,
      };

  factory EvidenceModel.fromMap(Map data) {
    return EvidenceModel(
      id: data['id'],
      projectId: data['projectId'],
      imagePath: data['imagePath'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      timestamp: data['timestamp'],
      synced: data['synced'] ?? false,
      status: data['status'] ?? 'pending',
      remarks: data['remarks'],
    );
  }
}
