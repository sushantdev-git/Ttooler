import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;
import 'package:provider/provider.dart';
import 'package:ttooler/modals/userInfo.dart';
import 'package:ttooler/pageRoutebuilder/customPageRouteBuilder.dart';
import 'package:ttooler/pages/splashPage.dart';
import 'dart:convert';
import 'package:image/image.dart' as ImageProcess;

class EnterDetailPage extends StatefulWidget {
  const EnterDetailPage({Key? key}) : super(key: key);

  @override
  _EnterDetailPageState createState() => _EnterDetailPageState();
}

class _EnterDetailPageState extends State<EnterDetailPage> {
  File? _selectedImage;
  String name = "";
  String ? base64Image ;

  final _formKey = GlobalKey<FormState>();
  Future<void> _pickImage() async {
    final picker =
        ImagePicker(); //here we are using an external package ImagePicker
    //which will help us to capture image.
    var imageFile =
        await picker.pickImage(source: ImageSource.gallery, maxWidth: 600);
    //through ImagePicker object we catch call pickImage method which will return an XFile
    //in pickImage method we have to provide a source from where we want to fetch image, camera or gallery..

    if (imageFile == null) {
      return; //if imageFile is null return
      //we don't have to do anything if image is null
    }

    File file = File(imageFile.path);

    final _imageFile = ImageProcess.decodeImage(
      file.readAsBytesSync(),
    );

    base64Image = base64Encode(ImageProcess.encodePng(_imageFile!));

    setState(() {
      _selectedImage = File(imageFile.path);
      //storing the fetch image to storeImage variable
    });

    final appDir = await sysPath.getApplicationDocumentsDirectory(); //now here we are also using an external package
    //which provider us systemPaths where we can store our image temporarily
    final fileName = path.basename(imageFile
        .path); //here to get filename that is create by imagePicker we can use another package
    //which is path which can provider us name of image #basename provider the string after last / in address of imageFile.
    final savedImage =
        await File(imageFile.path).copy("${appDir.path}/$fileName");
    //now storing our image to system path that is provided by sysPath package and storing our image there temporarily
    //calling selectImage method that is present in add Place screen to save this image address that can be further
    //used in great_place to create an Place object.
  }

  Future<void> saveImageAndName() async {
    await Provider.of<UserInfo>(context, listen: false).addUserData(name, base64Image!);
  }


  Future<void> validation() async {
    if (_formKey.currentState!.validate()) {
      if (base64Image != null) {
        await saveImageAndName();
        Navigator.of(context)
            .pushReplacement(CustomPageRouteBuilder(enterPage: SplashPage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please choose a profile photo"),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowGlow();
            return false;
          },
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
              margin: EdgeInsets.only(top:100),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/illustration/others.png",
                      height: 150,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).backgroundColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _pickImage();
                                  },
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).accentColor,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    clipBehavior: Clip.antiAlias,
                                    child: Center(
                                      child: _selectedImage == null
                                          ? Icon(Icons.add_a_photo_outlined)
                                          : Image.file(
                                              //with image.file we can load image from device
                                              _selectedImage!,
                                              fit: BoxFit.cover,
                                              width: 100,
                                              height: 100,
                                            ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Choose a profile photo"),
                              ],
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Name",
                                labelStyle: TextStyle(color: Colors.white),
                                hintText: "Enter Your first Name",
                                hintStyle: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w100,
                                ),
                                errorStyle: TextStyle(
                                  color: Colors.white54,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              keyboardType: TextInputType.name,
                              cursorColor: Colors.white60,
                              maxLines: null,
                              validator: (value) {
                                if (value == null) {
                                  return "Enter Title";
                                }
                                if (value.trim().length <= 3) {
                                  return "Name length must be 4";
                                }
                                return null;
                              },
                              onChanged: (val) {
                                name = val;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(width: 1, color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        tapTargetSize: MaterialTapTargetSize.padded,
                      ),
                      onPressed: () {
                        validation();
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 5, left: 50, right: 50, bottom: 5),
                        child: Text(
                          "Done",
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
