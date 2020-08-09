import 'package:flutter/material.dart';

getJobList(double width, double height) {
  return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: width / 50),
          height: height / 9,
          child: Card(
            shadowColor: Colors.grey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 50),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: width / 15,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width / 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('UI/UX Designer',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text('Company name -',
                                  style: TextStyle(color: Colors.grey)),
                              Text('Full time',
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ]),
                  ),
                  Spacer(),
                  Text('500Le'),
                ],
              ),
            ),
          ),
        );
      });
}
