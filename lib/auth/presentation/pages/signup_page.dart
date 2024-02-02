import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:gibspons/auth/presentation/controllers/signup_page_controller.dart';
import 'package:gibspons/shared/presentation/widgets/gibspons_logo.dart';
import 'package:go_router/go_router.dart';
import 'package:validators/validators.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({
    super.key,
  });

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  bool _isPasswordVisible = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<void> state = ref.watch(signupPageControllerProvider);
    ref.listen<AsyncValue>(
      signupPageControllerProvider,
      (_, state) {
        if (!state.isLoading && state.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error.toString())),
          );
        } else {
          if (!state.isLoading && state.hasValue) {
            showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: const Text("Success"),
                  content: const Text(
                      "Account created successfully. Login to continue."),
                  actions: [
                    CupertinoDialogAction(
                      isDestructiveAction: true,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"),
                    ),
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () {
                        context.go('/login');
                      },
                      child: const Text("Login"),
                    ),
                  ],
                );
              },
            );
          }
        }
      },
    );
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MediaQuery.of(context).size.width > 700
                          ? const SizedBox()
                          : const GibSponsLogoLight(
                              description: "sponsorships made easier",
                            ),
                      const Gap(48),
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name cannot be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          labelText: "Name",
                        ),
                      ),
                      const Gap(8),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email cannot be empty";
                          } else if (!isEmail(value)) {
                            return "Invalid email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          labelText: "Email",
                        ),
                      ),
                      const Gap(8),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _isPasswordVisible,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password cannot be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          labelText: "Password",
                        ),
                      ),
                      const Gap(18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("By continuing, you agree to our"),
                          const Gap(8),
                          Text(
                            "terms of service.",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const Gap(18),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: FilledButton(
                          onPressed: state.isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    ref
                                        .read(
                                          signupPageControllerProvider.notifier,
                                        )
                                        .signup(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                          name: _nameController.text,
                                        );
                                  }
                                },
                          child: state.isLoading
                              ? const CupertinoActivityIndicator()
                              : const Text("Sign Up"),
                        ),
                      ),
                      const Gap(32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          const Gap(8),
                          GestureDetector(
                            onTap: () {
                              context.go('/login');
                            },
                            child: Text(
                              "Sign In",
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
          );
        },
      ),
    );
  }
}
