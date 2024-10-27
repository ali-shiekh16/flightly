import 'dart:developer';

import 'package:flightly/app/theme/colors.dart';
import 'package:flightly/core/utils/form_validations.dart';
import 'package:flightly/widgets/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  bool _signInLoading = false;
  bool _signUpLoading = false;
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(
                20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AuthTextField(
                    label: 'Email',
                    hint: 'Enter your email',
                    onSubmit: (x) => setState(() => _email = x),
                    validator: FormValidations.email,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                  ),
                  AuthTextField(
                      label: 'Password',
                      hint: 'Enter your password',
                      obscure: true,
                      onSubmit: (x) => setState(() => _password = x),
                      validator: FormValidations.password,
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword),

                  const SizedBox(height: 25.0),
                  //Sign In Button
                  ElevatedButton(
                    onPressed: () async {
                      final isValid = _formKey.currentState?.validate();
                      if (isValid != true) {
                        return;
                      }
                      setState(() {
                        _signInLoading = true;
                      });
                      try {
                        await supabase.auth.signInWithPassword(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim());
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Invalid email or password!"),
                            backgroundColor: AppColors.primary,
                          ),
                        );
                        setState(() {
                          _signInLoading = false;
                        });
                      }
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(),
                  //SignUp Button
                  if (_signInLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    OutlinedButton(
                      onPressed: () async {
                        final isValid = _formKey.currentState?.validate();
                        if (isValid != true) {
                          return;
                        }
                        setState(() {
                          _signUpLoading = true;
                        });
                        try {
                          await supabase.auth.signUp(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Sign up complete!"),
                              backgroundColor: Colors.green,
                            ),
                          );
                          setState(() {
                            _signUpLoading = false;
                          });
                        } catch (e) {
                          log(e.toString());
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Oops!Sign up Failed!"),
                                backgroundColor: AppColors.primary),
                          );
                          setState(() {
                            _signUpLoading = false;
                          });
                        }
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
