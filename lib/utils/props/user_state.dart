import 'package:hive/hive.dart';

class LocalData {
  saveData(key, value) async {
    var box = await Hive.openBox('myBox');
    box.put(key, value);
  }

  Future<String> getData(key) async {
    var box = await Hive.openBox('myBox');
    String _name = box.get(key);
    print("name: $_name");
    return _name;
  }

  clearData() async {
    var box = await Hive.openBox('myBox');
    box.clear();
  }
}
