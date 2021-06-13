import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Recipe {
  String title;
  String thumb;
  String key;
  String times;
  String portion;
  String difficulty;

  Recipe({
    required this.title,
    required this.thumb,
    required this.key,
    required this.times,
    required this.portion,
    required this.difficulty,
  });
}

Future<List<Recipe>> getRecipes(http.Client client) async {
  final response = await client
      .get(Uri.parse("https://masak-apa.tomorisakura.vercel.app/api/recipes"));

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

Future<List<Recipe>> getPreferredRecipeCount(
    http.Client client, int dataLength) async {
  final response = await client.get(Uri.parse(
      "https://masak-apa.tomorisakura.vercel.app/api/recipes-length/?limit=$dataLength"));

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
