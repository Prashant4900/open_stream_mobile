class ShowsModel {
  ShowsModel({
    this.showId,
    this.showTitle,
    this.showDesc,
    this.trailer,
    this.hImage,
    this.vImage,
    this.channelName,
    this.channelUrl,
    this.showsEpisodes,
    this.seasonWise,
    this.onGoing,
  });
  final String showId;
  final String showTitle;
  final String showDesc;
  final String trailer;
  final String channelName;
  final String channelUrl;
  final String hImage;
  final String vImage;
  final bool seasonWise;
  final bool onGoing;
  final List<MyShowEpisodeModel> showsEpisodes;

  factory ShowsModel.fromJson(Map<String, dynamic> json) {
    var resultList = json["episodes"] as List;
    List<MyShowEpisodeModel> _episodeResult = resultList.map((i) => MyShowEpisodeModel.fromJson(i)).toList();
    return ShowsModel(
      showId: json['_id'],
      showTitle: json['showTitle'],
      showDesc: json['showDescription'],
      trailer: json['tralier'],
      seasonWise: json['seasonWise'],
      onGoing: json['onGoing'],
      hImage: json['bannerImage']['url'],
      vImage: json['image']['url'],
      channelName: json['channel']['name'],
      channelUrl: json['channel']['url'],
      showsEpisodes: _episodeResult,
    );
  }
}

class MyShowEpisodeModel {
  MyShowEpisodeModel(
      {this.episodeId, this.episodeTitle, this.seasons, this.episodeIndex, this.seasonIndex, this.episodeUrl});
  final String episodeId;
  final String episodeTitle;
  final String seasons;
  final int episodeIndex;
  final int seasonIndex;
  final String episodeUrl;

  factory MyShowEpisodeModel.fromJson(Map<String, dynamic> json) {
    return MyShowEpisodeModel(
      episodeId: json['_id'],
      seasons: json['Seasons'],
      episodeTitle: json['episodeTitle'],
      episodeIndex: json['episodeIndex'],
      seasonIndex: json['seasonIndex'],
      episodeUrl: json['episodeUrl'],
    );
  }
}
