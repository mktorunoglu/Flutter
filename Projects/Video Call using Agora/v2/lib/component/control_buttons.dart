import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../video_call_class.dart';
import '../video_call_controller.dart';
import 'control_button_item.dart';

class ControlButtons extends StatelessWidget {
  const ControlButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VideoCallController videoCallController = Get.find();

    return Obx(
      () => AnimatedSlide(
        duration: Duration(milliseconds: 100),
        offset: videoCallController.hideButtons.value
            ? const Offset(0, 2)
            : Offset.zero,
        child: Container(
          color: Colors.black,
          child: Row(
            children: [
              muteCamButton(videoCallController),
              muteMicButton(videoCallController),
              switchSoundOutputButton(videoCallController),
              switchCameraButton(videoCallController),
              switchLayoutButton(videoCallController),
              leaveChannelButton(videoCallController),
            ],
          ),
        ),
      ),
    );
  }

  ControlButtonItem leaveChannelButton(
      VideoCallController videoCallController) {
    return ControlButtonItem(
      onPressed: () {
        VideoCallClass.autoHideButtons();
        videoCallController.engine.value!.leaveChannel();
        Get.back();
      },
      iconData: Icons.call_end,
      text: "Görüşmeden çık",
      backgroundColor: Colors.red.withOpacity(0.5),
      animationDurationMs: 400,
    );
  }

  ControlButtonItem switchLayoutButton(
      VideoCallController videoCallController) {
    return ControlButtonItem(
      onPressed: () {
        videoCallController.switchLayout.value =
            !videoCallController.switchLayout.value;
        VideoCallClass.autoHideButtons();
      },
      iconData: videoCallController.switchLayout.value
          ? Icons.dashboard
          : Icons.branding_watermark,
      text: "Düzeni değiştir",
      backgroundColor: Colors.black,
      animationDurationMs: 350,
    );
  }

  ControlButtonItem switchCameraButton(
      VideoCallController videoCallController) {
    return ControlButtonItem(
      onPressed: () {
        videoCallController.switchCamera.value =
            !videoCallController.switchCamera.value;
        VideoCallClass.autoHideButtons();

        videoCallController.engine.value!.switchCamera();
      },
      iconData: videoCallController.switchCamera.value
          ? Icons.camera_rear
          : Icons.camera_front,
      text: "Kamerayı değiştir",
      backgroundColor: Colors.black,
      animationDurationMs: 300,
    );
  }

  ControlButtonItem switchSoundOutputButton(
      VideoCallController videoCallController) {
    return ControlButtonItem(
      onPressed: () {
        videoCallController.switchSoundOutput.value =
            !videoCallController.switchSoundOutput.value;
        VideoCallClass.autoHideButtons();

        videoCallController.engine.value!
            .setEnableSpeakerphone(videoCallController.switchSoundOutput.value);
      },
      iconData: Icons.volume_up,
      text: videoCallController.switchSoundOutput.value
          ? "Hoparlör açık"
          : "Hoparlörü aç",
      backgroundColor: videoCallController.switchSoundOutput.value
          ? Colors.white.withOpacity(0.2)
          : Colors.black,
      animationDurationMs: 250,
    );
  }

  ControlButtonItem muteMicButton(VideoCallController videoCallController) {
    return ControlButtonItem(
      onPressed: () {
        videoCallController.muteMic.value = !videoCallController.muteMic.value;
        VideoCallClass.autoHideButtons();

        videoCallController.engine.value!
            .enableLocalAudio(!videoCallController.muteMic.value);
      },
      iconData: Icons.mic_off,
      text: videoCallController.muteMic.value
          ? "Mikrofon kapalı"
          : "Mikrofonu kapat",
      backgroundColor: videoCallController.muteMic.value
          ? Colors.white.withOpacity(0.2)
          : Colors.black,
      animationDurationMs: 200,
    );
  }

  ControlButtonItem muteCamButton(VideoCallController videoCallController) {
    return ControlButtonItem(
      onPressed: () {
        videoCallController.muteCam.value = !videoCallController.muteCam.value;
        VideoCallClass.autoHideButtons();

        videoCallController.engine.value!
            .enableLocalVideo(!videoCallController.muteCam.value);
      },
      iconData: Icons.videocam_off,
      text: videoCallController.muteCam.value
          ? "Kamera kapalı"
          : "Kamerayı kapat",
      backgroundColor: videoCallController.muteCam.value
          ? Colors.white.withOpacity(0.2)
          : Colors.black,
      animationDurationMs: 150,
    );
  }
}
