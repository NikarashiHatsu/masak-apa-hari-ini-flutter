import 'dart:convert';
import 'package:http/http.dart' as http;

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
