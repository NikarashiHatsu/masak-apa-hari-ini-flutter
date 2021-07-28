import 'dart:convert';

import 'package:http/http.dart' as http;

class ArticleCategory {
  String title;
  String key;

  ArticleCategory({required this.title, required this.key});
}

Future<List<ArticleCategory>> getArticleCategories(http.Client client) async {
  final response = await client.get(Uri.parse(
      "https://masak-apa.tomorisakura.vercel.app/api/categorys/article"));

  List<dynamic> data = jsonDecode(response.body)['results'];

  return data.map((json) {
    return ArticleCategory(title: json['title'], key: json['key']);
  }).toList();
}
