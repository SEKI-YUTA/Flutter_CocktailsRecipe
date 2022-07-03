import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CocktailDetail extends StatelessWidget {
  Map<String, dynamic> cocktailData;
  CocktailDetail({Key? key, required this.cocktailData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Cocktail Detail"),
      ),
    );
  }
}