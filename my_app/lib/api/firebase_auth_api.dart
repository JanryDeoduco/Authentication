import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthApi {
  late FirebaseAuth auth;
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuthApi(){
    auth = FirebaseAuth.instance;
    
  }

  Stream<User?> fetchUser() {
    return auth.authStateChanges();
  }

  User? getUser(){
    return auth.currentUser;
  }

  Future<String?> signUp(String email, String password, String fname, String lname)
  async {
    try {
      await auth.createUserWithEmailAndPassword(email:email, password: password);
      // Add first name and last name
      await db.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set({
        'fname' : fname,
        'lname' : lname,
        'email' : email,
        
        }
      );
    } on FirebaseException catch (e) {
      print('Firebase Error: ${e.code} : ${e.message}');
      return e.code;
    }catch (e){
    print('Error $e');
    } 
  }

  Future<String?> signIn(String email, String password) async {
    try {
      UserCredential credentials = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(credentials);
      print("////////*////////////*///////////*////////");
      return "Success";
    } on FirebaseException catch (e) {
      print('Firebase Error: ${e.code} : ${e.message}');
      return e.code;
    } catch (e) {
      return ('Error $e');
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Stream<QuerySnapshot> getAllUsers(){
    return db.collection("users").snapshots();
  }


}