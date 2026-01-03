import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../services/api_service.dart';
import '../../core/constants/user_role.dart';
import '../../core/providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  UserRole? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credora Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 24),
            const Text('Select Role'),
            const SizedBox(height: 8),
            DropdownButtonFormField<UserRole>(
              value: _selectedRole,
              items: const [
                DropdownMenuItem(
                  value: UserRole.user,
                  child: Text('Project Owner / User'),
                ),
                DropdownMenuItem(
                  value: UserRole.verifier,
                  child: Text('Verifier'),
                ),
                DropdownMenuItem(
                  value: UserRole.admin,
                  child: Text('Admin'),
                ),
              ],
              onChanged: (role) {
                setState(() {
                  _selectedRole = role;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedRole == null
                    ? null
                    : () async {
                        final result =
                            await ApiService.login('verifier@mail.com');

                        ref.read(userRoleProvider.notifier).state =
                            _selectedRole;

                        context.go('/dashboard');
                      },
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
