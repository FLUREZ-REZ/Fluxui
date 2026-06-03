import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o3d/o3d.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyMagazineScreen extends StatefulWidget {
  const MyMagazineScreen({super.key});

  @override
  State<MyMagazineScreen> createState() => _MyMagazineScreenState();
}

class _MyMagazineScreenState extends State<MyMagazineScreen> {
  final O3DController odcontroller = O3DController();
  final PageController pagecontroller = PageController();

  final List<MyProfile> models = [
    MyProfile(
      "Explore / Dream / Discover / Enjoy",
      "Think about what you Dream ,he found U",
    ),
    MyProfile(
      "Luxury Performance",
      "Experience power and elegance in motion",
    ),
    MyProfile(
      "Feel The Speed",
      "Built for drivers who seek excitement",
    ),
    MyProfile(
      "Future Vision",
      "Technology meets automotive perfection",
    ),
  ];

  void _changeCamera(int page) {
    switch (page) {
      case 0:
        odcontroller.cameraOrbit(0, 90, 70);
        break;

      case 1:
        odcontroller.cameraOrbit(180, 90, 70);
        break;

      case 2:
        odcontroller.cameraOrbit(140, 90, 30);
        break;

      case 3:
        odcontroller.cameraOrbit(220, 90, 30);
        break;
    }
  }




  @override
  void dispose() {
    pagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.grey.shade700,
              Colors.white,
            ],
          ),
        ),
        child: Stack(
          children: [

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 430.h,
                child: O3D.asset(
                  src: "assets/dodge.glb",
                  controller: odcontroller,
                  cameraOrbit: CameraOrbit(0, 90, 2),
                  interactionPrompt: InteractionPrompt.none,
                ),
              ),
            ),


            Positioned.fill(
              top: 70.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: PageView.builder(
                  controller: pagecontroller,
                  onPageChanged: _changeCamera,
                  itemCount: models.length,
                  itemBuilder: (context, index) {
                    return SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            models[index].title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 34.sp,
                              fontWeight: FontWeight.bold,
                              height: 1.15,
                            ),
                          ),

                          SizedBox(height: 20.h),

                          SizedBox(
                            width: 0.8.sw,
                            child: Text(
                              models[index].description,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18.sp,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),


            Positioned(
              bottom: 30.h,
              left: 25.w,
              right: 25.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: pagecontroller,
                    count: models.length,
                    effect: ExpandingDotsEffect(
                      spacing: 8.w,
                      radius: 5.r,
                      dotWidth: 8.w,
                      dotHeight: 8.h,
                      strokeWidth: 1.5,
                      dotColor: Colors.black12,
                      activeDotColor: Colors.black,
                    ),
                  ),

                  Row(
                    children: [
                      Text(
                        "Explore",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(width: 15.w),

                      SizedBox(
                        width: 55.w,
                        height: 55.w,
                        child: FloatingActionButton(
                          elevation: 3,
                          backgroundColor: Colors.white,
                          onPressed: () {
                            final currentPage =
                                pagecontroller.page?.round() ?? 0;

                            if (currentPage < models.length - 1) {
                              pagecontroller.animateToPage(
                                currentPage + 1,
                                duration:
                                const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          child: Icon(
                            Icons.arrow_forward_ios_sharp,
                            size: 20.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyProfile {
  String title;
  String description;

  MyProfile(this.title, this.description);
}