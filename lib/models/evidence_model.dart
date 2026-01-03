class EvidenceModel {
  final String id;
  final String imagePath;
  final double latitude;
  final double longitude;
  final String timestamp;
  bool synced;

  EvidenceModel({
    required this.id,
    required this.imagePath,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    this.synced = false,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
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
    );
  }
}
