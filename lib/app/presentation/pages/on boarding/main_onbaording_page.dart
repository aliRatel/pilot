import 'package:flutter/material.dart';
import 'package:pilot/app/presentation/pages/on%20boarding/sliderPage.dart';


class onBoarding extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return onBoardingPage();
  }
}

class onBoardingPage extends State<onBoarding>{

  int _currentpage = 0;
  PageController _controller = PageController(
    initialPage: 0,
  );


  List <Widget> _pages = [
    sliderPage(
      image: "assets/images/1.png",
      description: "it’s avaliable in your favourite cities \n now \n and they wait! go and order four \n favourite juices it’s avaliable in your \n favourite cities now",
    ),

    sliderPage(
      image: "assets/images/2.png",
      description: "it’s avaliable in your favourite cities \n now \n and they wait! go and order four \n favourite juices it’s avaliable in your \n favourite cities now",
    ),

    sliderPage(
      image: "assets/images/3.png",
      description: "it’s avaliable in your favourite cities \n now \n and they wait! go and order four \n favourite juices it’s avaliable in your \n favourite cities now",
    ),
  ];



  _onChanged(int index){
    setState(() {
      _currentpage =index;  // try run again from first ok wait please done  done thanks more
      // ta
    });
  }


  @override
  Widget build(BuildContext context) {
    var pagesNumbers = _pages.length;
    // TODO: implement build
     return Scaffold(
       body: Stack(
         children: [
          PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: _controller,
            itemCount: pagesNumbers,
            onPageChanged: _onChanged,
            itemBuilder: (context , int index){
              return _pages[_currentpage];
            },
          ),



           Column(
             mainAxisAlignment: MainAxisAlignment.end,
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children:List<Widget>.generate(pagesNumbers, (int index){
                   return AnimatedContainer(
                     height: 10,
                     width: 30,
                     margin: EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                     duration: Duration(milliseconds: 300),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(5),
                       color: (index == _currentpage) ?
                           Colors.blue : Colors.blue.withOpacity(.5),
                     ),
                   );
                 }),
               ),
               InkWell(
                 onTap: (){
                   _controller.nextPage(
                       duration: Duration(milliseconds: 800), curve:  Curves.easeInOutQuint);
                 },
                 child: AnimatedContainer(
                   duration: Duration(milliseconds: 300),
                   height: 50,
                   alignment: Alignment.center,
                   width: (MediaQuery.of(context).size.width)*.9,
                   decoration: BoxDecoration(
                     color: (_currentpage == pagesNumbers-1)? Colors.blue : Colors.white,
                     borderRadius: BorderRadius.circular(10),
                   ),
                   child: (_currentpage == pagesNumbers-1)?
                       Text(" Sign up with email"):
                       Text("Skip")
                 ),
               ),

             SizedBox(height: 50,),

             ],
           )








                   ],
       ),
     );
  }



}


