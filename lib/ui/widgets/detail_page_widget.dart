import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_stream_mobile/constant/textStyle.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlUtils {
  UrlUtils._();

  static Future<void> openUrl(String url) async {
    String googleUrl = url;
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the url.';
    }
  }
}

class MyCardWidget extends StatelessWidget {
  const MyCardWidget({
    Key key,
    @required double width,
    @required IconData icon,
    @required String name,
    String url,
  })  : _width = width,
        _icon = icon,
        _url = url,
        _name = name,
        super(key: key);

  final double _width;
  final IconData _icon;
  final String _name;
  final String _url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        UrlUtils.openUrl(_url);
      },
      child: Container(
        height: 50,
        width: _width / 2.3,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              _icon,
              size: 24,
            ),
            Text(
              _name,
              style: kSmallTitleTextStyle,
            )
          ],
        ),
      ),
    );
  }
}

class MySeasonCardWidget extends StatelessWidget {
  const MySeasonCardWidget({
    Key key,
    @required double width,
    @required int index,
    @required Color color,
  })  : _width = width,
        _index = index,
        _color = color,
        super(key: key);

  final double _width;
  final int _index;
  final Color _color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width / 4,
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          "Season $_index",
          style: kSmallTitleTextStyle,
        ),
      ),
    );
  }
}

class EpisodeList extends StatelessWidget {
  const EpisodeList({
    Key key,
    @required String url,
    int episodeIndex,
    int seasonIndex,
  })  : _url = url,
        _episodeIndex = episodeIndex,
        _seasonIndex = seasonIndex,
        super(key: key);

  final String _url;
  final int _episodeIndex;
  final int _seasonIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Color(0xFF394864).withOpacity(.2),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Episode $_episodeIndex',
                  style: kLargeTitleTextStyle,
                ),
                Text('Season $_seasonIndex', style: kSmallEpisodeDescTextStyle)
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              UrlUtils.openUrl(_url);
            },
            child: Icon(Icons.play_arrow, color: Colors.blueGrey, size: 36),
          )
        ],
      ),
    );
  }
}
