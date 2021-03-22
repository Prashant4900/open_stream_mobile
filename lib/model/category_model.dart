class CategoryModel {
  CategoryModel({this.id, this.name, this.cShow});
  final String id;
  final String name;
  final List<MyCategoryShowModel> cShow;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    var resultList = json['shows'] as List;
    List<MyCategoryShowModel> _result = resultList.map((i) => MyCategoryShowModel.fromJson(i)).toList();

    return new CategoryModel(
      id: json['id'],
      name: json['name'],
      cShow: _result,
    );
  }
}

class MyCategoryShowModel {
  MyCategoryShowModel({this.id, this.showTitle, this.image, this.vImage});
  final String id;
  final String showTitle;
  final String image;
  final String vImage;

  factory MyCategoryShowModel.fromJson(Map<String, dynamic> json) {
    return MyCategoryShowModel(
      id: json['_id'],
      showTitle: json['showTitle'],
      image: json['bannerImage']['url'],
      vImage: json['image']['url'],
    );
  }
}
