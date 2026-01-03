import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/login_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/project/create_project_screen.dart';
import '../features/verification/select_project_screen.dart';
import '../features/verification/capture_evidence_screen.dart';

import '../models/project_model.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/create-project',
      builder: (context, state) => const CreateProjectScreen(),
    ),
    GoRoute(
      path: '/select-project',
      builder: (context, state) => const SelectProjectScreen(),
    ),
    GoRoute(
      path: '/capture-evidence',
      builder: (context, state) {
        final project = state.extra as ProjectModel;
        return CaptureEvidenceScreen(project: project);
      },
    ),
  ],
);
