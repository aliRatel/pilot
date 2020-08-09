import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pilot/presentation/widgets/app_bar.dart';
import 'search_button.dart';
import 'search_fields.dart';
import 'jobs_list.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: getAppBar('Search', width),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: width / 20, vertical: height / 15),
            child: Column(
              children: [
                getSearchField('Enter your job title'),
                Padding(
                    padding: EdgeInsets.only(top: height / 50),
                    child: getSearchField('Enter your location')),
                getSearchButton(height, width)
              ],
            ),
          ),
          Expanded(child: getJobList(width, height)),
        ],
      ),
    );
  }
}
