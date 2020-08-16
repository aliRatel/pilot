import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pilot/app/presentation/pages/login/login_page.dart';
import 'package:pilot/app/presentation/pages/register_pages/base_register_page.dart';
import 'package:pilot/app/presentation/providers/basic_user_provider.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) => func(context));

    return Scaffold(body: Center(child: CircularProgressIndicator(),),);
  }
}

func(BuildContext context) {
  Provider.of<UserProvider>(context,listen: false).checkForUsers();
  if(Provider.of<UserProvider>(context,listen: false).userState=='hasUser'){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
  }
}
