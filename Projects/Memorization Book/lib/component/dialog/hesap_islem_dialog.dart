import 'package:ezberdefteri2/component/snackbar.dart';
import 'package:ezberdefteri2/component/widget/button_content.dart';
import 'package:ezberdefteri2/screen/kategoriler_ekrani.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HesapIslemDialog extends StatefulWidget {
  const HesapIslemDialog({Key? key, required this.islem}) : super(key: key);

  final String islem;

  @override
  _HesapIslemDialogState createState() => _HesapIslemDialogState();

  static void hesapIslemDialog(BuildContext context, String islem) {
    showDialog(
      context: context,
      builder: (context) {
        return HesapIslemDialog(islem: islem);
      },
    );
  }
}

class _HesapIslemDialogState extends State<HesapIslemDialog> {
  String mesaj = "";
  String tamamlandiMesaj = "";
  GoogleSignIn googleSignIn = GoogleSignIn();
  late FirebaseAuth auth;
  bool isSigningIn = false;

  void islemSnackbar() {
    if (widget.islem == "Yedekle") {
      mesaj = "Veriler hesaba yedekleniyor...";
      tamamlandiMesaj = "Veriler hesaba yedeklendi.";
    } else {
      mesaj = "Veriler hesaptan geri yükleniyor...";
      tamamlandiMesaj = "Veriler hesaptan geri yüklendi.";
    }
    snackbarGizle(context);
    final snackBar = SnackBar(
      content: Row(
        children: [
          Flexible(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(mesaj),
                  Text("Lütfen bekleyiniz."),
                ],
              ),
            ),
          ),
          Transform.scale(
            scale: 0.5,
            child:
                CircularProgressIndicator(color: karanlikMod ? color3 : color1),
          ),
        ],
      ),
      duration: Duration(minutes: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> googleLogin() async {
    print("dnmdnmdnm: TEST");

    await googleSignIn.signIn().then(
      (user) async {
        if (user == null) {
          snackbarGoster(context, "dnmdnmdnm: HATA", 3000);
        } else {
          await user.authentication.then(
            (userAuth) {
              AuthCredential credential = GoogleAuthProvider.credential(
                accessToken: userAuth.accessToken,
                idToken: userAuth.idToken,
              );
              auth = FirebaseAuth.instance;
              auth.signInWithCredential(credential).then(
                (value) {
                  print("dnmdnmdnm: Giriş yapıldı." + value.toString());
                },
              ).catchError(
                (hata) {
                  print(
                      "dnmdnmdnm: Giriş yapılamadı: Google Giriş Hatası ($hata)");
                },
              );
            },
          ).catchError(
            (hata) {
              print(
                  "dnmdnmdnm: Giriş yapılamadı: Google Authentication Hatası ($hata)");
            },
          );
        }
      },
    ).catchError(
      (hata) {
        print("dnmdnmdnm: Giriş yapılamadı: Google SingIn Hatası ($hata)");
      },
    );

/*
    final user = await googleSignIn.signIn().catchError((hata) {
      print("dnmdnmdnm: Giriş yapılamadı: Google SingIn Hatası ($hata)");
    });
    if (user == null) {
      snackbarGoster(context, "deneme: HATA", 3000);
    } else {
      final googleAuth = await user.authentication.catchError((hata) {
        print(
            "dnmdnmdnm: Giriş yapılamadı: Google Authentication Hatası ($hata)");
      });

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        snackbarGoster(context, "deneme", 3000);
      }).catchError((hata) {
        print("dnmdnmdnm: Giriş yapılamadı: Google Giriş Hatası ($hata)");
      });

      FirebaseAuth auth = FirebaseAuth.instance;
      String authString = auth.currentUser!.email.toString();
      print("dnmdnmdnm:" + authString);
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: color2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.warning,
                  color: Color(0xFFEA4335),
                  size: 17,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "UYARI",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFEA4335),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                widget.islem == "Yedekle"
                    ? "Hesabınızdaki önceden yedeklenmiş veriler silinip yerine uygulamadaki veriler kaydedilecektir."
                    : "Uygulamadaki veriler silinip yerine hesabınızdaki veriler geri yüklenecektir.",
                style: TextStyle(
                  fontSize: 14,
                  color: color3,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                signInWithGoogle();
              },
              child: buttonContent(
                widget.islem == "Yedekle"
                    ? "Google hesabına yedekle"
                    : "Google hesabından geri yükle",
                Color(0xFFEA4335),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
