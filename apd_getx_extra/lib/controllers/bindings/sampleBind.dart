import 'package:get/get.dart';
import 'package:robbinlaw/controllers/sumController.dart';

class SampleBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SumController>(() => SumController());
  }
}
