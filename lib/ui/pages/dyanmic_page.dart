import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_stream_mobile/constant/colors.dart';
import 'package:open_stream_mobile/model/category_model.dart';
import 'package:open_stream_mobile/model/shows_model.dart';
import 'package:open_stream_mobile/ui/widgets/core_widgets.dart';
import 'package:open_stream_mobile/utils/props/no_glow.dart';
import 'package:open_stream_mobile/utils/props/route_helper.dart';
import 'package:open_stream_mobile/utils/services/category_provider.dart';
import 'package:open_stream_mobile/utils/services/shows_provider.dart';
import 'package:provider/provider.dart';

class MyDynamicPage extends StatefulWidget {
  @override
  _MyDynamicPageState createState() => _MyDynamicPageState();
}

class _MyDynamicPageState extends State<MyDynamicPage> {
  @override
  void initState() {
    super.initState();

    //shows provider
    final _shows = Provider.of<ShowsProvider>(context, listen: false);
    _shows.getShowsData(context);

    //category provider
    final _category = Provider.of<CategoryProvider>(context, listen: false);
    _category.getCategoryData(context);
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    final _shows = Provider.of<ShowsProvider>(context);
    final _category = Provider.of<CategoryProvider>(context);

    List<ShowsModel> _goingShowsList = new List();
    CategoryModel _categoryList;

    for (int i = 0; i < _shows.show.length; i++) {
      if (_shows.show[i].onGoing == args.isGoing) {
        _goingShowsList.add(_shows.show[i]);
      }
    }

    for (int i = 0; i < _category.categories.length; i++) {
      if (_category.categories[i].id == args.categoryId) {
        _categoryList = _category.categories[i];
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: kHomeBackGroundColor,

        //appbar
        appBar: AppBar(
          backgroundColor: kBackGroundColor,
          centerTitle: true,
          title: Text(
            args.isGoing ? 'Streaming' : _categoryList.name,
            style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),

        //body
        body: Container(
          padding: EdgeInsets.all(8.0),
          child: ScrollConfiguration(
            behavior: NoGlowBehavior(),
            child: GridView.builder(
              itemCount: args.isGoing ? _goingShowsList.length : _categoryList.cShow.length,
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0, childAspectRatio: .75),
              itemBuilder: (BuildContext context, int index) {
                return args.isGoing
                    ? MyShowCard(
                        image: _goingShowsList[index].vImage,
                        id: _goingShowsList[index].showId,
                        fit: BoxFit.fill,
                      )
                    : MyShowCard(
                        image: _categoryList.cShow[index].vImage,
                        id: _categoryList.cShow[index].id,
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
