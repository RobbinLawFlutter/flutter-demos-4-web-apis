import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:robbinlaw/controllers/userController.dart';
import 'package:robbinlaw/models/user.dart';
import 'package:robbinlaw/services/database.dart';

class AuthController extends GetxController {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //create a stream of data events of type User.
  //User is a type defined in firebase.
  Rx<User> _firebaseUserStream = Rx<User>();

  User get firebaseUser => _firebaseUserStream.value;

  @override
  // called immediately after the widget is allocated memory
  onInit() {
    // super should be called first with onInit.
    super.onInit();
    print('AuthController onInit:');
    //bind the stream from firebase to our _user stream.
    _firebaseUserStream.bindStream(_firebaseAuth.authStateChanges());
  }

  @override
  // called after the widget is rendered on screen
  void onReady() {
    print('AuthController onReady:');
    super.onReady();
  }

  @override
  // called just before the Controller is deleted from memory
  void onClose() {
    print('AuthController onClose:');
    // super should be called last with onClose.
    super.onClose();
  }

  void createUser(String name, String email, String password) async {
    try {
      UserCredential _firebaseAuthReturnUserCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: email.trim(), password: password);
      //create user in database.dart
      UserModel _userModel = UserModel(
        id: _firebaseAuthReturnUserCredential.user.uid,
        name: name,
        email: _firebaseAuthReturnUserCredential.user.email,
      );
      if (await Database().createNewUser(_userModel)) {
        Get.find<UserController>().user = _userModel;
        Get.back();
      }
      Get.snackbar(
        "createUser",
        "successful",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
      );
    } catch (e) {
      Get.snackbar(
        "createUser ERROR",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
      );
    }
  }

  void login(String email, String password) async {
    try {
      UserCredential _firebaseAuthReturnUserCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email.trim(), password: password);
      Get.find<UserController>().user =
          await Database().getUser(_firebaseAuthReturnUserCredential.user.uid);
      Get.snackbar(
        "login",
        "successful",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
      );
    } catch (e) {
      Get.snackbar(
        "login ERROR",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
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
        duration: Duration(seconds: 5),
      );
    } catch (e) {
      Get.snackbar(
        "logOut ERROR",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
