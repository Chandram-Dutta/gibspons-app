import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gibspons/presentation/widgets/gibspons_logo.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          return Scaffold(
            body: Row(
              children: [
                Container(
                  width: 300,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 64.0,
                      horizontal: 12,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const GibSponsLogoDark(),
                          const Gap(48),
                          ListTile(
                            selected: _selectedIndex == 0,
                            selectedTileColor:
                                Theme.of(context).colorScheme.secondary,
                            textColor: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            iconColor: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            leading: const Icon(Icons.dashboard_rounded),
                            title: const Text("Dashboard"),
                            onTap: () {
                              setState(() {
                                _selectedIndex = 0;
                              });
                              context.go('/dashboard');
                            },
                          ),
                          ListTile(
                            selected: _selectedIndex == 1,
                            selectedTileColor:
                                Theme.of(context).colorScheme.secondary,
                            textColor: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            iconColor: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            leading: const Icon(Icons.messenger_rounded),
                            title: const Text("Generate Mails"),
                            onTap: () {
                              setState(() {
                                _selectedIndex = 1;
                              });
                              context.go('/generate-mails');
                            },
                          ),
                          ListTile(
                            selected: _selectedIndex == 2,
                            selectedTileColor:
                                Theme.of(context).colorScheme.secondary,
                            textColor: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            iconColor: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            leading: const Icon(Icons.mail_rounded),
                            title: const Text("View Mails"),
                            onTap: () {
                              setState(() {
                                _selectedIndex = 2;
                              });
                              context.go('/view-mails');
                            },
                          ),
                          ListTile(
                            selected: _selectedIndex == 3,
                            selectedTileColor:
                                Theme.of(context).colorScheme.secondary,
                            textColor: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            iconColor: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            leading: const Icon(Icons.settings_rounded),
                            title: const Text("Settings"),
                            onTap: () {
                              setState(() {
                                _selectedIndex = 3;
                              });
                              context.go('/settings');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 64,
                        child: Row(
                          children: [
                            const Spacer(),
                            TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                CupertinoIcons.person_crop_circle,
                              ),
                              label: const Text("Name"),
                            ),
                            const Gap(
                              12,
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: widget.child),
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          return Scaffold(
            body: widget.child,
            bottomNavigationBar: NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                switch (index) {
                  case 0:
                    context.go('/dashboard');
                    break;
                  case 1:
                    context.go('/generate-mails');
                    break;
                  case 2:
                    context.go('/view-mails');
                    break;
                  case 3:
                    context.go('/settings');
                    break;
                }
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(
                    Icons.dashboard_rounded,
                  ),
                  label: "Dashboard",
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.messenger_rounded,
                  ),
                  label: "Generate Mails",
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.mail_rounded,
                  ),
                  label: "View Mails",
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.settings_rounded,
                  ),
                  label: "Settings",
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
