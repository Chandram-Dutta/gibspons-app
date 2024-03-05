import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:gibspons/auth/repository/auth_repository.dart';
import 'package:go_router/go_router.dart';

class JoinTeam extends ConsumerStatefulWidget {
  const JoinTeam({
    super.key,
  });

  @override
  ConsumerState<JoinTeam> createState() => _JoinTeamState();
}

class _JoinTeamState extends ConsumerState<JoinTeam> {
  final TextEditingController _inviteCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _inviteCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              //todo: improve this
              await ref.read(djangoAuthRepositoryProvider).logout();
              if (context.mounted) {
                context.go('/login');
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width > 600
                        ? 600
                        : double.infinity,
                    child: Text(
                      "This account is not associated with a team yet. Create a team, or join an existing one to continue.",
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Gap(12),
                  SizedBox(
                    width: MediaQuery.of(context).size.width > 600
                        ? 400
                        : double.infinity,
                    child: TextFormField(
                      controller: _inviteCodeController,
                      decoration: const InputDecoration(
                        labelText: "Invite Code",
                        hintText: "Enter the invite code",
                      ),
                    ),
                  ),
                  const Gap(24),
                  SizedBox(
                    height: 48,
                    width: MediaQuery.of(context).size.width > 600
                        ? 200
                        : double.infinity,
                    child: FilledButton(
                      child: const Text("Join Team"),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      },
                    ),
                  ),
                  const Gap(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don’t have an Invite Code?"),
                      const Gap(8),
                      GestureDetector(
                        onTap: () {
                          // context.go('/signup');
                        },
                        child: Text(
                          "Create Your Own Team.",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
