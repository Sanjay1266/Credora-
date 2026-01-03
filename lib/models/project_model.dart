class ProjectModel {
  final String id;
  final String name;
  final String location;

  String adminStatus; // pending / approved / rejected
  String? adminRemarks;

  ProjectModel({
    required this.id,
    required this.name,
    required this.location,
    this.adminStatus = 'pending',
    this.adminRemarks,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'location': location,
        'adminStatus': adminStatus,
        'adminRemarks': adminRemarks,
      };

  factory ProjectModel.fromMap(Map data) {
    return ProjectModel(
      id: data['id'],
      name: data['name'],
      location: data['location'],
      adminStatus: data['adminStatus'] ?? 'pending',
      adminRemarks: data['adminRemarks'],
    );
  }
}
