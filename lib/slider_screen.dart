// import 'dart:async';
// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_novel_flex/UserAuthScreen/login_screen.dart';
// import 'package:flutter_novel_flex/tab_screen.dart';
//
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
// import 'Utils/Colors.dart';
// import 'Utils/Constants.dart';
//
// class SliderScreen extends StatefulWidget {
//   const SliderScreen({Key? key}) : super(key: key);
//
//   @override
//   _SliderScreenState createState() => _SliderScreenState();
// }
//
// class _SliderScreenState extends State<SliderScreen> {
//   final controller = PageController();
//   int _currentPage = 0;
//   Timer? _timer;
//   final PageController _pageController = PageController(
//     initialPage: 0,
//   );
//
//   int imageofTheDay=0;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
//       if (_currentPage < 2) {
//         _currentPage++;
//       } else {
//         _currentPage = 0;
//       }
//
//       _pageController.animateToPage(
//         _currentPage,
//         duration: const Duration(milliseconds: 350),
//         curve: Curves.easeIn,
//       );
//     });
//   }
//
//
//   @override
//   void dispose() {
//     super.dispose();
//     _timer?.cancel();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Column(
//         children: [
//           textMain(height),
//           Expanded(child: buildPages()),
//           buildIndicator(),
//           SizedBox(
//             height: height * 0.05,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               MaterialButton(
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => const LoginScreen()));
//                 },
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10)),
//                 color: Colors.black12,
//                 elevation: 0.0,
//                 child: const Text(
//                   'Skip',
//                   style: TextStyle(
//                       fontFamily: Constants.fontfamily,
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF256D85),
//                 ),
//               ),),
//               SizedBox(
//                 width: width * 0.05,
//               )
//             ],
//           ),
//           SizedBox(
//             height: height * 0.1,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget textMain(double height) {
//     return Container(
//       margin: EdgeInsets.only(top: height * 0.1),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               Text(
//                 "Catch",
//                 style: TextStyle(
//                     color: Color(0xFF256D85),
//                     fontSize: 30.0,
//                     fontWeight: FontWeight.w800,
//                     fontFamily: Constants.fontfamily),
//               ),
//               SizedBox(
//                 width: 10.0,
//               ),
//               Text(
//                 "Your",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 30.0,
//                     fontWeight: FontWeight.w800,
//                     fontFamily: Constants.fontfamily),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               Text(
//                 ' Favourite',
//                 style: TextStyle(
//                     color: Color(0xFF256D85),
//                     fontSize: 30.0,
//                     fontWeight: FontWeight.w800,
//                     fontFamily: Constants.fontfamily),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(
//                 width: 10.0,
//               ),
//               Text(
//                 'Book!',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 30.0,
//                     fontWeight: FontWeight.w800,
//                     fontFamily: Constants.fontfamily),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildPages() {
//     return PageView(
//       controller: _pageController,
//       //controller: controller,
//       children: [
//         onboardPageView(
//           const AssetImage('assets/Elon_musk_fie_screen_image.png'),
//           '''Challenge yourself towards your future Dream!''',
//         ),
//         onboardPageView(
//             const AssetImage(
//                 'assets/quotes_data/Gold/AlbertEinstein/Albert Einstein Profile.jpg'),
//             'Make Life By yourSelf!'),
//         onboardPageView(
//             const AssetImage(
//                 'assets/quotes_data/Gold/BruceLee/BruceLeeProfile.jpg'),
//             'Your attitude is more important than your capabilities!'),
//       ],
//     );
//   }
//
//   Widget onboardPageView(ImageProvider imageProvider, String text) {
//     return Padding(
//       padding: const EdgeInsets.all(40),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image(
//                 fit: BoxFit.cover,
//                 image: imageProvider,
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             text,
//             style: const TextStyle(fontSize: 20),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 16),
//         ],
//       ),
//     );
//   }
//
//   Widget buildIndicator() {
//     return SmoothPageIndicator(
//       controller: _pageController,
//       //controller: controller,
//       count: 3,
//       effect: const WormEffect(activeDotColor: Color(0xFF256D85)),
//     );
//   }
// }
//
