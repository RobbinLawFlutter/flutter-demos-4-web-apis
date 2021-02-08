import 'package:get/get.dart';
import 'package:robbinlaw/models/user.dart';

class UserController extends GetxController {
  //create a stream of data events of type UserModel.
  Rx<UserModel> _userModelStream = Rx<UserModel>();

  UserModel get user => _userModelStream.value;

  set user(UserModel value) => this._userModelStream.value = value;

  @override
  onInit() {
    super.onInit();
    print('UserController onInit:');
  }

  void clear() {
    _userModelStream.value = UserModel();
    print('UserController clear:');
  }
}
