import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';

/// This is the Provider class for the Users.
class UserProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Below function handles the registration of a user with email and password
  Future registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      // create a new document for the user with the uid
      await addUserData(
        currentUser: user,
        userEmail: email,
        userName: name,
      );
      return _userFromFirebaseUser(user);
    } catch (error) {
      return null;
    }
  }

  /// below function creates a [UserModel] object based on firebase user
  UserModel? _userFromFirebaseUser(User? user) {
    return user != null
        ? UserModel(
            userUid: user.uid,
            userName: user.displayName,
            userEmail: user.email)
        : null;
  }

  /// Below function handles the sign in functionality with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      return null;
    }
  }

  /// Below function creates a new document for the user with the uid
  Future<void> addUserData({
    User? currentUser,
    String? userName,
    String? userEmail,
  }) async {
    await FirebaseFirestore.instance
        .collection("usersData")
        .doc(currentUser?.uid)
        .set(
      {
        "userName": userName,
        "userEmail": userEmail,
        "userUid": currentUser?.uid,
      },
    );
  }

  UserModel? currentData;

  /// Below function can be used to fetch the user Information
  /// like Email, name and userID
  /// Can be used in case of displaying these info in UI
  void getUserData() async {
    UserModel userModel;
    var value = await FirebaseFirestore.instance
        .collection("usersData")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (value.exists) {
      userModel = UserModel(
        userEmail: value.get("userEmail"),
        userName: value.get("userName"),
        userUid: value.get("userUid"),
      );
      currentData = userModel;
      notifyListeners();
    }
  }

  /// getter returning the [UserModel] of the current user
  UserModel? get currentUserData {
    return currentData;
  }
}
