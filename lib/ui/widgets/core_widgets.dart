import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_stream_mobile/constant/constant.dart';
import 'package:open_stream_mobile/constant/routes.dart';
import 'package:open_stream_mobile/utils/props/route_helper.dart';

class MyProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 40,
        child: CircularProgressIndicator(
          strokeWidth: 5,
        ),
      ),
    );
  }
}

class MyShowCard extends StatelessWidget {
  const MyShowCard({
    Key key,
    @required String image,
    @required String id,
    BoxFit fit,
    double height,
  })  : _image = image,
        _id = id,
        _height = height,
        _fit = fit,
        super(key: key);

  final String _image;
  final String _id;
  final BoxFit _fit;
  final double _height;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailPageRoute, arguments: ScreenArguments(id: _id));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3),
        width: _height ?? kShowCardWidth,
        child: Image.network(
          _image,
          fit: _fit ?? BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
            if (loadingProgress == null)
              return child;
            else
              return MyProgressBar();
          },
        ),
      ),
    );
  }
}
