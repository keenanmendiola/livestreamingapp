import 'package:basecode/services/FirebaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepository {
  FirebaseService firebaseService = FirebaseService();

  Future<User> getCurrentUser() => firebaseService.getCurrentUser();

  Future<UserCredential> signInWithGoogle() =>
      firebaseService.signInWithGoogle();

  Future<bool> authenticateUser(UserCredential userCredential) =>
      firebaseService.authenticateUser(userCredential);

  Future<void> addNewUser(UserCredential userCredential) =>
      firebaseService.addNewUser(userCredential);

  Future<void> signOut() => firebaseService.signOut();
}
