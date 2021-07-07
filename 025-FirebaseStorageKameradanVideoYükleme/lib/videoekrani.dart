import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VideoEkrani extends StatelessWidget {
  const VideoEkrani({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ButonEkrani(),
    );
  }
}

class ButonEkrani extends StatefulWidget {
  const ButonEkrani({Key? key}) : super(key: key);

  @override
  _ButonEkraniState createState() => _ButonEkraniState();
}

class _ButonEkraniState extends State<ButonEkrani> {
  late File yuklenecekDosya;
  String indirmeBaglantisi = "";

  videoYukle() async {
    var alinanDosya = await ImagePicker().getVideo(source: ImageSource.camera);
    setState(() {
      yuklenecekDosya = File(alinanDosya!.path);
    });

    Reference referansYolu = FirebaseStorage.instance
        .ref()
        .child("Videolar")
        .child(FirebaseAuth.instance.currentUser!.email.toString())
        .child("video.mp4");

    UploadTask yuklemeGorevi = referansYolu.putFile(yuklenecekDosya);
    TaskSnapshot taskSnapshot = await yuklemeGorevi;
    String url = await taskSnapshot.ref.getDownloadURL();

    setState(() {
      indirmeBaglantisi = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(50),
      child: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: videoYukle, child: Text("Video Yükle"))
          ],
        ),
      ),
    );
  }
}
