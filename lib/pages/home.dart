import 'package:camera_test/db/Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../db/functions.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  String? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camerra'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await pickImage();
      }, child: const Icon(Icons.camera_alt_outlined,size: 40,)),
      body: Align(
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/display');
          },
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              Size(80, 40),
            ),
          ),
          child: const Text('Gallery',style: TextStyle(fontSize: 19),),
        ),
      ),
      backgroundColor: const Color.fromRGBO(241, 228, 195,1),
    );
  }

  // ... imports and class structure remain the same ...

  Future pickImage() async {
    try {
      final XFile? imageIm = await ImagePicker().pickImage(source: ImageSource.camera);
      if (imageIm == null) return;

      print('${image = imageIm.path} this is the path');
      setState(() {
        image = imageIm.path;// Call load() within setState()
      });
      if(image!=null){
        try {
          final model = Model(img: image);
          await addImg(model);
          print('${image = imageIm.path} this is the path2');
        } catch (e) {
          print('Failed to add image to database: $e');
          // Handle the error as needed
        }
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

// ... load() function remains the same, but consider adding try-catch ...


}
