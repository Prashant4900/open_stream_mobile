import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:open_stream_mobile/constant/string.dart';
import 'package:open_stream_mobile/constant/urls.dart';
import 'package:open_stream_mobile/model/category_model.dart';

class CategoryProvider with ChangeNotifier {
  bool loading = false;

  List<CategoryModel> _categories = [];

  List<CategoryModel> get categories {
    return [..._categories];
  }

  getCategoryData(context) async {
    loading = true;
    _categories = await fetchTask(context);
    loading = false;
    notifyListeners();
  }

  fetchTask(context) async {
    var box = await Hive.openBox(keyHiveBox);
    var _token = box.get(keyToken);
    final response = await http.get(Uri.https(baseUrl, 'categories'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _categories = data.map<CategoryModel>((json) => CategoryModel.fromJson(json)).toList();
      return _categories;
    }
  }
}
