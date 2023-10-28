import 'package:get/get.dart';
import 'package:robbinlaw/models/user.dart';

class UserController extends GetxController {
  //create a stream of data events of type UserModel.
  final Rx<UserModel> _userModelStream = Rx<UserModel>(UserModel(id: "",name: "",email: ""));

  UserModel get user => _userModelStream.value;

  set user(UserModel value) => _userModelStream.value = value;

  @override
  onInit() {
    super.onInit();
    //print('UserController onInit:');
  }

  void clear() {
    _userModelStream.value = UserModel(id: "",name: "",email: "");
    //print('UserController clear:');
  }
}
