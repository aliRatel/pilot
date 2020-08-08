import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pilot/presentation/pages/login/login_page.dart';
import 'package:pilot/presentation/pages/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:pilot/presentation/providers/selected_radio_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RadioProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'pilot',
        theme: ThemeData(
          // this to change the field border color
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green)
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green)
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
  bool isLoading= true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 20),(){
      setState(() {
        isLoading=false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return isLoading? SplashPage(): LoginPage();
  }
}

