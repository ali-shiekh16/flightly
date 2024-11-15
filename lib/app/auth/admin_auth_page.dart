import 'package:flightly/pages/admin-pages/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flightly/app/theme/colors.dart';
import 'package:flightly/app/sizes.dart';

class adminAuth extends StatefulWidget {
  const adminAuth({super.key});

  @override
  State<adminAuth> createState() => _adminAuthState();
}

class _adminAuthState extends State<adminAuth> {
  final formKey = GlobalKey<FormState>();
  final email_contol = TextEditingController();
  final password_contol = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email_contol.dispose();
    password_contol.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Authentication'),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 350,
                child: TextFormField(
                  controller: email_contol,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'Email', helperText: 'Enter Email'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please Enter Email';
                    } else if (!value!.contains('admin@gmail.com')) {
                      return 'Wrong Email';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: TextFormField(
                    controller: password_contol,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Password', helperText: 'Enter Password'),
                    validator: (value) {
                      if (value == null) {
                        return 'Please Enter password';
                      } else if (value!.length <= 5) {
                        return 'Password have Atleast 6 character ';
                      } else if (!value!.contains('admin1')) {
                        return 'Wrong Password';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("login successfull"),
                          backgroundColor: AppColors.primary,
                          duration: Duration(seconds: 4),
                        ),
                      );

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminScreen()));
                    }
                  },
                  child: Text('Login')),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("SignUp successfull"),
                          backgroundColor: AppColors.primary,
                          duration: Duration(seconds: 2),
                        ),
                      );

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminScreen()));
                    }
                  },
                  child: Text('SignUp'))
            ],
          ),
        ),
      ),
    );
  }
}
