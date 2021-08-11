import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(testWidget);
}

Widget testWidget = new MediaQuery(
  data: new MediaQueryData(),
  child: new MaterialApp(home: new SharedZAxisTransitionDemo()),
);

class SharedZAxisTransitionDemo extends StatelessWidget {
  const SharedZAxisTransitionDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return _createHomeRoute();
      },
    );
  }

  Route _createHomeRoute() {
    return PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Column(
              children: [
                Text("Settings Page"),
                Text(
                  "Ayarlar sayfası",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).push<void>(_createSettingsRoute());
                },
              ),
            ],
          ),
          body: const _RecipePage(),
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          fillColor: Colors.transparent,
          transitionType: SharedAxisTransitionType.scaled,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
    );
  }

  Route _createSettingsRoute() {
    return PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const _SettingsPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          fillColor: Colors.transparent,
          transitionType: SharedAxisTransitionType.scaled,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
    );
  }
}

class _SettingsPage extends StatelessWidget {
  const _SettingsPage();

  @override
  Widget build(BuildContext context) {
    final settingsList = <_SettingsInfo>[
      _SettingsInfo(
        Icons.person,
        "Profil",
      ),
      _SettingsInfo(
        Icons.notifications,
        "Bildirimler",
      ),
      _SettingsInfo(
        Icons.security,
        "Gizlilik",
      ),
      _SettingsInfo(
        Icons.help,
        "Yardım",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Ayarlar"),
      ),
      body: ListView(
        children: [
          for (var setting in settingsList) _SettingsTile(setting),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile(this.settingData);
  final _SettingsInfo settingData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(settingData.settingIcon),
          title: Text(settingData.settingsLabel),
        ),
        const Divider(thickness: 2),
      ],
    );
  }
}

class _SettingsInfo {
  const _SettingsInfo(this.settingIcon, this.settingsLabel);
  final IconData settingIcon;
  final String settingsLabel;
}

class _RecipePage extends StatelessWidget {
  const _RecipePage();

  @override
  Widget build(BuildContext context) {
    final savedRecipes = <_RecipeInfo>[
      _RecipeInfo("Burger", "Burger tarifi", "IMAGE"),
      _RecipeInfo("Sandviç", "Sandviç tarifi", "IMAGE"),
      _RecipeInfo("Tatlı", "Tatlı tarifi", "IMAGE"),
      _RecipeInfo("Karides", "Karides tarifi", "IMAGE"),
      _RecipeInfo("Yengeç", "Yengeç tarifi", "IMAGE"),
      _RecipeInfo("Etli Sandviç", "Etli Sandviç tarifi", "IMAGE"),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 8.0),
          child: Text("Kaydedilen Tarifler"),
        ),
        const SizedBox(height: 4),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              for (var recipe in savedRecipes)
                _RecipeTile(recipe, savedRecipes.indexOf(recipe))
            ],
          ),
        ),
      ],
    );
  }
}

class _RecipeInfo {
  const _RecipeInfo(this.recipeName, this.recipeDescription, this.recipeImage);
  final String recipeName;
  final String recipeDescription;
  final String recipeImage;
}

class _RecipeTile extends StatelessWidget {
  const _RecipeTile(this._recipe, this._index);
  final _RecipeInfo _recipe;
  final int _index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 70,
          width: 100,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            child: FlutterLogo(size: 128),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            children: [
              ListTile(
                title: Text(_recipe.recipeName),
                subtitle: Text(_recipe.recipeDescription),
                trailing: Text('0${_index + 1}'),
              ),
              const Divider(thickness: 2),
            ],
          ),
        ),
      ],
    );
  }
}
