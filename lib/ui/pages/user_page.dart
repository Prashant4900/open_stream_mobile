import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:open_stream_mobile/constant/colors.dart';
import 'package:open_stream_mobile/constant/routes.dart';
import 'package:open_stream_mobile/constant/string.dart';
import 'package:open_stream_mobile/ui/widgets/user_page_widgets.dart';
import 'package:open_stream_mobile/utils/props/no_glow.dart';
import 'package:open_stream_mobile/utils/services/users_provider.dart';
import 'package:provider/provider.dart';

class MyUserPage extends StatefulWidget {
  @override
  _MyUserPageState createState() => _MyUserPageState();
}

class _MyUserPageState extends State<MyUserPage> {
  @override
  void initState() {
    super.initState();

    //user provider
    final _userP = Provider.of<UserProvider>(context, listen: false);
    _userP.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    final _userP = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: kHomeBackGroundColor,

      //appbar
      appBar: AppBar(
        backgroundColor: kBackGroundColor,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(LineAwesomeIcons.arrow_left, color: Colors.white),
        ),
        title: Text(
          'Account',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),

      //body
      body: Container(
        margin: EdgeInsets.all(12),
        child: ScrollConfiguration(
          behavior: NoGlowBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Text(
                  'Personal Details',
                  style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w400),
                ),
                MyColumn(label: 'Name', title: _userP.user.name),
                MyColumn(label: 'Username', title: _userP.user.username),
                MyColumn(label: 'Email', title: _userP.user.email),
                MyColumn(label: 'Mobile', title: _userP.user.number),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(color: Colors.grey),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () async {
                    print('Sign out');
                    var box = await Hive.openBox(keyHiveBox);
                    box.clear();
                    Navigator.pushNamed(context, StartRoute);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: Text(
                      'Sign Out',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
