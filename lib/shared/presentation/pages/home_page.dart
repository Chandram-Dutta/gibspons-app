import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:gibspons/auth/repository/auth_repository.dart';
import 'package:gibspons/shared/presentation/widgets/gibspons_logo.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
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
                          const GibSponsLogoDark(
                            description: "By GDSC VIT",
                          ),
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
                            title: const Text("My Team"),
                            onTap: () {
                              setState(() {
                                _selectedIndex = 0;
                              });
                              context.go('/my-team');
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
                            leading: const Icon(Icons.people_rounded),
                            title: const Text("Members"),
                            onTap: () {
                              setState(() {
                                _selectedIndex = 1;
                              });
                              context.go('/members');
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
                            leading: const Icon(Icons.monetization_on_rounded),
                            title: const Text("Sponsorships"),
                            onTap: () {
                              setState(() {
                                _selectedIndex = 2;
                              });
                              context.go('/sponsorships');
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
                            IconButton(
                              onPressed: () {
                                //todo: improve this
                                ref.read(djangoAuthRepositoryProvider).logout();
                                context.go('/login');
                              },
                              icon: const Icon(Icons.logout),
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
                    context.go('/my-team');
                    break;
                  case 1:
                    context.go('/members');
                    break;
                  case 2:
                    context.go('/sponsorships');
                    break;
                }
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(
                    Icons.dashboard_rounded,
                  ),
                  label: "My Team",
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.people_rounded,
                  ),
                  label: "Members",
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.monetization_on_rounded,
                  ),
                  label: "Sponsorships",
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
