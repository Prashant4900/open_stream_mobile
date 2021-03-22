import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:open_stream_mobile/constant/string.dart';
import 'package:open_stream_mobile/constant/urls.dart';
import 'package:open_stream_mobile/model/popular_model.dart';

class PopularProvider with ChangeNotifier {
  bool loading = false;

  List<PopularModel> _popular = [];

  List<PopularModel> get popular {
    return [..._popular];
  }

  getPopularData(context) async {
    loading = true;
    _popular = await fetchTask(context);
    loading = false;
    notifyListeners();
  }

  fetchTask(context) async {
    var box = await Hive.openBox(keyHiveBox);
    var _token = box.get(keyToken);
    final response = await http.get(Uri.https(baseUrl, 'populars'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _popular = data
          .map<PopularModel>((json) => PopularModel.fromJson(json))
          .toList();
      return _popular;
    }
  }
}
