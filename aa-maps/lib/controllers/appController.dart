import 'package:get/state_manager.dart';
import 'package:robbinlaw/models/numberModel.dart';
import 'package:robbinlaw/models/numberTypes.dart';

class AppController extends GetxController {
  Rx<List<NumberModel>> _appStream = Rx<List<NumberModel>>();

  List<NumberModel> get numberType => this._appStream.value;

  set numberType(List<NumberModel> value) => this._appStream.value = value;

  @override
  onInit() {
    super.onInit();
    _appStream.value = oneTypes;
    print(
        'AppController onInit: stream.value[0].title = ${_appStream.value[0].title}');

    /// Called every time the stream value is changed
    ever(_appStream, (_) => print("appstream value has been changed"));

    /// Called first time the stream value is changed
    once(_appStream, (_) => print("appstream value was changed once"));
  }

  @override
  void onReady() {
    print('AppController onReady:');
    super.onReady();
  }

  @override
  void onClose() {
    print('AppController onClose:');
    super.onClose();
  }

  void updateNumberListType(List<NumberModel> numberListType) {
    print('AppController updateNumberListType');
    _appStream.value = numberListType;
    print(
        'AppController updateNumbersListType: stream.value[0].title = ${_appStream.value[0].title}');
  }
}
