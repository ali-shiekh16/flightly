import 'package:flightly/pages/start_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flightly/pages/home_screen.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  User? _user;
  final SupabaseClient supabase = Supabase.instance.client;

  @override
  void initState() {
    _getAuth();
    super.initState();
  }

  Future<void> _getAuth() async {
    setState(() {
      _user = supabase.auth.currentUser;
    });

    supabase.auth.onAuthStateChange.listen((event) {
      setState(() {
        _user = event.session?.user;
      });
      if (_user != null) {
        // Navigate to HomeScreen after login
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _user == null
        ? const StartPage()
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Welcome ${_user!.email}',
                    style: const TextStyle(fontSize: 28),
                    textAlign: TextAlign.center),
              ),
              ElevatedButton(
                  onPressed: () async => {
                        await supabase.auth.signOut(),
                      },
                  child: const Text('Sign out!'))
            ],
          );
  }
}
