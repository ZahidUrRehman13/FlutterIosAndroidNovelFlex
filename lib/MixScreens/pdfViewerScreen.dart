
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:pdf_render/pdf_render_widgets.dart';
import 'dart:io';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../Utils/Constants.dart';
import '../localization/Language/languages.dart';

class PdfScreen extends StatefulWidget {
  String? url;
  String? name;
  PdfScreen({required this.url, required this.name});

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  bool _isLoading = true;
  late PDFDocument _pdf;

  // final controller = PdfViewerController();
  TapDownDetails? _doubleTapDetails;

  void _loadFile() async {
    // Load the pdf file from the internet
    _pdf = await PDFDocument.fromURL(
        widget.url!);

    setState(() {
      _isLoading = false;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _loadFile();
  // }
  late PdfViewerController _pdfViewerController;
  TextEditingController? _controller;
  final controller = ScrollController();

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    _controller= TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery
        .of(context)
        .size
        .height;
    var _width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: const Color(0xffebf5f9),
      // appBar: AppBar(
      //   title: Text(widget.name!),
      //   backgroundColor: Colors.white,
      // ),

      body: SafeArea(
        child: Stack(
          children: [
            SfPdfViewer.network(
              widget.url!,
              canShowPaginationDialog: true,
              controller: _pdfViewerController,
            ),
            Positioned(
                top: _height * 0.9,
                left: _width*0.1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.transparent,
                  ),
                  width: _width*0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: _width*_height*0.0001,
                          color: Color(0xFF256D85),
                        ),
                        onPressed: () {
                          _pdfViewerController.previousPage();
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          size: _width*_height*0.0001,
                          color: Color(0xFF256D85),
                        ),
                        onPressed: () {
                          _displayTextInputDialog(context);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: _width*_height*0.0001,
                          color: Color(0xFF256D85),
                        ),
                        onPressed: () {
                          _pdfViewerController.nextPage();
                        },
                      ),
                    ],

                  ),
                ))
          ],
        ),
      ),

    );
  }


  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            ),
            title: Text('Search by Page Number'),
            content: TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: "eg 23"),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Color(0xFF256D85),
                textColor: const Color(0xffebf5f9),
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    _pdfViewerController.jumpToPage(int.parse(_controller!.text.toString()));
                    _controller!.clear();
                    Navigator.pop(context);
                  });
                },
              ),
              MaterialButton(
                textColor: const Color(0xffebf5f9),
                color: Color(0xFF256D85),
                child: Text('Cancel'),
                onPressed: () {
                  setState(() {
                    _controller!.clear();
                    Navigator.pop(context);
                  });
                },
              ),

            ],
          );
        });
  }
}
