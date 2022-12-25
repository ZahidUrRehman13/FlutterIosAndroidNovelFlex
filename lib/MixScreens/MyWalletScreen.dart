import 'package:flutter/material.dart';

import '../Utils/toast.dart';
import '../localization/Language/languages.dart';

class MyWalletScreen extends StatefulWidget {
  const MyWalletScreen({Key? key}) : super(key: key);

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3fa7ca),
        elevation: 0.0,
        title: Text("${Languages.of(context)!.myWallet}",
            style: TextStyle(
              fontFamily: 'Lato',
              color: Colors.black54,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            )),
      ),
      body: Column(
        children: [
          Container(
            height: _height*0.5,
            width: _width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30)
                ),
              color: Color(0xFF3fa7ca),
            ),

            child: Column(
              children: [
                Container(
                  height: _height*0.3,
                 width: _width*0.8,
                 decoration: BoxDecoration(

                   image: DecorationImage(
                     image: AssetImage(
                       "assets/quotes_data/master_card.png"
                     ),
                   )
                 ),
                ),
                SizedBox(
                  height: _height*0.1,
                ),
                Text("Bank Account and Card"),
                Text("All financial Details will be encrypted")
              ],
            ),
          ),
          Container(
            height: _height*0.3,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 SizedBox(),
                 GestureDetector(
                   onTap: (){
                     ToastConstant.showToast(context, "You can add Payment Details when Your subscriber reached 50");
                   },
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                       width: _width*0.95,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color: Colors.black12,
                       ),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                           Container(
                             height: _height*0.1,
                             width: _width*0.15,
                             decoration: BoxDecoration(
                                 image: DecorationImage(
                                   image: AssetImage(
                                       "assets/quotes_data/visa.png"
                                   ),
                                 )
                             ),
                           ),
                           Column(
                             children: [
                               Text("Visa"),
                               Text("Credit Card")
                             ],
                           ),
                           Icon(Icons.arrow_forward_ios_outlined,color: Colors.black54,)
                         ],
                       ),
                     ),
                   ),
                 ),
                 GestureDetector(
                   onTap: (){
                     ToastConstant.showToast(context, "You can add Payment Detailswhen Your subscriber reached 50");
                   },
                   child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: _width*0.95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: _height*0.1,
                            width: _width*0.15,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/quotes_data/master-card.png"
                                  ),
                                )
                            ),
                          ),
                          Column(
                            children: [
                              Text("Visa"),
                              Text("Master Card")
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios_outlined,color: Colors.black54,)
                        ],
                      ),
                    ),
                ),
                 ),

              ],
            ),

          )
        ],
      ),

    // floatingActionButton:  FloatingActionButton(
    // onPressed: () {
    //   ToastConstant.showToast(context, "You can collect Payment when Your subscribers reached 50");
    // },
    // child: const Icon(Icons.add),
    //   backgroundColor:Color(0xFF3fa7ca),
    // ),
    //
    // floatingActionButtonLocation:
    // FloatingActionButtonLocation.centerFloat,
    );
  }
}
