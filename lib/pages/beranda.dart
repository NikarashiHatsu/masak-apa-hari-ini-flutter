import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:masak_apa_hari_ini/model/category.dart';
import 'package:masak_apa_hari_ini/model/recipe.dart';
import 'package:shimmer/shimmer.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Text(
              'Resep Terbaru',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
          ),
          ListResepTerbaru(),
        ])),
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Text(
              'Kategori Resep',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
          ),
          ListKategoriResep(),
        ])),
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Text(
              '10 Resep Acak',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
          ),
          ListResepAcak()
        ]))
      ],
    );
  }
}

class ListResepTerbaru extends StatelessWidget {
  const ListResepTerbaru({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPreferredRecipeCount(http.Client(), 5),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text('Telah terjadi kesalahan saat mengambil data resep.');
        }

        // Loading
        return snapshot.hasData
            ? ContainerResepTerbaru(recipes: snapshot.data)
            : LoadingListResepTerbaru();
      },
    );
  }
}

class LoadingListResepTerbaru extends StatelessWidget {
  const LoadingListResepTerbaru({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290.0,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 300.0,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 278.0,
                        height: 125.0,
                        color: Colors.grey,
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: EdgeInsets.only(top: 12.0),
                        width: 278.0,
                        height: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: EdgeInsets.only(top: 12.0),
                        width: 278.0,
                        height: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: EdgeInsets.only(top: 12.0),
                        width: 278.0,
                        height: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: EdgeInsets.only(top: 12.0),
                        width: 278.0,
                        height: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ContainerResepTerbaru extends StatefulWidget {
  const ContainerResepTerbaru({Key? key, required this.recipes}) : super(key: key);
  final List<Recipe> recipes;

  @override
  _ContainerResepTerbaruState createState() => _ContainerResepTerbaruState();
}

class _ContainerResepTerbaruState extends State<ContainerResepTerbaru> {
  late List<Recipe> immutableRecipes;

  @override
  initState() {
    immutableRecipes = widget.recipes;
    immutableRecipes.forEach((el) => el.favorite = false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270.0,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: widget.recipes.length,
        itemBuilder: (BuildContext context, int index) {
          Color difficultyColor;

          switch (immutableRecipes[index].difficulty) {
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

          // TODO: Buat card jadi clickable
          return Container(
            width: 300.0,
            child: Card(
              key: Key("${immutableRecipes[index].key}"),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Image.network(
                        immutableRecipes[index].thumb,
                        fit: BoxFit.cover,
                        width: 278.0,
                        height: 125.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAx,
                        children: <Widget>[
                          Text(
                            immutableRecipes[index].title,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF374151),
                              height: 1.45,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        immutableRecipes[index].times,
                                        style:
                                            TextStyle(color: Color(0xFF6B7280)),
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
                                        immutableRecipes[index].portion,
                                        style:
                                            TextStyle(color: Color(0xFF6B7280)),
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
                                        immutableRecipes[index].difficulty,
                                        style:
                                            TextStyle(color: difficultyColor),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    immutableRecipes[index].favorite =
                                        !(immutableRecipes[index].favorite ??
                                            false);
                                  });
                                },
                                icon: (immutableRecipes[index].favorite ??
                                        false)
                                    ? Icon(Icons.favorite, color: Colors.red)
                                    : Icon(Icons.favorite_outline),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ListKategoriResep extends StatelessWidget {
  const ListKategoriResep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCategories(http.Client()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text('Telah terjadi kesalahan saat mengambil data resep.');
        }

        // Loading
        return snapshot.hasData
            ? ContainerKategoriResep(categories: snapshot.data)
            : LoadingKategoriResep();
      },
    );
  }
}

class LoadingKategoriResep extends StatelessWidget {
  const LoadingKategoriResep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.count(
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1.0,
        crossAxisCount: 3,
        shrinkWrap: true,
        children: List.generate(6, (index) {
          return Builder(
            builder: (BuildContext context) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 12.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(2.0),
                            ),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 12.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(2.0),
                            ),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

class ContainerKategoriResep extends StatelessWidget {
  const ContainerKategoriResep({Key? key, required this.categories}) : super(key: key);
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: categories.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          Size cardSize = MediaQuery.of(context).size;
          bool useImageNetwork = false;
          String cardImageDirectory;

          switch (categories[index].key) {
            case 'dessert':
              cardImageDirectory = 'images/categories/dessert.jpg';
              break;
            case 'masakan-hari-raya':
              cardImageDirectory = 'images/categories/masakan-hari-raya.jpg';
              break;
            case 'masakan-tradisional':
              cardImageDirectory = 'images/categories/masakan-tradisional.jpg';
              break;
            case 'makan-malam':
              cardImageDirectory = 'images/categories/makan-malam.jpg';
              break;
            case 'makan-siang':
              cardImageDirectory = 'images/categories/makan-siang.jpg';
              break;
            case 'resep-ayam':
              cardImageDirectory = 'images/categories/resep-ayam.jpg';
              break;
            case 'resep-daging':
              cardImageDirectory = 'images/categories/resep-daging.jpg';
              break;
            case 'resep-sayuran':
              cardImageDirectory = 'images/categories/resep-sayuran.jpg';
              break;
            case 'resep-seafood':
              cardImageDirectory = 'images/categories/resep-seafood.jpg';
              break;
            case 'sarapan':
              cardImageDirectory = 'images/categories/sarapan.jpg';
              break;
            default:
              useImageNetwork = true;
              cardImageDirectory = 'https://picsum.photos/200/200';
              break;
          }

          // TODO: Buat kategori resep jadi clickable
          return Card(
            key: Key(categories[index].key),
            child: Stack(
              children: <Widget>[
                useImageNetwork
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: Image.network(
                          cardImageDirectory,
                          width: cardSize.width,
                          height: cardSize.height,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: Image.asset(
                          cardImageDirectory,
                          width: cardSize.width,
                          height: cardSize.height,
                          fit: BoxFit.cover,
                        ),
                      ),
                Container(
                  width: cardSize.width,
                  height: cardSize.height,
                  decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(4.0)),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      categories[index].category,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ListResepAcak extends StatelessWidget {
  const ListResepAcak({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCategories(http.Client()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text('Telah terjadi kesalahan saat mengambil data resep.');
        }

        // Loading
        return snapshot.hasData ? Text('Resep') : LoadingListResepAcak();
      },
    );
  }
}

class LoadingListResepAcak extends StatelessWidget {
  const LoadingListResepAcak({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Loading');
  }
}
