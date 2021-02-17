import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User user = userCredential.user;

      return user;
    } catch (error) {
      throw error;
    }
  }

  Future<void> handleGoogleSignOut() async {
    try {
      await googleSignIn.signOut();
      await _auth.signOut();
    } catch (error) {}
  }

  User get userInfo {
    return _auth.currentUser;
  }

  Future grabUserToken() async {
    var idToken = await _auth.currentUser.getIdToken();
    print(idToken);
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return result;
    } catch (error) {
      throw error;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      var signUpResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _auth.currentUser.sendEmailVerification();
      return signUpResult;
    } catch (error) {
      throw error;
    }
  }

  Future resendEmailVerification() async {
    try {
      await _auth.currentUser.sendEmailVerification();
    } catch (error) {
      throw error;
    }
  }

  Future resetPassword(String email) async {
    try {
      var result = await _auth.sendPasswordResetEmail(email: email);
      return result;
    } catch (error) {
      throw error;
    }
  }
}
