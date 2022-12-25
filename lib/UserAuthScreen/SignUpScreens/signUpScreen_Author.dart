import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../Widgets/reusable_button_small.dart';
import '../../localization/Language/languages.dart';

class SignUpAuthorScreen extends StatefulWidget {
  String name;
  String email;
  String password;
  String status;
SignUpAuthorScreen({required this.name,required this.email,required this.password,required this.status});

  @override
  State<SignUpAuthorScreen> createState() => _SignUpAuthorScreenState();
}

class _SignUpAuthorScreenState extends State<SignUpAuthorScreen> {

  final _descriptionKey = GlobalKey<FormFieldState>();
  TextEditingController? _descriptionController;
  File? imageFile;

  @override
  void initState() {
    _descriptionController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: const Color(0xffebf5f9),
      appBar: AppBar(
        toolbarHeight: _height*0.1,
        title: Text(Languages.of(context)!.signup,style: TextStyle( color: const Color(0xFF256D85),fontSize: _width*0.043),),
        centerTitle: true,
        backgroundColor:const Color(0xffebf5f9),
        elevation: 0.0,
        leading: IconButton(
            onPressed: (){

              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios,size: _height*0.03,color: Colors.black54,)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            mainText(_width),
            SizedBox(
              height: _height*0.03,
            ),
            GestureDetector(
              onTap: (){
                _getFromGallery();
              },
              child: Container(
                  width: _width*0.38,
                  height: _height*0.19,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                      color: const Color(0xffd9e7ed),

                  ),
                child: imageFile==null ? Center(
                  child: Text(
                      Languages.of(context)!.selectPicture,
                      style: const TextStyle(
                          color:  const Color(0xff3a6c83),
                          fontWeight: FontWeight.w700,
                          fontFamily: "Lato",
                          fontStyle:  FontStyle.normal,
                          fontSize: 16.0
                      ),
                ),
              ): ClipOval(
                  // clipBehavior: Clip.antiAlias,
                child: Image.file(File(imageFile!.path),
                    fit:BoxFit.cover,),
              )
              ),
            ),
            SizedBox(
              height: _height*0.03,
            ),
            Container(
              margin: EdgeInsets.only(
                  top: _height * 0.015,
                  left: _width * 0.02,
                  right: _width * 0.02),
              height: _height * 0.3,
              width: _width * 0.9,
              child: TextFormField(
                key: _descriptionKey,
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                textInputAction: TextInputAction.next,
                cursorColor: Colors.black,
                validator: validateDescription,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffd9e7ed),
                  hintText: Languages.of(context)!.bioHint,
                  hintStyle: const TextStyle(
                      color:  const Color(0xff16003b),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Arial",
                      fontStyle:  FontStyle.normal,
                      fontSize: 14.0
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 1, color: Color(0xFF256D85)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 2, color: Color(0xFF256D85)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            Container(
              width: _width * 0.9,
              height: _height * 0.06,
              margin: EdgeInsets.only(
                  top: _height*0.05
              ),
              child: ResuableMaterialButtonSmall(
                onpress: () {

                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    //     SignUpAuthorScreen()));

                },
                buttonname: Languages.of(context)!.register,
              ),
            ),

          ],
        ),
      ),
    );
  }



  Widget mainText(var width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Languages.of(context)!.letsReaderKnowYuBetter,
          style: const TextStyle(
              color:  const Color(0xff002333),
              fontWeight: FontWeight.w700,
              fontFamily: "Lato",
              fontStyle:  FontStyle.normal,
              fontSize: 20.0
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
  String? validateDescription(String? value) {
    if (value!.isEmpty)
      return 'Enter Description';
    else
      return null;
  }

  _getFromGallery() async {
    final PickedFile? image =
    await ImagePicker().getImage(source: ImageSource.gallery);

    if (image != null) {
      imageFile = File(image.path);
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      final fileName = path.basename(imageFile!.path);
      final File localImage = await imageFile!.copy('$appDocPath/$fileName');

      // prefs!.setString("image", localImage.path);

      setState(() {
        imageFile = File(image.path);
        // UploadProfileImageApi();
      });
    }
  }
}
