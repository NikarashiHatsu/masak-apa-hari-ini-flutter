import 'package:flutter/material.dart';
import 'package:masak_apa_hari_ini/model/category.dart';
import 'package:http/http.dart' as http;
import 'package:masak_apa_hari_ini/model/recipe.dart';
import 'package:masak_apa_hari_ini/pages/detail_resep.dart';

class ListResepDiKategori extends StatelessWidget {
  const ListResepDiKategori({ Key? key, required this.category }) : super(key: key);
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resep di kategori ${category.category}', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
      ),
      body: FutureBuilder(
        future: getRecipesFromCategory(http.Client(), category.key),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Telah terjadi kesalahan saat mengambil data resep:' + snapshot.error.toString()));
          }

          return snapshot.hasData
            ? ContainerListResepDiKategori(recipes: snapshot.data)
            : Center(child: CircularProgressIndicator());
        }
      ),
    );
  }
}

class ContainerListResepDiKategori extends StatelessWidget {
  const ContainerListResepDiKategori({ Key? key, required this.recipes }) : super(key: key);
  final List<Recipe> recipes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      physics: BouncingScrollPhysics(),
      shrinkWrap: false,
      itemCount: recipes.length,
      itemBuilder: (BuildContext context, int index) {
        Color difficultyColor;

        switch (recipes[index].difficulty) {
          case 'Mudah':
            difficultyColor = Color(0xFF10B981);
            break;
          case 'Cukup Rumit':
            difficultyColor = Color(0xFFF59E0B);
            break;
          case 'Level Chef Panji':
            difficultyColor = Color(0xFFEF4444);
            break;
          default:
            difficultyColor = Color(0xFF6B7280);
        }

        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DetailResep(recipe: recipes[index])));
          },
          child: Card(
            key: Key(recipes[index].key),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    bottomLeft: Radius.circular(4.0),
                  ),
                  child: Image.network(
                    recipes[index].thumb,
                    width: 125.0,
                    height: 150.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipes[index].title,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF374151),
                          ),
                        ),
                        SizedBox(height: 8.0),
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
                              recipes[index].times,
                              style: TextStyle(color: Color(0xFF6B7280)),
                            )
                          ],
                        ),
                        SizedBox(height: 4.0),
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
                              recipes[index].portion,
                              style: TextStyle(color: Color(0xFF6B7280)),
                            )
                          ],
                        ),
                        SizedBox(height: 4.0),
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
                              recipes[index].difficulty,
                              style: TextStyle(color: difficultyColor),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}