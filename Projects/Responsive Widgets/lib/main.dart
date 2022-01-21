import 'package:flutter/material.dart';
import 'package:flutter_responsive_widgets/app/view/get_responsive_view.dart';
import 'package:flutter_responsive_widgets/app/view/wrap_view.dart';
import 'package:get/get.dart';
import 'package:flutter_responsive_widgets/app/view/layout_builder_view.dart';
import 'package:flutter_responsive_widgets/app/view/media_query_view.dart';
import 'app/view/responsive_layout_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Responsive Widgets"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            children: [
              buildButton("LayoutBuilder", const LayoutBuilderPage()),
              buildButton("MediaQuery", const MediaQueryPage()),
              buildButton("Responsive", const ResponsiveLayout()),
              buildButton("GetResponsiveView", GetResponsiveViewPage()),
              buildButton("Wrap", const WrapPage()),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildButton(String _text, var _page) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: () {
          Get.to(_page);
        },
        child: Text(_text),
      ),
    );
  }
}
