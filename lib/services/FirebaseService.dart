import 'package:basecode/models/User.dart';
import 'package:basecode/utils/getUsername.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Account account;

  Future<User> getCurrentUser() async {
    User user;
    user = auth.currentUser;
    return user;
  }

  Future<UserCredential> signInWithGoogle() async {
    //googleSignIn.signIn() calls the login popup by google and waits for the user to enter credentials.
    //googleSignInAccount will contain the credentials.
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    //authenticates the credentials inputted by the user.
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    //gets the auth credentials to be used for loggin in.
    final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    //signin user
    UserCredential userCredential =
        await auth.signInWithCredential(authCredential);
    return userCredential;
  }

  Future<bool> authenticateUser(UserCredential userCredential) async {
    //get data of user from the database
    QuerySnapshot result = await firestore
        .collection("users")
        .where("email", isEqualTo: userCredential.user.email)
        .get();

    //set result to a list
    final List<DocumentSnapshot> documents = result.docs;

    //if user is already registered, the length of the list is greater than 0
    return documents.length == 0 ? true : false;
  }

  Future<void> addNewUser(UserCredential userCredential) async {
    Account account = Account(
      uid: userCredential.user.uid,
      email: userCredential.user.email,
      name: userCredential.user.displayName,
      profilePhoto: userCredential.user.photoURL,
      username: getUsername(userCredential.user.email),
    );
    print("Account: ${account.uid}");
    firestore
        .collection("users")
        .doc(userCredential.user.uid)
        .set(account.toMap(account));
  }
}
