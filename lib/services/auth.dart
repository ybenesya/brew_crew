import 'package:firebase_auth/firebase_auth.dart';
import 'package:ron/models/user.dart';
import 'package:ron/services/datadase.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object base on FirebaseUser
  NewUser? _userFromFirebaseUser(User user){
    return user != null ? NewUser(uid : user.uid) : null;
  }

  // auth cahnge user stream
  Stream<NewUser?> get user{
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sigh in anon
  Future signInAnon() async{
    try{
      UserCredential result =  await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

// sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

//register with email and password
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      //create a new document for the user with the uid
      await DatabaseService(uid:user.uid).updateUserData('0', 'new crew member', 100);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

// sigh out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}