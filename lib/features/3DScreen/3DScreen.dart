import 'package:flutter/material.dart';
import 'package:o3d/o3d.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyMagazineScreen extends StatelessWidget {
   MyMagazineScreen({super.key});

  O3DController odcontroller = O3DController();
  PageController pagecontroller = PageController();
  final List<MyProfile> models =[
    MyProfile("Explore / Dream / Discover / Enjoy", "Think about what you Dream ,he found U "),
    MyProfile("page2", "page2 description"),
    MyProfile("page3", "page3 description"),
    MyProfile("page4", "page4 description"),

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end:   Alignment.bottomCenter,
              colors: [
                Colors.black ,
                Colors.grey.shade700 ,
                Colors.white ,
              ])
        ),
        child: Stack(
          children: [
            
            Positioned(
                 bottom: 0,
                 right: 0,
                 left: 0,
                child: AspectRatio(
                    aspectRatio: 1/1 ,
                  child: O3D.asset(
                      src: "assets/dodge.glb" ,
                      controller: odcontroller,
                      cameraOrbit: CameraOrbit(90, 90, 100),
                  ),
                ),

            ),
            
            Positioned.fill(
                top: 70,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: PageView.builder(
                    controller: pagecontroller,
                    itemCount: models.length,
                    itemBuilder: (context , index){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(models[index].title , style: TextStyle(color: Colors.white , fontSize: 35 , height:1.1),),
                          SizedBox(height: 20,),
                          Text(models[index].description , style: TextStyle(color: Colors.white70 , fontSize: 20),)
                        ],
                      );
                    },

                  ),
                )
            ),

            Positioned(
              bottom: 30,
                right: 30,
                left: 30,
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: pagecontroller,
                  count:  models.length,
                  axisDirection: Axis.horizontal,
                  effect: ExpandingDotsEffect(
                    spacing: 8.0,
                    radius: 4.0,
                    dotWidth: 8.0 ,
                    dotHeight: 8.0 ,
                    strokeWidth: 1.5 ,
                    dotColor: Colors.black12,
                    activeDotColor: Colors.black
                  ),

                ),


                Row(
                  children: [
                    Text("Explore" , style: TextStyle(color: Colors.black , fontSize: 20),),
                    SizedBox(width: 15,),
                    FloatingActionButton(
                      backgroundColor: Colors.white,
                      onPressed: (){


                        switch(pagecontroller.page!.toInt()){

                          case 0 :
                            odcontroller  .cameraOrbit(40, 50, 30);
                            break ;
                          case 1 :
                            odcontroller  .cameraOrbit(0, 0, 3);
                            break ;
                          case 2 :
                            odcontroller  .cameraOrbit(220, 90, 30);
                            break ;



                        }

                        if(pagecontroller.page!.toInt() == models.length - 1){

                        }
                        pagecontroller.animateToPage(pagecontroller.page!.toInt() + 1, duration: Duration(milliseconds: 300), curve: Curves.easeInSine);
                    },
                    child: Icon(Icons.arrow_forward_ios_sharp),
                    )
                  ],
                )
              ],
            ))
          ],
        ),
      ),

    );
  }
}

class MyProfile {

  String title ;
  String description ;

  MyProfile(this.title , this.description);

}


