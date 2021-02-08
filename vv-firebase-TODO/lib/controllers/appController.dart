import 'package:get/get.dart';
import 'package:robbinlaw/controllers/authController.dart';
import 'package:robbinlaw/models/app.dart';
import 'package:robbinlaw/services/database.dart';

class AppController extends GetxController {
  //Create a Stream of data events of type List<AppModel>.
  Rx<List<AppModel>> _appStreamOfList = Rx<List<AppModel>>();

  List<AppModel> get appList => _appStreamOfList.value;

  set todos(List<AppModel> value) => this._appStreamOfList.value = value;

  @override
  void onInit() {
    super.onInit();
    print('AppController onInit:');
  }

  void upDate() {
    print('AppController upDate: try');
    try {
      //The ? allows us to call on uid when the firebaseUser is null, null safety,
      //and therefore the try will not fail if the firebaseUser is null.
      String uid = Get.find<AuthController>().firebaseUser?.uid;
      print('AppController upDate: uid= $uid');
      //Bind to our controller appstream the FireStore stream.
      _appStreamOfList.bindStream(Database().streamTodos(uid));
    } catch (e) {
      print('AppController upDate: catch $e');
    }
  }
}
