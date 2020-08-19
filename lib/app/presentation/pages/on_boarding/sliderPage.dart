import 'package:flutter/material.dart';


class SliderPage extends StatelessWidget{

  final String image;
  final String description;

  SliderPage({ this.image, this.description});

  @override
  Widget build(BuildContext context) {
     double width= MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image,width: width*.55,),
          SizedBox(height: 80,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:50.0),
            child: Text(description,
               style: TextStyle(
                 fontSize: 14,
                 fontWeight: FontWeight.normal,
                 letterSpacing: .7,
                 height: 1.5,),
              textAlign: TextAlign.center,
               ),
          ),
          SizedBox(height: 60.0,),
        ],
      ),
    );
  }



}


