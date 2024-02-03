import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gibspons/auth/presentation/pages/invite_code_page.dart';
import 'package:gibspons/dashboard/presentation/pages/dashboard_page.dart';
import 'package:gibspons/shared/presentation/pages/home_page.dart';
import 'package:gibspons/auth/presentation/pages/login_page.dart';
import 'package:gibspons/presentation/pages/mail_generation_page.dart';
import 'package:gibspons/presentation/pages/settings_page.dart';
import 'package:gibspons/auth/presentation/pages/signup_page.dart';
import 'package:gibspons/presentation/pages/view_mails_page.dart';
import 'package:gibspons/shared/presentation/widgets/gibspons_logo.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/login',
  redirect: (context, state) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');
    if (token == null) {
      if (state.uri.toString() == '/login') {
        return '/login';
      } else if (state.uri.toString() == '/signup') {
        return '/signup';
      } else if (state.uri.toString() == '/invite-code') {
        return '/invite-code';
      } else {
        return '/login';
      }
    }
    return null;
  },
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
      builder: (
        context,
        state,
        child,
      ) {
        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 700) {
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
                    Row(
                      children: [
                        const Expanded(
                          child: GibSponsLogoDark(
                            description: "sponsorships made easier",
                          ),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                            child: child,
                          ),
                        ),
                      ],
                    )
                  ],
                );
              } else {
                return child;
              }
            },
          ),
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
        GoRoute(
          path: '/invite-code',
          builder: (context, state) => const InviteCodePage(),
        ),
      ],
    ),
  ],
);
