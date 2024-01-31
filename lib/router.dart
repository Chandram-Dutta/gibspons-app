import 'package:flutter/material.dart';
import 'package:gibspons/dashboard/presentation/pages/dashboard_page.dart';
import 'package:gibspons/shared/presentation/pages/home_page.dart';
import 'package:gibspons/auth/presentation/pages/login_page.dart';
import 'package:gibspons/presentation/pages/mail_generation_page.dart';
import 'package:gibspons/presentation/pages/settings_page.dart';
import 'package:gibspons/auth/presentation/pages/signup_page.dart';
import 'package:gibspons/presentation/pages/view_mails_page.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return HomePage(
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardPage(),
        ),
        GoRoute(
          path: '/generate-mails',
          builder: (context, state) => const MailGenerationPage(),
        ),
        GoRoute(
          path: '/view-mails',
          builder: (context, state) => const ViewMailsPage(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsPage(),
        ),
      ],
    ),
    ShellRoute(
      builder: (context, state, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 500) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: Container(
                      color: const Color.fromRGBO(23, 23, 23, 1),
                      child: Image.asset(
                        "assets/images/background.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 64.0),
                    child: SizedBox(
                      width: 500,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: child,
                      ),
                    ),
                  )
                ],
              );
            } else {
              return child;
            }
          },
        );
      },
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => const SignUpPage(),
        ),
      ],
    ),
  ],
);
