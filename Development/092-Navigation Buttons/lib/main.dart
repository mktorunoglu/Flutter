import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(testWidget);
}

Widget testWidget = new MediaQuery(
  data: new MediaQueryData(),
  child: new MaterialApp(home: new SharedXAxisTransitionDemo()),
);

class SharedXAxisTransitionDemo extends StatefulWidget {
  const SharedXAxisTransitionDemo({Key? key}) : super(key: key);
  @override
  _SharedXAxisTransitionDemoState createState() =>
      _SharedXAxisTransitionDemoState();
}

class _SharedXAxisTransitionDemoState extends State<SharedXAxisTransitionDemo> {
  bool _isLoggedIn = false;

  void _toggleLoginStatus() {
    setState(() {
      _isLoggedIn = !_isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Text("Navigation Buttons"),
            Text(
              "İleri ve geri butonları",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageTransitionSwitcher(
                duration: const Duration(milliseconds: 300),
                reverse: !_isLoggedIn,
                transitionBuilder: (
                  child,
                  animation,
                  secondaryAnimation,
                ) {
                  return SharedAxisTransition(
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    transitionType: SharedAxisTransitionType.horizontal,
                    child: child,
                  );
                },
                child: _isLoggedIn ? const _CoursePage() : const _SignInPage(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _isLoggedIn ? _toggleLoginStatus : null,
                    child: Text("GERİ"),
                  ),
                  ElevatedButton(
                    onPressed: _isLoggedIn ? null : _toggleLoginStatus,
                    child: Text("İLERİ"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CoursePage extends StatelessWidget {
  const _CoursePage();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 16),
        Text(
          "Kurslarınızı düzenleyin.",
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Aşağıdaki kurslardan istediklerinizi seçebilirsiniz.",
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        _CourseSwitch(course: "Sanat ve El Sanatları"),
        _CourseSwitch(course: "Resim"),
        _CourseSwitch(course: "Müzik"),
        _CourseSwitch(course: "Tasarım"),
        _CourseSwitch(course: "Mutfak"),
      ],
    );
  }
}

class _CourseSwitch extends StatefulWidget {
  const _CourseSwitch({
    required this.course,
  });
  final String course;

  @override
  _CourseSwitchState createState() => _CourseSwitchState();
}

class _CourseSwitchState extends State<_CourseSwitch> {
  bool _isCourseBundled = true;

  @override
  Widget build(BuildContext context) {
    final subtitle = _isCourseBundled ? "Şeçildi" : "Seçilebilir";
    return SwitchListTile(
      title: Text(widget.course),
      subtitle: Text(subtitle),
      value: _isCourseBundled,
      onChanged: (newValue) {
        setState(() {
          _isCourseBundled = newValue;
        });
      },
    );
  }
}

class _SignInPage extends StatelessWidget {
  const _SignInPage();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxHeight = constraints.maxHeight;
        final spacing = SizedBox(height: maxHeight / 25);
        return ListView(
          children: [
            SizedBox(height: maxHeight / 10),
            spacing,
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 10),
              child: Text(
                "Hoş Geldiniz.",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            spacing,
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 10),
              child: Text(
                "Lütfen hesabınızda oturum açınız.",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 40,
                    start: 15,
                    end: 15,
                    bottom: 10,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.visibility,
                        size: 20,
                        color: Colors.black54,
                      ),
                      isDense: true,
                      labelText: "E-posta adresi veya telefon numarası",
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Şifrenizi mi unuttunuz?",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Hesap Oluşturun",
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
