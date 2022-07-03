import 'dart:convert';

import 'package:cocktails_recipe/cocktail_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class CocktailsList extends StatefulWidget {
  const CocktailsList({Key? key}) : super(key: key);

  @override
  State<CocktailsList> createState() => _CocktailsListState();
}

class _CocktailsListState extends State<CocktailsList> {
  // List<Map<String, dynamic>> apiResponse = [];
  var apiResponse = [];

  

  @override
  void initState() {
    super.initState();
    getCocktailsData();
  }

  void getCocktailsData() async {
    http.get(Uri.parse("https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita"))
    .then((res) {
      var rawResponse = utf8.decode(res.bodyBytes);
      var jsonResponse = json.decode(rawResponse);
      print(jsonResponse["drinks"]);
      print("length: ${jsonResponse["drinks"].length}");
      // print(jsonResponse.toString());
      setState(() {
        apiResponse = jsonResponse["drinks"];
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: apiResponse.length,
          itemBuilder: (context, index) {
            return CocktailCard(apiResponse: apiResponse, index: index,);
          },
        ),
      ),
      // body: Center(
      //   child: ElevatedButton(child: Text("Sample"), onPressed: () {
      //     print(apiResponse.toString());
      //   },),
      // ),
    );
  }
}

class CocktailCard extends StatelessWidget {
  TextStyle titleStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  TextStyle glassStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  var apiResponse;
  int index;
  CocktailCard({Key? key, required this.apiResponse,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return CocktailDetail(cocktailData: apiResponse[index],);
        }));
      },
      child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Column(
                          children: [
                            Text(apiResponse[index]["strDrink"].toString(), style: titleStyle, textAlign: TextAlign.start,),
                            const SizedBox(height: 10,),
                            Text(apiResponse[index]["strGlass"].toString(), style: glassStyle, textAlign: TextAlign.start,)
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.network(apiResponse[index]["strDrinkThumb"].toString())
                          ),
                      )
                    ],
                  ),
                ),
              ),
    );
  }
}