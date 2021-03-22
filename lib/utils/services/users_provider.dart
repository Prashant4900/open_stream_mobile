import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:open_stream_mobile/constant/string.dart';
import 'package:open_stream_mobile/constant/urls.dart';
import 'package:open_stream_mobile/model/user_model.dart';

Future<UserDetailModel> getSingleUserData(context) async {
  var box = await Hive.openBox(keyHiveBox);
  var _uid = box.get(keyUid);
  var _token = box.get(keyToken);

  UserDetailModel result;

  final response = await http.get(Uri.https(baseUrl, 'users/$_uid'), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $_token',
  });

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    result = UserDetailModel.fromJson(data);
    return result;
  }
  return null;
}

class UserProvider with ChangeNotifier {
  UserDetailModel user = UserDetailModel();
  bool loading = false;

  getUserData(context) async {
    loading = true;
    user = await getSingleUserData(context);
    loading = false;

    notifyListeners();
  }
}
