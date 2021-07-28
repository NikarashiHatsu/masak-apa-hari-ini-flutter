import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:masak_apa_hari_ini/model/recipe.dart';

class Category {
  String category;
  String url;
  String key;

  Category({
    required this.category,
    required this.url,
    required this.key,
  });
}

Future<List<Category>> getCategories(http.Client client) async {
  final response = await client.get(Uri.parse(
      "https://masak-apa.tomorisakura.vercel.app/api/categorys/recipes"));

  List<dynamic> data = jsonDecode(response.body)['results'];

  return data.map((json) {
    return Category(
      category: json['category'],
      url: json['url'],
      key: json['key'],
    );
  }).toList();
}

Future<List<Recipe>> getRecipesFromCategory(http.Client client, String category) async {
  switch (category) {
    case 'dessert':
      category = 'resep-' + category;
      break;
    default:
  }

  final response = await client.get(Uri.parse(
    "https://masak-apa.tomorisakura.vercel.app/api/categorys/recipes/" + category));
  
  List<dynamic> data = jsonDecode(response.body)['results'];

  return data.map((json) {
    return Recipe(
      title: json['title'],
      thumb: json['thumb'],
      key: json['key'],
      times: json['times'],
      portion: json['portion'],
      difficulty: json['dificulty'],
    );
  }).toList();
}