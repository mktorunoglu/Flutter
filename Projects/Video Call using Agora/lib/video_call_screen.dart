import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';
import 'floating_button.dart';
import 'video_call_class.dart';
import 'video_call_controller.dart';

class VideoCallScreen extends StatelessWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VideoCallController videoCallController = Get.put(VideoCallController());

    VideoCallClass.autoHideButtons();
    VideoCallClass.initAgora();

    const Duration(seconds: 3).delay().whenComplete(() {
      videoCallController.connecting.value = false;
    });

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingButton(
              onPressed: () {
                videoCallController.muteCam.value =
                    !videoCallController.muteCam.value;
                VideoCallClass.autoHideButtons();

                videoCallController.engine.value!
                    .enableLocalVideo(!videoCallController.muteCam.value);
              },
              iconData: videoCallController.muteCam.value
                  ? Icons.videocam_off
                  : Icons.videocam,
              iconColor: videoCallController.muteCam.value
                  ? Colors.white
                  : Colors.grey.shade900,
              backgroundColor: videoCallController.muteCam.value
                  ? Colors.grey.shade900
                  : Colors.white,
              tooltip: videoCallController.muteCam.value
                  ? "Kamerayı aç"
                  : "Kamerayı kapat",
              slideMilliseconds: 200,
              slideState: videoCallController.hideButtons.value,
            ),
            FloatingButton(
              onPressed: () {
                videoCallController.muteMic.value =
                    !videoCallController.muteMic.value;
                VideoCallClass.autoHideButtons();

                videoCallController.engine.value!
                    .enableLocalAudio(!videoCallController.muteMic.value);
              },
              iconData:
                  videoCallController.muteMic.value ? Icons.mic_off : Icons.mic,
              iconColor: videoCallController.muteMic.value
                  ? Colors.white
                  : Colors.grey.shade900,
              backgroundColor: videoCallController.muteMic.value
                  ? Colors.grey.shade900
                  : Colors.white,
              tooltip: videoCallController.muteMic.value
                  ? "Mikrofonu aç"
                  : "Mikrofonu sessize al",
              slideMilliseconds: 150,
              slideState: videoCallController.hideButtons.value,
            ),
            FloatingButton(
              backgroundColor: Colors.red,
              onPressed: () {
                VideoCallClass.autoHideButtons();
                videoCallController.engine.value!.leaveChannel();
                Get.back();
              },
              iconData: Icons.call_end,
              iconColor: Colors.white,
              mini: false,
              tooltip: "Görüşmeden çık",
              slideMilliseconds: 100,
              slideState: videoCallController.hideButtons.value,
            ),
            FloatingButton(
              onPressed: () {
                videoCallController.switchCamera.value =
                    !videoCallController.switchCamera.value;
                VideoCallClass.autoHideButtons();

                videoCallController.engine.value!.switchCamera();
              },
              iconData: videoCallController.switchCamera.value
                  ? Icons.camera_rear
                  : Icons.camera_front,
              tooltip: "Kamerayı değiştir",
              slideMilliseconds: 150,
              slideState: videoCallController.hideButtons.value,
            ),
            FloatingButton(
              onPressed: () {
                videoCallController.switchLayout.value =
                    !videoCallController.switchLayout.value;
                VideoCallClass.autoHideButtons();
              },
              iconData: videoCallController.switchLayout.value
                  ? Icons.dashboard
                  : Icons.branding_watermark,
              tooltip: "Düzeni değiştir",
              slideMilliseconds: 200,
              slideState: videoCallController.hideButtons.value,
            ),
          ],
        ),
      ),
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
