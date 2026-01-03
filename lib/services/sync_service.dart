import 'package:connectivity_plus/connectivity_plus.dart';
import 'local_storage_service.dart';

class SyncService {
  final LocalStorageService storage = LocalStorageService();

  Future<void> syncPendingEvidence() async {
    final connectivity = await Connectivity().checkConnectivity();

    if (connectivity == ConnectivityResult.none) return;

    final pending = storage.getPendingEvidence();

    for (final evidence in pending) {
      // TODO: replace with real API call
      await Future.delayed(const Duration(seconds: 1));
      storage.markAsSynced(evidence.id);
    }
  }
}
