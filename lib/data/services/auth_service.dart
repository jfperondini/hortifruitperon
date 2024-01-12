import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_exception.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  Future<User?> getAuthUser() async {
    user = auth.currentUser;
    return (user != null) ? user : null;
  }

  Future<bool> isTokenValid() async {
    user = auth.currentUser;
    if (user != null) {
      try {
        await user?.reload();
        user = auth.currentUser;
        return true;
      } on FirebaseAuthException catch (e) {
        e.message;
        return false;
      }
    }
    return false;
  }

  register({required String email}) async {
    try {
      await auth.fetchSignInMethodsForEmail(email);
      await auth.createUserWithEmailAndPassword(email: email, password: '123456');
      return user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        try {
          await auth.signInWithEmailAndPassword(email: email, password: '123456');
          return user = auth.currentUser;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            throw AuthException('Email não foi encontrado');
          }
        }
      }
    }
  }

  logout() async {
    await auth.signOut();
    return user = auth.currentUser;
  }
}
