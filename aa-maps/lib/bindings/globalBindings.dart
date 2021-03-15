import 'package:get/get.dart';
import 'package:robbinlaw/controllers/appController.dart';

//This GlobalBindings class that implements Bindings from the Getx library
//will instanciate all controllers (allocating permanent memory) and making
//them available anywhere in the app via Get.find until the app is terminated.
class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<AppController>(AppController(), permanent: true);
  }
}
