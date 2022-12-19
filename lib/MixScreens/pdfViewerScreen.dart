
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import '../Utils/Constants.dart';

class PdfScreen extends StatefulWidget {
  String? url;
  String? name;
  PdfScreen({required this.url, required this.name});

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _height * 0.07,
        elevation: 0.0,
        backgroundColor: const Color(0xFF256D85),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 35,
            color: Colors.white,
          ),
        ),
        actions: [
          SizedBox(
            width: _width * 0.0,
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: _height * 0.02,
                ),
                Text(
                  widget.name!,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,fontFamily: Constants.fontfamily,),
                )
              ],
            ),
          ),
          // SizedBox(
          //   child: IconButton(
          //     onPressed: () {
          //       Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadDataScreen()));
          //     },
          //     icon: Icon(
          //       Icons.add,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
        ],
      ),
      body: Container(
          child: const PDF(
            fitEachPage: true,
            pageSnap: true,
            enableSwipe: true,
            pageFling: true
          ).cachedFromUrl(
        widget.url!,
        maxAgeCacheObject: const Duration(days: 10), //duration of cache
        placeholder: (progress) => Center(
          child: Container(
            height: _height*0.1,
            width: _width*0.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black12
            ),
            child: Center(
              child: Text('$progress %',style: const TextStyle(
                color:Color(0xFF256D85),
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
                fontFamily: Constants.fontfamily,
              ),),
            ),
          ),
        ),
        errorWidget: (error) => Center(child: Text(error.toString())),
      )),
    );
  }
}
