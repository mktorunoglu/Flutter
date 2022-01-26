import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'component/control_buttons.dart';
import 'constants.dart';
import 'video_call_class.dart';
import 'video_call_controller.dart';

class VideoCallScreen extends StatelessWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VideoCallController videoCallController = Get.put(VideoCallController());

    VideoCallClass.autoHideButtons();
    VideoCallClass.initAgora();

    const Duration(seconds: 10).delay().whenComplete(() {
      videoCallController.connecting.value = false;
    });

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ControlButtons(),
      body: Obx(() {
        if (videoCallController.remoteUid.value == 0) {
          return InkWell(
            onTap: () {
              videoCallController.hideButtons.value =
                  !videoCallController.hideButtons.value;
              VideoCallClass.autoHideButtons();
            },
            child: localVideo(videoCallController),
          );
        } else {
          if (videoCallController.switchLayout.value) {
            return Column(
              children: [
                Expanded(child: layoutSecondary(videoCallController)),
                Expanded(child: layoutPrimary(videoCallController)),
              ],
            );
          } else {
            return Stack(
              children: [
                layoutPrimary(videoCallController),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: SizedBox(
                        width: Get.width * 0.4,
                        height: Get.width * 0.5,
                        child: layoutSecondary(videoCallController),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        }
      }),
    );
  }

  Widget layoutPrimary(VideoCallController videoCallController) {
    return InkWell(
      onTap: () {
        videoCallController.hideButtons.value =
            !videoCallController.hideButtons.value;
        VideoCallClass.autoHideButtons();
      },
      child: Container(
        color: Colors.black,
        child: videoCallController.switchVideo.value
            ? localVideo(videoCallController)
            : remoteVideo(videoCallController),
      ),
    );
  }

  Widget layoutSecondary(VideoCallController videoCallController) {
    return InkWell(
      onTap: () {
        videoCallController.switchVideo.value =
            !videoCallController.switchVideo.value;
      },
      child: Container(
        color: Colors.white,
        child: videoCallController.switchVideo.value
            ? remoteVideo(videoCallController)
            : localVideo(videoCallController),
      ),
    );
  }

  Widget localVideo(VideoCallController videoCallController) {
    if (videoCallController.joined.value) {
      return rtc_local_view.SurfaceView();
    } else {
      return Center(
        child: Text(
          videoCallController.connecting.value
              ? "Kanala bağlanılıyor..."
              : 'Kanala bağlanılamadı.',
          style: TextStyle(
              color: videoCallController.switchVideo.value
                  ? Colors.white
                  : Colors.black),
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  Widget remoteVideo(VideoCallController videoCallController) {
    return rtc_remote_view.SurfaceView(
      uid: videoCallController.remoteUid.value,
      channelId: Constants.channelName,
    );
  }
}
