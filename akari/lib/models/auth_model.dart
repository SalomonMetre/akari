import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;
  static final instance = Auth._();
  Auth._();
  factory Auth() {
    return instance;
  }

  Future<UserCredential> registerUser(
      {required String email, required String password}) async {
    return await firebaseAuthInstance.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> sendVerificationEmail() async {
    await FirebaseAuth.instance.currentUser?.sendEmailVerification();
  }

  Future<UserCredential> loginUser(
      {required String email, required String password}) async {
    return await firebaseAuthInstance.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await firebaseAuthInstance.signOut();
  }
}