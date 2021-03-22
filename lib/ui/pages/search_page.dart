import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:open_stream_mobile/constant/colors.dart';
import 'package:open_stream_mobile/constant/textStyle.dart';
import 'package:open_stream_mobile/model/shows_model.dart';
import 'package:open_stream_mobile/ui/widgets/core_widgets.dart';
import 'package:open_stream_mobile/utils/props/no_glow.dart';
import 'package:open_stream_mobile/utils/services/shows_provider.dart';
import 'package:provider/provider.dart';

class MySearchPage extends StatefulWidget {
  @override
  _MySearchPageState createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  var newText = '';
  List<ShowsModel> _showsList = [];

  @override
  void initState() {
    super.initState();

    print(_showsList.length);
    final _showP = Provider.of<ShowsProvider>(context, listen: false);
    _showP.getShowsData(context);
  }

  @override
  Widget build(BuildContext context) {
    final _showP = Provider.of<ShowsProvider>(context);

    if (_showsList.length == 0) {
      for (int i = 0; i < _showP.show.length; i++) {
        setState(() {});
        if (_showP.show[i].showTitle.toLowerCase().contains(newText)) {
          setState(() {});
          _showsList.add(_showP.show[i]);
          setState(() {});
        }
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: kHomeBackGroundColor,
        appBar: AppBar(
          backgroundColor: kBackGroundColor,
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          title: Text(
            'Search',
            style: kLargeTitleTextStyle,
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                autocorrect: true,
                cursorColor: Colors.black87,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Typing...',
                  suffixIcon: Icon(LineAwesomeIcons.search, color: Colors.black),
                ),
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: Colors.black),
                onChanged: (text) {
                  _showsList.clear();
                  newText = text.toLowerCase();
                  setState(() {});
                },
              ),
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ScrollConfiguration(
            behavior: NoGlowBehavior(),
            child: GridView.builder(
              itemCount: _showsList.length,
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0, childAspectRatio: .75),
              itemBuilder: (BuildContext context, int index) {
                print(_showsList.length);

                return MyShowCard(
                  image: _showsList[index].vImage,
                  id: _showsList[index].showId,
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
