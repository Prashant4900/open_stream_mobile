import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_stream_mobile/constant/colors.dart';
import 'package:open_stream_mobile/constant/routes.dart';
import 'package:open_stream_mobile/ui/widgets/auth_page_widgets.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
          ),
          child: Container(
            color: kBackGroundColor,
            width: double.infinity,
            height: _height,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 300,
                ),
                Column(
                  children: [
                    MyAuthButtonWidget(
                      label: 'Log in',
                      color: Color(0xffBE1ACF),
                      onTapped: () {
                        Navigator.pushNamed(context, SigninRoute);
                      },
                    ),
                    SizedBox(height: 30),
                    MyAuthButtonWidget(
                      label: 'Sign Up',
                      color: Color(0xffBE1ACF),
                      onTapped: () {
                        Navigator.pushNamed(context, SignupRoute);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
