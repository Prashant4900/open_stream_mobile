import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:open_stream_mobile/constant/routes.dart';
import 'package:open_stream_mobile/constant/string.dart';
import 'package:open_stream_mobile/ui/pages/Signup_page.dart';
import 'package:open_stream_mobile/ui/pages/detail_page.dart';
import 'package:open_stream_mobile/ui/pages/dyanmic_page.dart';
import 'package:open_stream_mobile/ui/pages/home_page.dart';
import 'package:open_stream_mobile/ui/pages/login_page.dart';
import 'package:open_stream_mobile/ui/pages/search_page.dart';
import 'package:open_stream_mobile/ui/pages/shows_page.dart';
import 'package:open_stream_mobile/ui/pages/start_page.dart';
import 'package:open_stream_mobile/ui/pages/user_page.dart';
import 'package:open_stream_mobile/utils/services/banners_provider.dart';
import 'package:open_stream_mobile/utils/services/category_provider.dart';
import 'package:open_stream_mobile/utils/services/popular_provider.dart';
import 'package:open_stream_mobile/utils/services/shows_provider.dart';
import 'package:open_stream_mobile/utils/services/users_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

var jwt;

void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() async {
  _enablePlatformOverrideForDesktop();
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  var box = await Hive.openBox(keyHiveBox);
  jwt = box.get(keyToken);

  runApp(MultiProvider(
    providers: providers,
    child: MyApp(),
  ));
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<UserProvider>(create: (BuildContext context) => UserProvider()),
  ChangeNotifierProvider<BannerProvider>(create: (BuildContext context) => BannerProvider()),
  ChangeNotifierProvider<ShowsProvider>(create: (BuildContext context) => ShowsProvider()),
  ChangeNotifierProvider<PopularProvider>(create: (BuildContext context) => PopularProvider()),
  ChangeNotifierProvider<CategoryProvider>(create: (BuildContext context) => CategoryProvider()),
];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.blue,
      ),
      initialRoute: jwt == null ? StartRoute : HomePageRoute,
      routes: {
        StartRoute: (context) => StartPage(),
        SigninRoute: (context) => MyLoginPage(),
        SignupRoute: (context) => MySignupPage(),
        HomePageRoute: (context) => MyHomePage(),
        SearchPageRoute: (context) => MySearchPage(),
        ShowsPageRoute: (context) => MyShowsPages(),
        UserPageRoute: (context) => MyUserPage(),
        DetailPageRoute: (context) => MyDetailPage(),
        DynamicPageRoute: (context) => MyDynamicPage(),
      },
    );
  }
}
