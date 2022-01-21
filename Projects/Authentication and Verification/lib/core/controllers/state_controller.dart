import 'package:get/get.dart';

import '../enums/login_type.dart';
import '../enums/screen_body.dart';
import '../enums/verification_type.dart';

class StateController extends GetxController {
  Rx<ScreenBody> screenBody = ScreenBody.login.obs;

  Rx<LoginType> loginType = LoginType.none.obs;
  Rx<VerificationType> verificationType = VerificationType.none.obs;
}
