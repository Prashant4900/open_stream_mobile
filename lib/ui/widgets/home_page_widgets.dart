import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:open_stream_mobile/constant/colors.dart';
import 'package:open_stream_mobile/constant/constant.dart';
import 'package:open_stream_mobile/constant/routes.dart';
import 'package:open_stream_mobile/constant/textStyle.dart';
import 'package:open_stream_mobile/ui/widgets/core_widgets.dart';
import 'package:open_stream_mobile/utils/props/route_helper.dart';

class MyBottomBar extends StatelessWidget {
  const MyBottomBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kBackGroundColor,
      margin: EdgeInsets.all(0),
      elevation: 10,
      shape: RoundedRectangleBorder(),
      child: Container(
        height: 58,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              child: Icon(
                LineAwesomeIcons.atom,
                size: 36,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              child: Icon(
                LineAwesomeIcons.search,
                size: 36,
                color: Colors.grey,
              ),
              onTap: () {
                Navigator.pushNamed(context, SearchPageRoute);
              },
            ),
            GestureDetector(
              child: Icon(
                LineAwesomeIcons.headphones,
                size: 36,
                color: Colors.grey,
              ),
              onTap: () {
                Navigator.pushNamed(context, ShowsPageRoute);
              },
            ),
            GestureDetector(
              child: Icon(
                LineAwesomeIcons.user,
                size: 36,
                color: Colors.grey,
              ),
              onTap: () {
                Navigator.pushNamed(context, UserPageRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyPopularCardWidgets extends StatelessWidget {
  const MyPopularCardWidgets({
    Key key,
    @required String image,
    @required String id,
  })  : _image = image,
        _id = id,
        super(key: key);

  final String _image;
  final String _id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailPageRoute, arguments: ScreenArguments(id: _id));
      },
      child: Container(
        width: kPopularWidth,
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Image.network(
          _image,
          fit: BoxFit.fill,
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

class MyLabelTray extends StatelessWidget {
  const MyLabelTray({
    Key key,
    @required String label,
    bool isGoing,
    bool leading,
    String categoryId,
  })  : _label = label,
        _isGoing = isGoing,
        _leading = leading,
        _categoryId = categoryId,
        super(key: key);

  final String _label;
  final bool _isGoing;
  final bool _leading;
  final String _categoryId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(_label, style: kHomeLabelTextStyle),
        ),
        _leading ?? true
            ? GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, DynamicPageRoute,
                      arguments: ScreenArguments(isGoing: _isGoing ?? false, categoryId: _categoryId ?? null));
                },
                child: Icon(LineAwesomeIcons.arrow_right, color: Colors.grey),
              )
            : Container(),
      ],
    );
  }
}

class MyBannerWidgets extends StatelessWidget {
  const MyBannerWidgets({
    Key key,
    @required String image,
    @required String id,
  })  : _image = image,
        _id = id,
        super(key: key);

  final String _image;
  final String _id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailPageRoute, arguments: ScreenArguments(id: _id));
      },
      child: Image.network(
        _image,
        fit: BoxFit.fill,
        height: kBannerHeight,
        width: double.infinity,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
          if (loadingProgress == null)
            return child;
          else
            return MyProgressBar();
        },
      ),
    );
  }
}

class MyDrawerWidgets extends StatelessWidget {
  const MyDrawerWidgets({
    Key key,
    @required String name,
    @required String email,
  })  : _name = name,
        _email = email,
        super(key: key);

  final String _name;
  final String _email;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        color: kHomeBackGroundColor,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, UserPageRoute);
                    },
                    child: Icon(
                      Icons.account_circle,
                      size: 54,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(_name ?? 'Name', style: kHomeLabelTextStyle),
                  SizedBox(height: 3),
                  Text(_email ?? 'Email', style: kHeaderBottomTextStyle.copyWith(color: Colors.grey)),
                  SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.contacts),
                    title: Text("Contact Us"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 5),
                  ListTile(
                    leading: Icon(Icons.contacts),
                    title: Text("Contact Us"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 5),
                  ListTile(
                    leading: Icon(Icons.contacts),
                    title: Text("Contact Us"),
                    onTap: () => Navigator.pop(context),
                  ),
                  SizedBox(height: 5),
                  ListTile(
                    leading: Icon(Icons.contacts),
                    title: Text("Contact Us"),
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(height: 15, child: Text("Term and Conditions", style: kHeaderBottomTextStyle)),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(height: 15, child: Text("Privacy Policy", style: kHeaderBottomTextStyle)),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(height: 15, child: Text("Contact Us", style: kHeaderBottomTextStyle)),
            ),
          ],
        ),
      ),
    );
  }
}
