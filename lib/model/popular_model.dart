class PopularModel {
  PopularModel({this.id, this.showTitle, this.showDesc, this.showId, this.image});

  final String id;
  final String showId;
  final String showTitle;
  final String showDesc;
  final String image;

  factory PopularModel.fromJson(Map<String, dynamic> json) {
    return PopularModel(
      id: json['_id'],
      showTitle: json['show']['showTitle'],
      showId: json['show']['_id'],
      image: json['show']['image']['url'],
    );
  }
}
