import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:open_stream_mobile/constant/string.dart';
import 'package:open_stream_mobile/constant/urls.dart';
import 'package:open_stream_mobile/model/shows_model.dart';

class ShowsProvider with ChangeNotifier {
  bool loading = false;

  List<ShowsModel> _shows = [];

  List<ShowsModel> get show {
    return [..._shows];
  }

  getShowsData(context) async {
    loading = true;
    _shows = await fetchTask(context);
    loading = false;
    notifyListeners();
  }

  fetchTask(context) async {
    var box = await Hive.openBox(keyHiveBox);
    var _token = box.get(keyToken);
    final response = await http.get(Uri.https(baseUrl, 'shows'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _shows = data.map<ShowsModel>((json) => ShowsModel.fromJson(json)).toList();
      return _shows;
    }
  }
}
