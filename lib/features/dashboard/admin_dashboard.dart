import 'package:flutter/material.dart';
import '../admin/admin_project_list_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Review Projects'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const AdminProjectListScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
