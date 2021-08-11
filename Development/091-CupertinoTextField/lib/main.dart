import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(testWidget);
}

Widget testWidget = new MediaQuery(
    data: new MediaQueryData(),
    child: new MaterialApp(home: new CupertinoTextFieldDemo()));

class CupertinoTextFieldDemo extends StatelessWidget {
  const CupertinoTextFieldDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          automaticallyImplyLeading: false,
          middle: Text("CupertinoTextField"),
        ),
        child: SafeArea(
          child: ListView(
            restorationId: 'text_field_demo_list_view',
            padding: const EdgeInsets.all(16),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CupertinoTextField(
                  textInputAction: TextInputAction.next,
                  restorationId: 'email_address_text_field',
                  placeholder: "E-mail",
                  keyboardType: TextInputType.emailAddress,
                  clearButtonMode: OverlayVisibilityMode.editing,
                  autocorrect: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CupertinoTextField(
                  textInputAction: TextInputAction.next,
                  restorationId: 'login_password_text_field',
                  placeholder: "Password",
                  clearButtonMode: OverlayVisibilityMode.editing,
                  obscureText: true,
                  autocorrect: false,
                ),
              ),
              CupertinoTextField(
                textInputAction: TextInputAction.done,
                restorationId: 'pin_number_text_field',
                prefix: const Icon(
                  CupertinoIcons.padlock_solid,
                  size: 28,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                clearButtonMode: OverlayVisibilityMode.editing,
                keyboardType: TextInputType.number,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0,
                      color: CupertinoColors.inactiveGray,
                    ),
                  ),
                ),
                placeholder: "PIN",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
