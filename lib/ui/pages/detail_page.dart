import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:open_stream_mobile/constant/colors.dart';
import 'package:open_stream_mobile/constant/textStyle.dart';
import 'package:open_stream_mobile/model/shows_model.dart';
import 'package:open_stream_mobile/ui/widgets/core_widgets.dart';
import 'package:open_stream_mobile/ui/widgets/detail_page_widget.dart';
import 'package:open_stream_mobile/utils/props/no_glow.dart';
import 'package:open_stream_mobile/utils/props/route_helper.dart';
import 'package:open_stream_mobile/utils/services/shows_provider.dart';
import 'package:provider/provider.dart';

class MyDetailPage extends StatefulWidget {
  @override
  _MyDetailPageState createState() => _MyDetailPageState();
}

class _MyDetailPageState extends State<MyDetailPage> {
  bool textLength = false;
  int varIndex = 0;
  @override
  Widget build(BuildContext context) {
    //variable
    final double _width = MediaQuery.of(context).size.width;
    List<int> _tempList = new List();

    List<int> _seasonIndexList = new List();

    //helper
    final ScreenArguments _args = ModalRoute.of(context).settings.arguments;
    final _showP = Provider.of<ShowsProvider>(context);

    //show data
    var _stuff = (_showP.show.where((show) => show.showId == _args.id));
    var _showData = _stuff.first;

    //episode data
    List<MyShowEpisodeModel> episodeData = _stuff.first.showsEpisodes;
    episodeData.sort((item, otherItem) => item.episodeIndex..compareTo(otherItem.episodeIndex));

    //season index filter
    for (int i = 0; i < _showData.showsEpisodes.length; i++) {
      _tempList.add(_showData.showsEpisodes[i].seasonIndex);
    }
    _seasonIndexList = [
      ...{..._tempList}
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: kHomeBackGroundColor,
        appBar: AppBar(
          backgroundColor: kAppBarColor,
          centerTitle: true,
          title: Text(
            _showData.showTitle ?? 'Details',
            style: TextStyle(color: kAppBarIconsColor, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        body: ScrollConfiguration(
          behavior: NoGlowBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  child: Image.network(
                    _showData.hImage,
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null)
                        return child;
                      else
                        return MyProgressBar();
                    },
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(_showData.showTitle, style: kHomeLabelTextStyle.copyWith(fontSize: 22)),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (textLength == false) {
                        textLength = true;
                      } else {
                        textLength = false;
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: RichText(
                      maxLines: textLength ? 50 : 4,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(text: _showData.showDesc, style: kHomeLabelTextStyle.copyWith(fontWeight: FontWeight.w300, fontSize: 13)),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MyCardWidget(
                      width: _width,
                      icon: LineAwesomeIcons.youtube,
                      name: _showData.channelName,
                      url: _showData.channelUrl,
                    ),
                    MyCardWidget(
                      width: _width,
                      icon: Icons.hearing,
                      name: 'Trailers',
                      url: _showData.trailer,
                    ),
                  ],
                ),
                _showData.seasonWise == true ? SizedBox(height: 20) : SizedBox(height: 0),
                _showData.seasonWise == true
                    ? Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _seasonIndexList.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                if (varIndex != index) {
                                  setState(() => varIndex = index);
                                }
                              },
                              child: MySeasonCardWidget(
                                width: _width,
                                index: index + 1,
                                color: index == varIndex ? Colors.orangeAccent : Colors.red,
                              ),
                            );
                          },
                        ),
                      )
                    : Container(),
                SizedBox(height: 20),
                ScrollConfiguration(
                  behavior: NoGlowBehavior(),
                  child: _showData.seasonWise
                      ? ListView.builder(
                          itemCount: episodeData.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return episodeData[index].seasonIndex == varIndex + 1
                                ? EpisodeList(
                                    url: episodeData[index].episodeUrl,
                                    episodeIndex: episodeData[index].episodeIndex,
                                    seasonIndex: episodeData[index].seasonIndex,
                                  )
                                : Container();
                          },
                        )
                      : ListView.builder(
                          itemCount: episodeData.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return EpisodeList(
                              url: episodeData[index].episodeUrl,
                              episodeIndex: episodeData[index].episodeIndex,
                              seasonIndex: episodeData[index].seasonIndex,
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
