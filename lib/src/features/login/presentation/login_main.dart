import 'package:flutter/material.dart';

class LoginMain extends StatefulWidget {
  const LoginMain({super.key});

  @override
  State<LoginMain> createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  final loginEC = TextEditingController();
  final passwordEC = TextEditingController();
  bool rememberMe = false;

  @override
  void dispose() {
    loginEC.dispose();
    passwordEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              const Text('Login'),
              TextFormField(
                controller: loginEC,
                decoration: InputDecoration(hintText: 'Login'),
              ),
              TextFormField(
                controller: passwordEC,
                decoration: InputDecoration(hintText: 'Password'),
              ),
              ListTile(
                title: const Text('Lembrar de mim'),
                leading: Radio<bool>(
                  value: !rememberMe,
                  groupValue: rememberMe,
                  onChanged: (value) {
                    setState(() {
                      rememberMe = value!;
                    });
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
