import 'package:get/get.dart';
import 'package:robbinlaw/controllers/authController.dart';
import 'package:robbinlaw/controllers/userController.dart';
import 'package:robbinlaw/controllers/appController.dart';

//This GlobalBindings class that inherits (extends) from Bindings from the Getx library
//will instanciate all controllers (allocating permanent memory) and making
//them available anywhere in the app via Get.find until the app is terminated.
//This is commonly called global dependency injection.
//It allows us to separate out the dependency injection from the views/routes.
class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    //Get.lazyPut(() => AuthController());
    Get.put<AuthController>(AuthController(), permanent: true);
    //Get.lazyPut(() => UserController());
    Get.put<UserController>(UserController(), permanent: true);
    //Get.lazyPut(() => TodoController());
    Get.put<AppController>(AppController(), permanent: true);
  }
}
