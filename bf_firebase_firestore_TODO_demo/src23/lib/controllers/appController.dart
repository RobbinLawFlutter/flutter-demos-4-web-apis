// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:robbinlaw/controllers/authController.dart';
import 'package:robbinlaw/models/app.dart';
import 'package:robbinlaw/services/database.dart';

class AppController extends GetxController {
  //Create a Stream of data events of type List<AppModel>.
  //this is a private field.
  Rx<List<AppModel>> _appStreamOfList = Rx<List<AppModel>>([]);
  //when the getter is called take the list out of the stream and update this property.
  List<AppModel> get appList => _appStreamOfList.value;
  //when the setter is called inject into the stream the new list.
  //This setter is never used.
  set appList(List<AppModel> value) => _appStreamOfList.value = value;

  @override
  void onInit() {
    super.onInit();
    print('AppController onInit:');
  }

  //This upDate method is called every time the Home() class is
  //instantiated and its build is run, so as to bind the proper
  //stream as per the logged in user.
  void upDate() {
    print('AppController upDate: try');
    try {
      //The ? allows us to call on uid when the firebaseUser is null, null safety,
      //and therefore the try will not fail if the firebaseUser is null.
      String userId = Get.find<AuthController>().firebaseUser!.uid;
      print('AppController upDate: uid= $userId');
      //Bind to our controller appstream the FireStore stream.
      _appStreamOfList.bindStream(Database().streamOfAppData(userId));
    } catch (e) {
      print('AppController upDate: catch $e');
    }
  }
}
