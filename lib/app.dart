import 'package:flutter/material.dart';
import 'package:gibspons/router.dart';
import 'package:gibspons/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GibSpons',
      theme: lightTheme,
      routerConfig: routes,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GibSpons"),
      ),
    );
  }
}
