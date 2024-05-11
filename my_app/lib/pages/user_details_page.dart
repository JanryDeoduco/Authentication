import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week9_authentication/models/user_model.dart';
import 'package:week9_authentication/providers/auth_provider.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  User? user;
  String? fname = "";
  String? lname = "";
  @override
  Widget build(BuildContext context) {
    user = context.read<UserAuthProvider>().user;
    Stream<QuerySnapshot> UsernameStream = context.watch<UserAuthProvider>().UserNameStream; //For fetching
    print(UsernameStream);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Details"),
        ),
        body: StreamBuilder(
          stream: UsernameStream,
          builder: ((context, snapshot){
            if (snapshot.hasError){
              return Center(
                child: Text("Error encounteres! ${snapshot.error}"),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting){
              return Center (
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData){
              return Center(
                child: Text("No Friends Found"),
              );
            }
            // UserName userName = UserName.fromJson(
            //   snapshot.data?.docs[0].data() as Map<String, dynamic>
            // );
            
            for(QueryDocumentSnapshot doc in snapshot.data!.docs){
              //converts document snapshot into object
              UserName userName = UserName.fromJson(doc.data() as Map<String, dynamic>);
              print(userName.email);

              if (userName.email == user!.email!){
                fname = userName.fname;
                lname = userName.lname;
                
              }
            }




            return Container(
              margin: EdgeInsets.all(30),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Email:",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(user!.email!, style: const TextStyle(fontSize: 20)),
                    
                    const Text(
                      "First Name:",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(fname!, style: const TextStyle(fontSize: 20)),
                    const Text(
                      "Last Name:",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(lname!, style: const TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            );
          }),
          
        ));
  }
}
