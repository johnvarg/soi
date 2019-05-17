import 'dart:async';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
    Future<String> currentUser();
    Future<String> emailPasswordSignIn(String email, String password);
    //Future<FirebaseUser> googleSignIn();
    Future<String> createUser(String email, String password);
    Future<void> signOut();
    Future<void> sendPasswordResetEmail(String emailAddress);
}

/*class Auth implements BaseAuth {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    bool signedInGoogle = false;

    Future<String> emailPasswordSignIn(String email, String password) async {

        try{

            FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
                email: email, password: password);

            return user.uid;

        }catch(error){
            print('Error: ' + error.toString());
        }
    }

    Future<FirebaseUser> googleSignIn() async {
        final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

        final FirebaseUser user = await _firebaseAuth.signInWithGoogle(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
        );

        assert(user.email != null);
        assert(user.displayName != null);

        assert(await user.getIdToken() != null);

        /*
    I removed this code when I upgraded Firebase auth to 0.6.x , verify it's ok to remove.

     */
        //final FirebaseUser currentUser = await _firebaseAuth.currentUser();
        //assert(user.uid == currentUser.uid);

        return user;
    }

    Future<String> createUser(String email, String password) async {
        FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        return user.uid;
    }

    Future<String> currentUser() async {
        FirebaseUser user = await _firebaseAuth.currentUser();
        return user != null ? user.uid : null;
    }

    Future<void> signOut() async {

        _googleSignIn.signOut();

        return _firebaseAuth.signOut();
    }

    Future<void> sendPasswordResetEmail(String emailAddress) async {

        return _firebaseAuth.sendPasswordResetEmail(email: emailAddress);
    }

}
*/