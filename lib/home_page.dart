import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  File? photo;
  final ImagePicker picker = ImagePicker();

  //bottom sheet dialog for select gallery or camera
  void showPickerDialog(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }


  //for taking image from gallery
  Future imgFromGallery() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1200,
        maxWidth: 1200,
        imageQuality: 100);

    setState(() {
      if (pickedFile != null) {
        photo = File(pickedFile.path);

      } else {
        log('no_image_selected');
      }
    });
  }


  //for taking image from camera
  Future imgFromCamera() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 1200,
        maxWidth: 1200,
        imageQuality: 100);

    setState(() {
      if (pickedFile != null) {
        photo = File(pickedFile.path);

      } else {
        log('no_image_selected');
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Camera Example",style: TextStyle(
          color: Colors.white
        ),),
      ),
      body: Column(
        children: [

          photo != null
              ? Image.file(
            photo!,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height/2,
            fit: BoxFit.fitWidth,
          )
              : Image.asset("assets/images/image_placeholder.jpg",
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height/2,
              fit: BoxFit.fitWidth),



          SizedBox(height: 20,),


          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              showPickerDialog(context);
            },
            child: const Text("Pick Image",style: TextStyle(
              color: Colors.white
            ),),
          ),

        ],
      ),
    );
  }
}
