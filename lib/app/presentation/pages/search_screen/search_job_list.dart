import 'package:flutter/material.dart';

import 'package:pilot/app/presentation/pages/Job_seeker_dashboard/components/job_list/job_list.dart';
import 'package:pilot/app/presentation/providers/search_page_provider.dart';
import 'package:provider/provider.dart';

class SearchJobsList extends StatefulWidget {
  const SearchJobsList(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.context})
      : super(key: key);

  final double height;
  final double width;
  final BuildContext context;

  @override
  _JobsListState createState() => _JobsListState();
}

class _JobsListState extends State<SearchJobsList> {
  ScrollController _controller;

  void initState() {
    super.initState();
    _controller = ScrollController();
//    WidgetsBinding.instance.addPostFrameCallback((_) =>
//        Provider.of<SearchPageProvider>(widget.context, listen: false)
//            .getJobs());
    //_controller.addListener(_scrollEndListener);
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<SearchPageProvider>(widget.context).loading
        ? Expanded(
            child: Container(
              child: Center(child: Text('please wait ')),
            ),
          )
        : Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount:
                  Provider.of<SearchPageProvider>(widget.context, listen: false)
                      .jobs
                      .length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (BuildContext context, int index) {
                return JobCard(
                    widget.height,
                    widget.width,
                    Provider.of<SearchPageProvider>(widget.context,
                            listen: true)
                        .jobs
                        .elementAt(index));
              },
            ),
          );
  }

  void _scrollEndListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      // Provider.of<SearchPageProvider>(widget.context, listen: false)
      //    .getJobs();
    }
  }
}
