import 'dart:convert';

import 'package:email_auth/email_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:open_stream_mobile/constant/colors.dart';
import 'package:open_stream_mobile/constant/routes.dart';
import 'package:open_stream_mobile/constant/textStyle.dart';
import 'package:open_stream_mobile/constant/urls.dart';
import 'package:open_stream_mobile/ui/widgets/auth_page_widgets.dart';
import 'package:open_stream_mobile/ui/widgets/core_widgets.dart';
import 'package:open_stream_mobile/ui/widgets/display_dialog.dart';
import 'package:open_stream_mobile/utils/props/no_glow.dart';
import 'package:http/http.dart' as http;

class MySignupPage extends StatefulWidget {
  @override
  _MySignupPageState createState() => _MySignupPageState();
}

class _MySignupPageState extends State<MySignupPage> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  bool _isLoading = false;
  bool _obscureText = true;
  bool _hidePass = false;

  Future<int> userRegistration({String username, String firstName, String lastName, String number, String email, String password}) async {
    setState(() => _isLoading = true);

    var res = await http.post(
      Uri.https(baseUrl, userRegisterUrl),
      body: {
        "username": username,
        "email": email,
        "password": password,
        "number": number,
        "name": firstName + " " + lastName,
      },
    );
    final resCode = json.decode(res.body);
    try {
      if (res.statusCode == 200) {
        print(resCode['user']);
        print('1');
        displayDialog(context: context, title: 'Account Created', text: '$username has been create successfully');
        Navigator.pushNamed(context, SigninRoute);
      } else {
        setState(() => _isLoading = false);
        String _takenMessage = resCode['message'][0]['messages'][0]['message'];
        displayDialog(context: context, text: _takenMessage);
      }
    } catch (e) {
      print(e);
    }
    return res.statusCode;
  }

  void _toggle() {
    setState(() => _obscureText = !_obscureText);
  }

  void _passVisible() {
    setState(() => _hidePass = !_hidePass);
  }

  void otpSend() async {
    EmailAuth.sessionName = 'Test Session';
    var res = await EmailAuth.sendOtp(receiverMail: _emailController.text);
    if (res) {
      print('OTP send');
    } else {
      print('OTP Not send');
    }
  }

  void verifyOtp() {
    var res = EmailAuth.validate(userOTP: _otpController.text, receiverMail: _emailController.text);
    if (res) {
      print('OTP verify');
      _passVisible();
    } else {
      print('OTP Not verify');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kHomeBackGroundColor,
        appBar: AppBar(
          backgroundColor: kBackGroundColor,
          centerTitle: true,
          title: Text('Sign Up', style: kAppBarTextStyle),
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: ScrollConfiguration(
            behavior: NoGlowBehavior(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Please fill the form',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSerif(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Row(
                        children: [
                          Expanded(
                            child: MyTestField(
                              label: 'First Name',
                              hintText: 'First Name',
                              controller: _firstController,
                              icon: LineAwesomeIcons.user,
                            ),
                          ),
                          Expanded(
                            child: MyTestField(
                              label: 'Last Name',
                              hintText: 'Last Name',
                              controller: _lastController,
                              icon: LineAwesomeIcons.user,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  MyTestField(
                    label: 'Username',
                    icon: LineAwesomeIcons.user,
                    hintText: 'User Name',
                    controller: _usernameController,
                  ),
                  SizedBox(height: 15),
                  MyTestField(
                    label: 'Email',
                    inputType: TextInputType.emailAddress,
                    icon: LineAwesomeIcons.mail_bulk,
                    hintText: 'Email',
                    controller: _emailController,
                    suffixIcon: TextButton(
                      child: Text(
                        'Send OTP',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        if (_emailController.text.isNotEmpty) {
                          otpSend();
                          newMethod(context);
                        } else {
                          displayDialog(context: context, text: 'Email address should not be empty');
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  MyTestField(
                    label: 'Mobile',
                    hintText: 'Number',
                    inputType: TextInputType.number,
                    icon: LineAwesomeIcons.phone,
                    controller: _mobileController,
                  ),
                  SizedBox(height: 15),
                  MyTestField(
                    label: 'Password',
                    hintText: 'Password',
                    inputType: TextInputType.visiblePassword,
                    icon: LineAwesomeIcons.lock,
                    controller: _passwordController,
                    obscureText: _obscureText,
                    autocorrect: false,
                    enabled: _hidePass,
                    suffixIcon: InkWell(
                      child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off, color: Colors.black),
                      onTap: _toggle,
                    ),
                  ),
                  SizedBox(height: 25),
                  _isLoading
                      ? MyProgressBar()
                      : MyAuthButtonWidget(
                          label: 'Sign Up',
                          color: Color(0xffBE1ACF),
                          width: 150,
                          onTapped: () async {
                            var username = _usernameController.text.trim();
                            var firstName = _firstController.text.trim();
                            var lastName = _lastController.text.trim();
                            var mobile = _mobileController.text.trim();
                            var email = _emailController.text.trim();
                            var pass = _passwordController.text.trim();

                            if (firstName.length == 0) {
                              displayDialog(context: context, title: 'Invalid First Name', text: 'The First Name should be required');
                              setState(() => _isLoading = false);
                            } else if (lastName.length == 0) {
                              displayDialog(context: context, title: 'Invalid Last Name', text: 'The Last Name should be required');
                              setState(() => _isLoading = false);
                            } else if (mobile.length != 10) {
                              displayDialog(context: context, title: 'Invalid Mobile Number', text: 'The Mobile Number should be required');
                              setState(() => _isLoading = false);
                            } else if (username.length < 4) {
                              displayDialog(context: context, title: 'Invalid Username', text: 'The username should be atleast 4 characters long');
                              setState(() => _isLoading = false);
                            } else if (pass.length < 6) {
                              displayDialog(context: context, title: 'Invalid Password', text: 'The password should be atleast 6 characters long');
                              setState(() => _isLoading = false);
                            } else {
                              userRegistration(
                                  firstName: firstName, lastName: lastName, username: username, email: email, number: mobile, password: pass);
                            }
                          },
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future newMethod(BuildContext context) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) => Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              color: kHomeBackGroundColor,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Enter Your OTP',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: MyTestField(
                        controller: _otpController,
                        inputType: TextInputType.number,
                        hintText: 'Enter OTP',
                        label: '',
                        icon: LineAwesomeIcons.inbox,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: MyAuthButtonWidget(
                        label: 'Check',
                        color: Colors.blue[500],
                        width: 200,
                        onTapped: () {
                          verifyOtp();
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
