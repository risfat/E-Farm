import 'package:firebase_auth/firebase_auth.dart';


class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;
  User? get cUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //For Login
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email:email,
        password:password,
    );
  }


  //For Signup

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String userName
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email:email,
      password:password,
    ).then((value){
      // var name = userName.trim().split(' ');
      currentUser?.updateDisplayName(userName);
    });
  }


  //For SignOut
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  String? getUserName() {

    // setState(() {
    //   userName = FirebaseAuth.instance.currentUser!.displayName.toString();
    // });

    return currentUser?.displayName.toString();
  }

  String? getUserEmail() {

    // setState(() {
    //   userName = FirebaseAuth.instance.currentUser!.displayName.toString();
    // });

    return currentUser?.email.toString();
  }

  String? getUid() {

    return currentUser?.uid;
  }


}