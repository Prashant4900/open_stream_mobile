import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:open_stream_mobile/constant/colors.dart';
import 'package:open_stream_mobile/constant/string.dart';
import 'package:open_stream_mobile/constant/textStyle.dart';
import 'package:open_stream_mobile/constant/urls.dart';
import 'package:open_stream_mobile/ui/widgets/auth_page_widgets.dart';
import 'package:open_stream_mobile/ui/widgets/core_widgets.dart';
import 'package:open_stream_mobile/ui/widgets/display_dialog.dart';
import 'package:open_stream_mobile/utils/props/no_glow.dart';
import 'package:open_stream_mobile/utils/props/user_state.dart';

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  bool _obscureText = true;
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<String> attemptLogIn(String email, String password) async {
    setState(() => _isLoading = true);

    var res = await http.post(Uri.https(baseUrl, userLoginUrl), body: {
      "identifier": email,
      "password": password,
    });
    if (res.statusCode == 200) {
      final responseData = json.decode(res.body);
      LocalData _data = new LocalData();
      _data.saveData(keyToken, responseData['jwt']);
      _data.saveData(keyUid, responseData['user']['_id']);
      Navigator.pushNamed(context, '/homepage');
      return res.body;
    } else {
      setState(() => _isLoading = false);
      displayDialog(context: context, text: 'No account was found matching that email and password');
    }
    return null;
  }

  void _toggle() {
    setState(() => _obscureText = !_obscureText);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kHomeBackGroundColor,
        appBar: AppBar(
          backgroundColor: kBackGroundColor,
          centerTitle: true,
          title: Text('Sign In', style: kAppBarTextStyle),
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: ScrollConfiguration(
            behavior: NoGlowBehavior(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Text(
                    'Login with your Email & Password',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSerif(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 30),
                  MyTestField(
                    controller: _emailController,
                    hintText: 'Enter Email',
                    inputType: TextInputType.emailAddress,
                    label: 'Email',
                    icon: Icons.mail,
                  ),
                  SizedBox(height: 15),
                  MyTestField(
                    controller: _passwordController,
                    hintText: 'Enter Password',
                    inputType: TextInputType.text,
                    label: 'Password',
                    icon: Icons.lock,
                    obscureText: _obscureText,
                    autocorrect: false,
                    suffixIcon: InkWell(
                      child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off, color: Colors.black),
                      onTap: _toggle,
                    ),
                  ),
                  SizedBox(height: 30),
                  _isLoading
                      ? MyProgressBar()
                      : MyAuthButtonWidget(
                          label: 'Log in',
                          color: Color(0xffBE1ACF),
                          width: 200,
                          onTapped: () {
                            var _email = _emailController.text.toLowerCase().toString().trim();
                            var _pass = _passwordController.text.toString().trim();
                            if (_email.isEmpty) {
                              displayDialog(context: context, text: 'Email Field Should Not Be Empty');
                            } else if (_pass.isEmpty) {
                              displayDialog(context: context, text: 'Password Field Should Not Be Empty');
                            } else {
                              attemptLogIn(_email, _pass);
                            }
                          },
                        ),
                  SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: Center(
                      child: Text(
                        'Dont have an account? Sign Up',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
