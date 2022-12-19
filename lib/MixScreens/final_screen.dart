import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/reusable_button.dart';

class MyFileUploadScreen extends StatefulWidget {
  const MyFileUploadScreen({Key? key}) : super(key: key);

  @override
  State<MyFileUploadScreen> createState() => _MyFileUploadScreenState();
}

class _MyFileUploadScreenState extends State<MyFileUploadScreen> {
  // var documentPath;
  // var documentName;
  // PlatformFile? myDoc;
  // Future<void> _retrieveName() async {
  //   final prefs = await SharedPreferences.getInstance();
  //
  //   // Check where the name is saved before or not
  //   if (!prefs.containsKey('name')) {
  //     return;
  //   }
  //
  //   setState(() {
  //     documentName = prefs.getString('name');
  //     // log("Index number is: ${pathImage.toString()}");
  //   });
  // }
  //
  // Future<void> _retrievePath() async {
  //   final prefs = await SharedPreferences.getInstance();
  //
  //   // Check where the name is saved before or not
  //   if (!prefs.containsKey('doc_path')) {
  //     return;
  //   }
  //
  //   setState(() {
  //     documentPath = prefs.getString('doc_path');
  //     log("Index number is: ${documentPath.toString()}");
  //   });
  // }
  //
  // Future<void> _saveName(var _pathFine) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     prefs.setString('name', _pathFine);
  //   });
  // }
  //
  // Future<void> _savePath(var _pathFine) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     prefs.setString('doc_path', _pathFine);
  //   });
  // }
  //
  // Future<void> _clearName() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   // Check where the name is saved before or not
  //   if (!prefs.containsKey('name')) {
  //     return;
  //   }
  //
  //   await prefs.remove('name');
  //   setState(() {
  //     documentName = null;
  //   });
  // }
  //
  // Future<void> _clearPath() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   // Check where the name is saved before or not
  //   if (!prefs.containsKey('doc_path')) {
  //     return;
  //   }
  //
  //   await prefs.remove('doc_path');
  //   setState(() {
  //     documentPath = null;
  //   });
  // }



  List<File>? files;
  int fileLength = 0;



  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _height * 0.07,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 35,
            color: Colors.black54,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.5, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    color: Colors.white),
                width: _width * 0.95,
                height: _height * 0.08,
                margin: EdgeInsets.only(
                    left: _width * 0.02,
                    right: _width * 0.02,
                    top: _height * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SizedBox(
                    //   width: _width * 0.04,
                    //   height: _height * 0.07,
                    // ),
                    fileLength == 0
                        ? const Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text('Selected Book',
                                  style: TextStyle(color: Colors.black54)),
                            ),
                          )
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                '$fileLength Files are Selected',
                                style: const TextStyle(color: Colors.black54,
                                  fontSize: 18,fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                    // SizedBox(
                    //   width: _width * 0.35,
                    // ),
                    IconButton(
                        onPressed: () {
                          getPdfAndUpload();
                        },
                        icon: const Icon(Icons.file_upload_outlined)),
                  ],
                ),
              ),
              SizedBox(
                height: _height*0.5,
              ),
              Container(
                alignment: Alignment.center,
                height: _height*0.08,
                width: _width*0.95,
                child:  ResuableMaterialButton(onpress: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyFileUploadScreen()));
                }, buttonname: 'Uploads',),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getPdfAndUpload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx', 'doc', 'odt'],
        allowMultiple: true);

    if (result != null) {
      files = result.paths.map((path) => File(path!)).toList();
      setState(() {
        fileLength = files!.length;
      });
    } else {
      // User canceled the picker
    }

    // FilePickerResult? file = await FilePicker.platform.pickFiles(
    //   type: FileType.custom,
    //   allowedExtensions: ['pdf','docx','doc','odt'],
    //   allowMultiple: true,
    // );

    // if(file != null) {
    //   myDoc = file.files.first;
    //   // fileName = file.files.first.name;
    //
    //   print(myDoc!.name);
    //   print(myDoc!.bytes);
    //   print(myDoc!.size);
    //   print(myDoc!.extension);
    //   print(myDoc!.path);
    //   setState(() {
    //
    //     // myDocA = file.files.first.name;
    //     _savePath(myDoc!.path);
    //     _saveName(myDoc!.name);
    //     _retrievePath();
    //     _retrieveName();
    //
    //   });
    // } else {
    //   // User canceled the picker
    // }
  }

}
