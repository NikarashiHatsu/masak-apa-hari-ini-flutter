class RecipeDetail {
  String? title;
  String? thumb;
  String? portion;
  String? time;
  String? difficulty;
  Map<String, String>? author;
  String? desc;
  List<Map<String, String>>? needItem;
  List<String>? ingredients;
  List<String>? steps;

  RecipeDetail({
    this.title,
    this.thumb,
    this.portion,
    this.time,
    this.difficulty,
    this.author,
    this.desc,
    this.needItem,
    this.ingredients,
    this.steps,
  });
}
