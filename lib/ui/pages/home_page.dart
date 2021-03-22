import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:open_stream_mobile/constant/colors.dart';
import 'package:open_stream_mobile/constant/constant.dart';
import 'package:open_stream_mobile/constant/textStyle.dart';
import 'package:open_stream_mobile/ui/widgets/core_widgets.dart';
import 'package:open_stream_mobile/ui/widgets/home_page_widgets.dart';
import 'package:open_stream_mobile/utils/props/no_glow.dart';
import 'package:open_stream_mobile/utils/services/banners_provider.dart';
import 'package:open_stream_mobile/utils/services/category_provider.dart';
import 'package:open_stream_mobile/utils/services/popular_provider.dart';
import 'package:open_stream_mobile/utils/services/shows_provider.dart';
import 'package:open_stream_mobile/utils/services/users_provider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    //internet checker
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    //banner provider
    final _bannerP = Provider.of<BannerProvider>(context, listen: false);
    _bannerP.getBannerData(context);

    //shows provider
    final _showsP = Provider.of<ShowsProvider>(context, listen: false);
    _showsP.getShowsData(context);

    //popular provider
    final _popularP = Provider.of<PopularProvider>(context, listen: false);
    _popularP.getPopularData(context);

    //popular provider
    final _categoryP = Provider.of<CategoryProvider>(context, listen: false);
    _categoryP.getCategoryData(context);

    //user provider
    final _userP = Provider.of<UserProvider>(context, listen: false);
    _userP.getUserData(context);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  @override
  Widget build(BuildContext context) {
    final _bannerP = Provider.of<BannerProvider>(context);
    final _showsP = Provider.of<ShowsProvider>(context);
    final _popularP = Provider.of<PopularProvider>(context);
    final _categoryP = Provider.of<CategoryProvider>(context);
    final _userP = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: kHomeBackGroundColor,
        appBar: AppBar(
          backgroundColor: kAppBarColor,
          centerTitle: true,
          title: Text(
            'App Name',
            style: kAppBarTextStyle,
          ),
        ),
        drawer: _connectionStatus == 'ConnectivityResult.none' ? Container() : MyDrawerWidgets(name: _userP.user.name, email: _userP.user.email),
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
          ),
          child: _bannerP.loading
              ? MyProgressBar()
              : ScrollConfiguration(
                  behavior: NoGlowBehavior(),
                  child: SingleChildScrollView(
                    child: _connectionStatus == 'ConnectivityResult.none'
                        ? Container()
                        : Column(
                            children: [
                              //Banner Card
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                                child: CarouselSlider.builder(
                                  itemCount: _bannerP.banners.length,
                                  options: CarouselOptions(autoPlay: true, height: kBannerHeight, viewportFraction: 1),
                                  itemBuilder: (BuildContext context, int index, int realIndex) {
                                    return MyBannerWidgets(
                                      image: _bannerP.banners[index].image,
                                      id: _bannerP.banners[index].showId,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 10),

                              //Streaming List
                              Container(
                                height: kLabelTreyHeight,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: MyLabelTray(
                                  label: 'Streaming For Free Now',
                                  isGoing: true,
                                ),
                              ),
                              Container(
                                height: kShowCardHeight,
                                margin: EdgeInsets.only(left: 8, top: 5),
                                child: ListView.builder(
                                  itemCount: _showsP.show.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context, int index) {
                                    return MyShowCard(
                                      image: _showsP.show[index].hImage,
                                      id: _showsP.show[index].showId,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 10),

                              //Popular List
                              Container(
                                height: kLabelTreyHeight,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: MyLabelTray(
                                  label: 'Popular',
                                  leading: false,
                                ),
                              ),
                              Container(
                                height: kPopularHeight,
                                margin: EdgeInsets.only(left: 8, top: 5),
                                child: ListView.builder(
                                  itemCount: _popularP.popular.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context, int index) {
                                    return MyPopularCardWidgets(
                                      image: _popularP.popular[index].image,
                                      id: _popularP.popular[index].showId,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 10),

                              //category
                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: _categoryP.categories.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: kLabelTreyHeight,
                                        padding: EdgeInsets.symmetric(horizontal: 15),
                                        child: MyLabelTray(
                                          label: _categoryP.categories[index].name,
                                          categoryId: _categoryP.categories[index].id,
                                          isGoing: false,
                                        ),
                                      ),
                                      Container(
                                        height: kShowCardHeight,
                                        margin: EdgeInsets.only(left: 8, top: 5),
                                        child: ListView.builder(
                                          itemCount: _categoryP.categories[index].cShow.length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context, int i) {
                                            return MyShowCard(
                                              image: _categoryP.categories[index].cShow[i].image,
                                              id: _categoryP.categories[index].cShow[i].id,
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  );
                                },
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                  ),
                ),
        ),
        bottomNavigationBar: _connectionStatus == 'ConnectivityResult.none' ? Container() : MyBottomBar(),
      ),
    );
  }

  //status update
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }
}
