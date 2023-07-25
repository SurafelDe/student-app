
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../util/message.dart';

typedef void UploadImageCallback(String status);

class ImagePickerPageController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  late UploadImageCallback callback;
  // RequiredDocRegistrationRequest requiredDocInfo = RequiredDocRegistrationRequest();
  bool isProfilePicture = false;

  PickedFile? imageFile;

  Future<String?> uploadProfilePicture() async {
    try{
      callback('upload');
    }
    catch(ex){
      Toast.message('uploading image failed');
    }
    return null;

  }

  void pickImage() async {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      if(pickedFile != null){
        imageFile = pickedFile;

        update();

      }

    } catch (e) {
      print("Image picker error ");
    }
  }


}