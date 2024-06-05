import 'package:flutter/material.dart';
import 'homescreen.dart';
import '../storage_model/storage.dart';
import '../backend/authentication.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SecureStorage _secureStorage = SecureStorage();

  @override
  void initState() {
    super.initState();
    _loadInitialCredentials();
  }

  Future<void> _loadInitialCredentials() async {
    final initialMail = await _secureStorage.getUserName();
    final initialPassword = await _secureStorage.getPassWord();
    setState(() {
      _emailController.text = initialMail ?? '';
      _passwordController.text = initialPassword ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'IITK Mail Client',
          style: TextStyle(
            color: Color.fromRGBO(47, 5, 81, 1),
            fontSize: 25,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 157, 102, 213),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      gapPadding: 8.0,
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        gapPadding: 8.0,
                      )),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() == true) {
                    bool isAuth = await authenticateUser(
                        email: _emailController.text,
                        password: _passwordController.text);

                    if (isAuth) {
                      print("succesfull");
                      await _secureStorage.setUserName(_emailController.text);
                      await _secureStorage
                          .setPassWord(_passwordController.text);

                      print(await _secureStorage.getUserName());

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    }
                  }
                },
                child: const Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
