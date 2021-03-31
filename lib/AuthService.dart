import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
      (FirebaseUser user) => user?.uid,
  );

  //uid
  Future<String> getUserID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  //Sign up
  Future<String> createUserWithEmailAndPassword(String email, String password,
      String name) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
    );

    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload();
    return currentUser.uid;
  }

  //Sign in
  Future<String> signInWithEmailAndPassword(String email, String password) async{
    return (await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password)
    ).uid;
  }
  //Sign out
  signOut(){
    return _firebaseAuth.signOut();
  }
}