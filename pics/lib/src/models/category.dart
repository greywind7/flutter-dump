import 'dart:math';
import 'image.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import 'package:flutter/material.dart';


class CategoryProperties {
  var color;
  var icon;
  late String label;
  late String name;

  void setProperties(color, icon, label) {
    this.color = color;
    this.icon = icon;
    this.label = label;
  }

  CategoryProperties(String category) {
    name = category;
    switch(category) {
      case "cyberpunk":
        setProperties(Colors.yellow, Icons.sunny, "Cyberpunk cool eh?");
      case "experimental":
        setProperties(Colors.orange, Icons.photo, "This is some experimental ass art");
      case "music":
        setProperties(Colors.red, Icons.library_music, "Who doesnt like music duh");
    }
  }
}

class Category {
  late String category;
  late int maxPages;
  late int curPage;
  late List<ImageModel> current_page_queue = [], images = [];
  late int max_entries;
  late Iterator<ImageModel> img_iterator;
  late CategoryProperties properties;

  final String API_KEY = "cerTb2nrTOrbjvpm18u7TGazlHAE28aHBJSW8giGS7Q";

  Category(String category) {
    this.category = category;
    maxPages = 100;
    curPage = 0;
    max_entries = 30;
    properties = CategoryProperties(category);
  }

    Future<void> init() async {
      curPage = Random().nextInt(maxPages > 0 ? maxPages : 100) + 1;
      var response = await get(Uri.parse("https://api.unsplash.com/search/photos?query=$category&page=$curPage&per_page=$max_entries&client_id=$API_KEY"));
      var data = json.decode(response.body);
      maxPages = data["total_pages"];

      for(var record in data["results"]) {
        print(maxPages);
        current_page_queue.add(ImageModel(record["id"], record["urls"]["regular"], record["description"] ?? "No caption make do with this $category image"));
      }

      img_iterator = current_page_queue.iterator;
      max_entries = 30;
    }

    addImage() async {
      if(img_iterator.moveNext()) {
          images.insert(0, img_iterator.current);
      }
      else {
        current_page_queue.clear();
        await init();
        return addImage();
      }
    }
}