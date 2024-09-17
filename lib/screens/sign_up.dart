import 'package:flutter/material.dart';
import 'package:flutter_step_tracking/screens/sign_in.dart';
import 'package:provider/provider.dart';
import 'package:flutter_step_tracking/sevices/firebase_auth_service.dart';
import 'package:flutter_step_tracking/widgets/custom_text_field.dart';

class EmailPasswordSignup extends StatefulWidget {
  static String routeName = '/signup-email-password';
  const EmailPasswordSignup({Key? key}) : super(key: key);

  @override
  _EmailPasswordSignupState createState() => _EmailPasswordSignupState();
}

class _EmailPasswordSignupState extends State<EmailPasswordSignup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signUpUser() async {
    context.read<FirebaseAuthMethods>().signUpWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Sign Up",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: emailController,
              hintText: 'Enter your email',
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: passwordController,
              hintText: 'Enter your password',
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            child: const Text('You already have an account?',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue,
                )),
            onTap: () {
              Navigator.pushNamed(context, EmailPasswordLogin.routeName);
            },
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: signUpUser,
            style: ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll(Colors.blue),
              textStyle: const WidgetStatePropertyAll(
                TextStyle(color: Colors.white),
              ),
              minimumSize: WidgetStatePropertyAll(
                Size(MediaQuery.of(context).size.width / 2.5, 50),
              ),
            ),
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
