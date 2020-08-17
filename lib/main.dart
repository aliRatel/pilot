import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pilot/app/presentation/pages/login/login_page.dart';
import 'package:pilot/app/presentation/pages/register_pages/base_register_page.dart';
import 'package:pilot/app/presentation/providers/basic_user_provider.dart';
import 'package:pilot/app/presentation/providers/company_provider.dart';
import 'package:provider/provider.dart';

import 'app/presentation/pages/LoadingPage.dart';
import 'app/presentation/pages/splash_page.dart';
import 'app/presentation/providers/gender_radio_button.dart';
import 'app/presentation/providers/selected_radio_button.dart';
import 'core/util/consts.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  di.init().then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => sl<UserProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) =>sl<LogInProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => TypeRadioProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => GenderRadioProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'pilot',
        theme: ThemeData(
          // this to change the field border color
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: mainColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: mainColor),
            ),
          ),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {

    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context,
        width: width, height: height, allowFontScaling: true);
    return LoadingPage();
  }
}


