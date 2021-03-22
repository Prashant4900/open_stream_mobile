import 'package:flutter/material.dart';
import 'package:open_stream_mobile/constant/colors.dart';
import 'package:open_stream_mobile/ui/widgets/core_widgets.dart';
import 'package:open_stream_mobile/utils/props/no_glow.dart';
import 'package:open_stream_mobile/utils/props/route_helper.dart';
import 'package:open_stream_mobile/utils/services/shows_provider.dart';
import 'package:provider/provider.dart';

class MyShowsPages extends StatefulWidget {
  @override
  _MyShowsPagesState createState() => _MyShowsPagesState();
}

class _MyShowsPagesState extends State<MyShowsPages> {
  @override
  void initState() {
    super.initState();

    //shows provider
    final _shows = Provider.of<ShowsProvider>(context, listen: false);
    _shows.getShowsData(context);
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    final _shows = Provider.of<ShowsProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: kHomeBackGroundColor,

        //appbar
        appBar: AppBar(
          backgroundColor: kBackGroundColor,
          centerTitle: true,
          title: Text(
            'Shows',
            style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w400),
          ),
        ),

        //body
        body: Container(
          padding: EdgeInsets.all(8.0),
          child: ScrollConfiguration(
            behavior: NoGlowBehavior(),
            child: GridView.builder(
              itemCount: _shows.show.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0, childAspectRatio: .75),
              itemBuilder: (BuildContext context, int index) {
                return MyShowCard(
                  image: _shows.show[index].vImage,
                  id: _shows.show[index].showId,
                  fit: BoxFit.fill,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
