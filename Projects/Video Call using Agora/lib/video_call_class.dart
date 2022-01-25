import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'constants.dart';
import 'video_call_controller.dart';

class VideoCallClass {
  static void autoHideButtons() {
    VideoCallController videoCallController = Get.find();

    if (!videoCallController.hideButtons.value) {
      int counter = ++videoCallController.counter.value;
      const Duration(seconds: 3).delay().whenComplete(() {
        if (counter == videoCallController.counter.value) {
          videoCallController.hideButtons.value = true;
        }
      });
    }
  }

  static void initAgora() async {
    await [Permission.camera, Permission.microphone].request();

    VideoCallController videoCallController = Get.find();

    RtcEngineContext context = RtcEngineContext(Constants.appId);
    videoCallController.engine.value =
        await RtcEngine.createWithContext(context);

    videoCallController.engine.value!.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print('joinChannelSuccess $channel $uid');
          videoCallController.joined.value = true;
        },
        userJoined: (int uid, int elapsed) {
          print('userJoined $uid');
          videoCallController.remoteUid.value = uid;
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print('userOffline $uid');
          videoCallController.remoteUid.value = 0;
        },
      ),
    );

    await videoCallController.engine.value!
        .joinChannel(Constants.token, Constants.channelName, null, 0);
    await videoCallController.engine.value!.enableVideo();
  }
}
