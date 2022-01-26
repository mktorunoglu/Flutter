import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:get/get.dart';

class VideoCallController extends GetxController {
  RxBool joined = false.obs;
  RxBool switchVideo = false.obs;
  RxBool muteCam = false.obs;
  RxBool muteMic = false.obs;
  RxBool switchSoundOutput = false.obs;
  RxBool switchCamera = false.obs;
  RxBool switchLayout = false.obs;
  RxBool hideButtons = false.obs;
  RxBool connecting = true.obs;

  RxInt remoteUid = 0.obs;
  RxInt counter = 0.obs;

  Rx<RtcEngine?> engine = RtcEngine.instance.obs;
}
