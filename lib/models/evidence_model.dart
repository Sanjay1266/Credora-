class EvidenceModel {
  final String id;
  final String imagePath;
  final double latitude;
  final double longitude;
  final String timestamp;
  final String projectId;

  bool synced;

EvidenceModel({
  required this.id,
  required this.projectId,
  required this.imagePath,
  required this.latitude,
  required this.longitude,
  required this.timestamp,
  this.synced = false,
});


  Map<String, dynamic> toMap() => {
        'id': id,
        'projectId': projectId,
        'imagePath': imagePath,
        'latitude': latitude,
        'longitude': longitude,
        'timestamp': timestamp,
        'synced': synced,
      };

  factory EvidenceModel.fromMap(Map data) {
    return EvidenceModel(
      id: data['id'],
      imagePath: data['imagePath'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      timestamp: data['timestamp'],
      synced: data['synced'],
      projectId: data['projectId'],
    );
  }
}
