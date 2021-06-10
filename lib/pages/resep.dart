import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:masak_apa_hari_ini/model/recipe.dart';

class Resep extends StatefulWidget {
  const Resep({Key? key}) : super(key: key);

  @override
  _ResepState createState() => _ResepState();
}

class _ResepState extends State<Resep> {
  bool _isErrorButtonReloading = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchRecipes(http.Client()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        _isErrorButtonReloading = false;

        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        // Has error
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasError) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Terjadi kesalahan pada saat mengambil data resep.'),
                SizedBox(height: 8.0),
                MaterialButton(
                  child: _isErrorButtonReloading
                      ? Text('Memuat ulang...')
                      : Text('Muat ulang'),
                  color: Colors.blue,
                  disabledColor: Colors.grey,
                  textColor: Colors.white,
                  onPressed: _isErrorButtonReloading
                      ? null
                      : () {
                          _isErrorButtonReloading = true;
                          setState(() {});
                        },
                )
              ],
            ),
          );
        }

        // Done
        return snapshot.hasData
            ? RefreshIndicator(
                onRefresh: () async {
                  setState(() {});
                },
                child: RecipeList(recipeList: snapshot.data))
            : Center(child: Text('Tidak ada data yang dapat ditampilkan'));
      },
    );
  }
}

class RecipeList extends StatelessWidget {
  const RecipeList({Key? key, required this.recipeList}) : super(key: key);

  final List<Recipe> recipeList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      physics: BouncingScrollPhysics(),
      shrinkWrap: false,
      itemCount: recipeList.length,
      itemBuilder: (BuildContext context, int index) {
        Color difficultyColor;

        switch (recipeList[index].difficulty) {
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

        return Card(
          key: Key(recipeList[index].key),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  bottomLeft: Radius.circular(4.0),
                ),
                child: Image.network(
                  recipeList[index].thumb,
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
                        recipeList[index].title,
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
                            recipeList[index].times,
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
                            recipeList[index].portion,
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
                            recipeList[index].difficulty,
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
        );
      },
    );
  }
}
