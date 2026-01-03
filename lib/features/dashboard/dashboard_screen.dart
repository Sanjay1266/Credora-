import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/auth_provider.dart';
import '../../core/constants/user_role.dart';
import 'user_dashboard.dart';
import 'verifier_dashboard.dart';
import 'admin_dashboard.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(userRoleProvider);

    switch (role) {
      case UserRole.user:
        return const UserDashboard();
      case UserRole.verifier:
        return const VerifierDashboard();
      case UserRole.admin:
        return const AdminDashboard();
      default:
        return const Scaffold(
          body: Center(child: Text('No role selected')),
        );
    }
  }
}
