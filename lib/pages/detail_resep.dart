import 'package:flutter/material.dart';
import 'package:masak_apa_hari_ini/model/recipe.dart';
import 'package:masak_apa_hari_ini/model/recipe_detail.dart';
import 'package:http/http.dart' as http;

class DetailResep extends StatelessWidget {
  const DetailResep({ Key? key, required this.recipe }) : super(key: key);
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title, style: TextStyle(color: Colors.black87),),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
      ),
      body: FutureBuilder(
        future: getRecipeDetail(http.Client(), recipe.key),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Telah terjadi kesalahan saat mengambil data resep:' + snapshot.error.toString()));
          }

          return snapshot.hasData
            ? ContainerDetailResep(recipeDetail: snapshot.data)
            : Center(child: CircularProgressIndicator());
        }
      )
    );
  }
}

class ContainerDetailResep extends StatelessWidget {
  const ContainerDetailResep({ Key? key, required this.recipeDetail }) : super(key: key);
  final RecipeDetail recipeDetail;

  @override
  Widget build(BuildContext context) {
    Color difficultyColor;

    switch (recipeDetail.difficulty) {
      case 'Mudah':
        difficultyColor = Color(0xFF10B981);
        break;
      case 'Cukup rumit':
        difficultyColor = Color(0xFFF59E0B);
        break;
      case 'Level chef panji':
        difficultyColor = Color(0xFFEF4444);
        break;
      default:
        difficultyColor = Color(0xFF6B7280);
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.network(recipeDetail.thumb!),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  recipeDetail.title!,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18.0,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 14.0),
                Row(
                  children: <Widget>[
                    Text(recipeDetail.author!.user!, style: TextStyle(color: Colors.black54)),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('-'),
                    ),
                    Text(recipeDetail.author!.datePublished!, style: TextStyle(color: Colors.black54)),
                  ],
                ),
                SizedBox(height: 14.0),
                Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 4.0),
                          child: Icon(
                            Icons.schedule,
                            color: Color(0xFF6B7280),
                            size: 14.0,
                          ),
                        ),
                        Text(
                          recipeDetail.times!,
                          style:
                              TextStyle(color: Color(0xFF6B7280)),
                        )
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 4.0),
                          child: Icon(
                            Icons.restaurant_menu,
                            color: Color(0xFF6B7280),
                            size: 14.0,
                          ),
                        ),
                        Text(
                          recipeDetail.servings!,
                          style:
                              TextStyle(color: Color(0xFF6B7280)),
                        )
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 4.0),
                          child: Icon(
                            Icons.trending_up,
                            color: Color(0xFF6B7280),
                            size: 14.0,
                          ),
                        ),
                        Text(
                          recipeDetail.difficulty!,
                          style:
                              TextStyle(color: difficultyColor),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 14.0),
                Text(
                  recipeDetail.desc!,
                  style: TextStyle(
                    color: Colors.black87,
                    height: 1.5
                  ),
                ),
                SizedBox(height: 32.0),
                Text(
                  'Bahan yang dibutuhkan:',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20.0
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: recipeDetail.ingredients!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 8.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('\u2022'),
                            Container(
                              margin: EdgeInsets.only(left: 4.0),
                              child: Text(
                                recipeDetail.ingredients![index],
                                style: TextStyle(color: Colors.black87)
                              ),
                            )
                          ],
                        )
                      ]
                    );
                  }
                ),
                SizedBox(height: 32.0),
                Text(
                  'Langkah-langkah memasak:',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20.0
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: recipeDetail.steps!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 8.0),
                        Text(
                          recipeDetail.steps![index],
                          style: TextStyle(
                            color: Colors.black87,
                            height: 1.5
                          ),
                        ),
                      ]
                    );
                  }
                )
              ]
            ),
          ),
        ],
      ),
    );
  }
}