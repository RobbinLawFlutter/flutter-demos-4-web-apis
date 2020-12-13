import 'package:get/get.dart';
import 'package:robbinlaw/models/user.dart';

class UserController extends GetxController {
  final user = User().obs;

  updateUser(int count) {
    //Which is better??

    //Option #1
    user().name = "Robbin";
    user().count = count;

    //Option #2
    user.update((value) {
      value.name = 'Robbin';
      value.count = count;
    });
  }
}
