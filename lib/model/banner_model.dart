class BannerModel {
  BannerModel(
      {this.bannerId,
      this.showId,
      this.bannerTitle,
      this.category,
      this.image});
  final String bannerId;
  final String showId;
  final String bannerTitle;
  final String category;
  final String image;

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      bannerId: json['_id'],
      bannerTitle: json['show']['showTitle'],
      showId: json['show']['_id'],
      image: json['show']['bannerImage']['url'],
    );
  }
}
