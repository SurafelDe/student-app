import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../controller/image_picker_page_controller.dart';
import '../view/button.dart';

class ImagePickerPage extends StatelessWidget {
  ImagePickerPageController _controller = Get.put(ImagePickerPageController());

  ImagePickerPage(PickedFile? _imageFile,bool isProfilePicture, UploadImageCallback callback) {
    _controller.imageFile = _imageFile;
    _controller.isProfilePicture = isProfilePicture;
    _controller.callback = callback;
  }


  @override
  Widget build(BuildContext context) {

    return GetBuilder<ImagePickerPageController>(
        builder: (controller) =>
            Scaffold(
                appBar: AppBar(
                  title: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Text(
                      'Upload image',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                  ),
                  leading: InkWell(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.arrow_back_sharp,
                        color: Colors.black,
                      )),
                  elevation: 0,
                  backgroundColor: Colors.white,
                  shadowColor: Colors.grey[200],
                  automaticallyImplyLeading: false,
                  actionsIconTheme: IconThemeData(color: Colors.white),
                ),
                body:
                Container(
                  color: Colors.black,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20,),
                          child: Image.file(File(controller.imageFile!.path),height: 400, width: 400,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(15,30,15,10),
                          child: Button(
                            onPressed: () async {
                              controller.uploadProfilePicture();
                            },

                            text: 'Upload',
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: SecondaryButton(
                            onPressed: () async {
                              controller.pickImage();
                            },
                            height: 40,
                            text: 'Change',
                          ),
                        ),
                      ],
                    ),
                  ),
                )

            ));
  }
}

