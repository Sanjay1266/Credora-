import 'package:hive/hive.dart';
import '../models/evidence_model.dart';

class LocalStorageService {
  final Box box = Hive.box('evidenceBox');

  void saveEvidence(EvidenceModel evidence) {
    box.put(evidence.id, evidence.toMap());
  }

  List<EvidenceModel> getPendingEvidence() {
    return box.values
        .map((e) => EvidenceModel.fromMap(Map.from(e)))
        .where((e) => !e.synced)
        .toList();
  }

  void markAsSynced(String id) {
    final data = box.get(id);
    if (data != null) {
      data['synced'] = true;
      box.put(id, data);
    }
  }
}
