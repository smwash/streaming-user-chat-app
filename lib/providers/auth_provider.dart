import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:my_chat_app/model/user.dart';
import 'package:my_chat_app/services/database.dart';

class AuthProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _database = Database();
  var message = '';

  String _userName;
  String _email;
  String _password;

//Getters:
  String get username => _userName;
  String get email => _email;
  String get password => _password;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? User(userId: user.uid, userName: user.displayName, email: user.email)
        : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

//Setters:
  changeUsername(String username) {
    _userName = username;
    notifyListeners();
  }

  changeUseremail(String email) {
    _email = email;
    notifyListeners();
  }

  changeUserpassword(String password) {
    _password = password;
    notifyListeners();
  }

  //create user and signup:
  Future signUpUser() async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //update username
      var userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = username;
      await authResult.user.updateProfile(userUpdateInfo);
      await authResult.user.reload();
      //adding user to database:
      var user = User(
        email: email,
        userName: username,
        userId: authResult.user.uid,
      );
      _database.addUser(user);
      return _userFromFirebaseUser(authResult.user);
    } on PlatformException catch (error) {
      //print(error);
      if (error != null) {
        message = error.message;
        //notifyListeners();
      }
    } catch (error) {
      //print(error.message);
    }
  }

  //login user:
  Future loginUser() async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on PlatformException catch (error) {
      print(error);
      if (error != null) {
        message = error.message;
        //notifyListeners();
      }
    } catch (error) {}
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (error) {
      print(error);
    }
  }
}
