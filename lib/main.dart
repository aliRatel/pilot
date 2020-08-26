import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pilot/app/presentation/pages/LoadingPage.dart';
import 'package:pilot/app/presentation/pages/job_companies_dashboard/job_companies_dashboard.dart';
import 'package:pilot/app/presentation/pages/on_boarding/main_onbaording_page.dart';
import 'package:pilot/app/presentation/pages/search_screen/search_page.dart';
import 'package:pilot/app/presentation/providers/user_provider.dart';
import 'package:pilot/app/presentation/providers/login_provider.dart';
import 'package:provider/provider.dart';
import 'app/presentation/pages/Job_seeker_dashboard/job_seeker_dashboard.dart';
import 'app/presentation/providers/add_job_provider.dart';
import 'app/presentation/providers/company_dashBoard_provider.dart';
import 'app/presentation/providers/complete_JobSeeker_registration_provider.dart';
import 'app/presentation/providers/complete_company_registration_provider.dart';
import 'app/presentation/providers/gender_radio_button.dart';
import 'app/presentation/providers/jobSeeker_dashBoardProvider.dart';
import 'app/presentation/providers/location_provider.dart';
import 'app/presentation/providers/search_page_provider.dart';
import 'app/presentation/providers/selected_radio_button.dart';
import 'app/presentation/providers/signup_provider.dart';
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
          create: (_) => sl<AddJobProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<CompanyDashBoardProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<JobSeekerDashBoardProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<LocationProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<SearchPageProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<UserProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<CompleteCompanyRegistrationProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<CompleteJobSeekerRegistrationProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<LogInProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<SignUpProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => TypeRadioProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => GenderRadioProvider(),
        ),
      ], //wait please ok
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
//    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
////      Provider.of<LocationProvider>(context,listen: false).getCountries().then((value) {
////        super.initState();
////      });
////    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    ScreenUtil.init(
      context,
      width: width,
      height: height,
      allowFontScaling: true,
    );
    return SearchPage();
  }
}
