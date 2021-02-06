import 'package:get/get.dart';
import 'package:robbinlaw/controllers/authController.dart';
import 'package:robbinlaw/models/app.dart';
import 'package:robbinlaw/services/database.dart';

class AppController extends GetxController {
  RxList<AppModel> _appList = RxList<AppModel>();

  List<AppModel> get appList => _appList;

  set todos(List<AppModel> value) => this._appList = value;

  @override
  void onInit() {
    super.onInit();
    print('AppController onInit:');
  }

  void upDate() {
    print('AppController upDate: try');
    try {
      String uid = Get.find<AuthController>().firebaseUser.uid;
      print('AppController upDate: uid= $uid');
      _appList.bindStream(Database().streamTodo(uid));
    } catch (e) {
      print('AppController upDate: catch $e');
    }
  }
}
