import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:masak_apa_hari_ini/model/author.dart';

class RecipeDetail {
  String? title;
  String? thumb;
  String? servings;
  String? times;
  String? difficulty;
  Author? author;
  String? desc;
  List<dynamic>? needItem;
  List<dynamic>? ingredients;
  List<dynamic>? steps;

  RecipeDetail({
    this.title,
    this.thumb,
    this.servings,
    this.times,
    this.difficulty,
    this.author,
    this.desc,
    this.needItem,
    this.ingredients,
    this.steps,
  });
}

Future<RecipeDetail> getRecipeDetail(http.Client client, String recipeKey) async {
  final response = await client
    .get(Uri.parse("https://masak-apa.tomorisakura.vercel.app/api/recipe/$recipeKey"));

  Map<dynamic, dynamic> data = jsonDecode(response.body)['results'];

  Author author = new Author(
    user: data['author']['user'],
    datePublished: data['author']['datePublished'],
  );

  return RecipeDetail(
    author: author,
    desc: data['desc'],
    difficulty: data['dificulty'],
    ingredients: data['ingredient'],
    needItem: data['needItem'],
    servings: data['servings'],
    steps: data['step'],
    thumb: data['thumb'] ?? 'https://via.placeholder.com/500x350',
    times: data['times'],
    title: data['title']
  );
}