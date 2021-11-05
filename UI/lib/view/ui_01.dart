import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_ui/variables.dart';

class UI01 extends StatefulWidget {
  const UI01({Key? key}) : super(key: key);

  @override
  _UI01State createState() => _UI01State();
}

class _UI01State extends State<UI01> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: headerColor,
            child: Column(
              children: [
                buildAppBar(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      buildHeader(),
                      buildSearchBar(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildCategoryCards(),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "Popular restaurants",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row buildCategoryCards() {
    return Row(
      children: [
        Expanded(
          child: buildCategoryItemCard(
              themeRed, restaurantsIconLink, "Restaurants", Colors.white),
        ),
        Expanded(
          child: buildCategoryItemCard(
              Colors.white, foodIconLink, "Food", Colors.black),
        ),
        Expanded(
          child: buildCategoryItemCard(
              Colors.white, drinksIconLink, "Drinks", Colors.black),
        ),
      ],
    );
  }

  Card buildCategoryItemCard(Color backgroundColor, String imageLink,
      String categoryName, Color categoryNameColor) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: SizedBox(
                height: 35,
                child: Image.network(imageLink),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              categoryName,
              style: TextStyle(
                color: categoryNameColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: 40,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Icon(
                Icons.search,
                color: searchBarColor,
                size: 20,
              ),
              Flexible(
                child: Transform.scale(
                  scale: 0.9,
                  child: TextField(
                    cursorColor: searchBarColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search for restaurants, food etc",
                      hintStyle: TextStyle(color: searchBarColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Deliver to",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: const [
            Icon(Icons.room_outlined, size: 16),
            SizedBox(width: 3),
            Text(
              "Kazi Ilias, Zindabazar, Sylhet",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  Padding buildAppBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.short_text),
            onPressed: () {},
          ),
          const Expanded(
            child: SizedBox(),
          ),
          buildItemCounter(),
        ],
      ),
    );
  }

  Stack buildItemCounter() {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_bag_outlined),
          onPressed: () {},
        ),
        Positioned(
          top: 13,
          right: 10,
          child: CircleAvatar(
            radius: 7,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 6,
              backgroundColor: themeRed,
              child: const FittedBox(
                child: Text(
                  "3",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
