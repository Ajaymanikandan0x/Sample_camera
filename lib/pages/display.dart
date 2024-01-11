import 'dart:io';

import 'package:camera_test/db/Model.dart';
import 'package:camera_test/db/functions.dart';
import 'package:flutter/material.dart';

class Photos extends StatefulWidget {
  const Photos({super.key});

  @override
  State<Photos> createState() => _DisplayState();
}

class _DisplayState extends State<Photos> {
  List gridItems = [];
  @override
  void initState() {
    super.initState();
    loadImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Albums"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 1),
          itemCount: gridItems.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () async{
                final id = gridItems[index].id;
                await loadImages();
                showAlert(context, id);

              },
              child: SizedBox(
                width: 70,
                height: 60,
                child:
                    // Container(
                    //   height: 40,
                    //   width: 50,
                    //   color: Colors.red,
                    // )
                    Image.file(File(gridItems[index].img!),fit: BoxFit.cover),
              ),
            );
          },
        ),
      ),
      backgroundColor: const Color.fromRGBO(241, 228, 195, 1),
    );
  }

  Future<void> loadImages() async {
    try {
      List<Model> images = await getimg();
      print('Database Data: $images');
      setState(() {
        gridItems = images;
      });
    } catch (e) {
      print('Error loading images: $e');
    }
  }

  void showAlert(BuildContext context, var id) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Delete',
            style: TextStyle(color: Colors.red),
          ),
          content: const Text('Do you want to delete'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                print('Deleting record with ID: $id');
                await delete(id);
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      );
}
