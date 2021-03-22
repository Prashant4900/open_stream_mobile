import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:open_stream_mobile/constant/string.dart';
import 'package:open_stream_mobile/constant/urls.dart';
import 'package:open_stream_mobile/model/banner_model.dart';

class BannerProvider with ChangeNotifier {
  bool loading = false;

  List<BannerModel> _banners = [];

  List<BannerModel> get banners {
    return [..._banners];
  }

  getBannerData(context) async {
    loading = true;
    _banners = await fetchTask(context);
    loading = false;
    notifyListeners();
  }

  fetchTask(context) async {
    var box = await Hive.openBox(keyHiveBox);
    var _token = box.get(keyToken);
    final response = await http.get(Uri.https(baseUrl, 'banners'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _banners =
          data.map<BannerModel>((json) => BannerModel.fromJson(json)).toList();
      return _banners;
    }
  }
}
