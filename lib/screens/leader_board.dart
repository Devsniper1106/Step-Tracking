import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_step_tracking/sevices/firebase_auth_service.dart';
import 'package:flutter_step_tracking/widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;

    return Scaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(user.email!,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('23',
                  style: const TextStyle(
                      fontSize: 80,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    onTap: () {
                      context.read<FirebaseAuthMethods>().signOut(context);
                    },
                    icon: const Icon(Icons.logout),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  CustomButton(
                    onTap: () {
                      context
                          .read<FirebaseAuthMethods>()
                          .deleteAccount(context);
                    },
                    icon: const Icon(Icons.delete_forever),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    ));
  }
}
