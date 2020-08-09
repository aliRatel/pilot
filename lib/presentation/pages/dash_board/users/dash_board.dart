import 'package:flutter/material.dart';
import 'package:pilot/presentation/widgets/app_bar.dart';
import 'search/search_page.dart';

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: getAppBar('DashBoard', width),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Search()),
          ),
          backgroundColor: Colors.green,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
