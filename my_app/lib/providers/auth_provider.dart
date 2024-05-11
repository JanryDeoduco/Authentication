import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:week9_authentication/api/firebase_auth_api.dart';

class UserAuthProvider with ChangeNotifier{
  late FirebaseAuthApi authService;
  late Stream<User?> _userStream;

  late Stream<QuerySnapshot> _UserNameStream; //stream for names

  fetchUserNames() {
    _UserNameStream = authService.getAllUsers();
    notifyListeners();
  }
  Stream<QuerySnapshot> get UserNameStream => _UserNameStream;

  Stream<User?> get userStream => _userStream;
  User? get user => authService.getUser(); //TODO Fetch user from api

  UserAuthProvider(){
    authService = FirebaseAuthApi();
    fetchUser();
    fetchUserNames();
  }

  void fetchUser(){  //for email and pw
    _userStream = authService.fetchUser();
  }

  Future<void> signOut() async {
    await authService.signOut();
  }

  

}