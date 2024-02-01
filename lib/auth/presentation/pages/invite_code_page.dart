import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class InviteCodePage extends StatefulWidget {
  const InviteCodePage({
    super.key,
  });

  @override
  State<InviteCodePage> createState() => _InviteCodePageState();
}

class _InviteCodePageState extends State<InviteCodePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(
                  constraints.maxWidth *
                      (constraints.maxWidth > 600 ? 0.2 : 0.05),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "You're almost there.",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      "Complete your details to continue!",
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(32),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: "Username",
                      ),
                    ),
                    const Gap(18),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: "Team Invite Code (Optional)",
                      ),
                    ),
                    const Gap(18),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton(
                        onPressed: () {},
                        child: const Text(
                          "Complete Sign Up",
                        ),
                      ),
                    ),
                    const Gap(18),
                    Wrap(
                      alignment: WrapAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an Invite Code?  "),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Complete sign up to create your own.",
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
          );
        },
      ),
    );
  }
}
