import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gibspons/auth/domain/models/user_model.dart';
import 'package:gibspons/auth/presentation/pages/jointeam_page.dart';
import 'package:gibspons/myteam/presentation/pages/myteam_page.dart';
import 'package:gibspons/shared/presentation/pages/home_page.dart';
import 'package:gibspons/auth/presentation/pages/login_page.dart';
import 'package:gibspons/presentation/pages/members_page.dart';
import 'package:gibspons/auth/presentation/pages/signup_page.dart';
import 'package:gibspons/presentation/pages/sponsorships_page.dart';
import 'package:gibspons/shared/presentation/widgets/gibspons_logo.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/login',
  redirect: (context, state) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');
    final user = UserModel.fromJson(
      jsonDecode((await storage.read(key: 'user')) ??
          '{"name":"", "email":"", "username":"", "organisation":null, "role":null}'),
    );
    if (token == null) {
      if (state.uri.toString() == '/login') {
        return '/login';
      } else if (state.uri.toString() == '/signup') {
        return '/signup';
      } else {
        return '/login';
      }
    } else {
      if (state.uri.toString() == '/login' ||
          state.uri.toString() == '/signup') {
        if (user.organisation == null) {
          return '/join-team';
        } else {
          return '/my-team';
        }
      } else {
        return null;
      }
    }
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
          path: '/my-team',
          builder: (context, state) => const MyTeamPage(),
        ),
        GoRoute(
          path: '/members',
          builder: (context, state) => const MembersPage(),
        ),
        GoRoute(
          path: '/sponsorships',
          builder: (context, state) => const SponsorshipsPage(),
        ),
      ],
    ),
    GoRoute(
      path: '/join-team',
      builder: (context, state) => const JoinTeam(),
    ),
    ShellRoute(
      builder: (context, state, child) {
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
      ],
    ),
  ],
);
