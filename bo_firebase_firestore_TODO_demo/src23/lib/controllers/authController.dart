// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:get/get.dart';
import 'package:robbinlaw/controllers/userController.dart';
import 'package:robbinlaw/models/user.dart';
import 'package:robbinlaw/services/database.dart';
import 'package:robbinlaw/services/authorization.dart';

class AuthController extends GetxController {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  //create a stream of data events of type User.
  //User is a type defined in firebase.
  
  final Rxn<auth.User> _firebaseUserStream = Rxn<auth.User>();
  //final Rx<User> _firebaseUserStream = Rx<User>();
  //final _firebaseUserStream = User().obs;

  auth.User? get firebaseUser => _firebaseUserStream.value;

  @override
  // called immediately after the widget is allocated memory
  onInit() {
    // super should be called first with onInit.
    super.onInit();
    //print('AuthController onInit:');
    //bind the stream from firebase to our _firebaseUserStream stream.
    _firebaseUserStream.bindStream(_firebaseAuth.authStateChanges());
  }

  @override
  // called after the widget is rendered on screen
  void onReady() {
    //print('AuthController onReady:');
    super.onReady();
  }

  @override
  // called just before the Controller is deleted from memory
  void onClose() {
    //print('AuthController onClose:');
    // super should be called last with onClose.
    super.onClose();
  }

  void createUser(String name, String email, String password) async {
    try {
      auth.UserCredential credential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: email.trim(), password: password);
      //create user in database.dart
      UserModel userModel = UserModel(
        id: credential.user!.uid,
        name: name,
        email: credential.user!.email,
      );
      if (await Database().createNewUser(userModel)) {
        Get.find<UserController>().user = userModel;
        Get.back();
      }
      Get.snackbar(
        "createUser",
        "successful",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    } catch (e) {
      Get.snackbar(
        "createUser ERROR",
        "something bad happened",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    }
  }

  void login(String email, String password) async {
    try {
      auth.UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email.trim(), password: password);
      Get.find<UserController>().user =
          await Database().getUser(credential.user!.uid);
      Get.snackbar(
        "login",
        "successful",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    } catch (e) {
      Get.snackbar(
        "login ERROR",
        "something bad happened",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    }
  }

  void logOut() async {
    try {
      await _firebaseAuth.signOut();
      Get.find<UserController>().clear();
      Get.snackbar(
        "logOut",
        "successful",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    } catch (e) {
      Get.snackbar(
        "logOut ERROR",
        "something bad happened",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
