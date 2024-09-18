import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_step_tracking/sevices/firebase_auth_service.dart';
import 'package:flutter_step_tracking/sevices/firestore_service.dart';
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
          const SizedBox(height: 10),
          UserListView(),
        ],
      ),
    ));
  }
}

class UserListView extends StatefulWidget {
  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirestoreRepository().getStepStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');

          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.done)
            return const Text('No data');

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasData && snapshot.data != null) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: snapshot.data?.docs.map((dss) {
                  Map<String, dynamic> doc = dss.data() as Map<String, dynamic>;
                  return Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        color: Colors.blueGrey[100],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.9),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 2),
                          )
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${doc['email']}",
                            softWrap: true,
                            style: TextStyle(
                                color: Colors.blue[500], fontSize: 20)),
                        Text("${doc['step']}",
                            style: TextStyle(
                                color: Colors.green[600], fontSize: 24))
                      ],
                    ),
                  );
                }).toList() as List<Widget>);
          } else {
            return const Text("No data");
          }
        });
  }
}
