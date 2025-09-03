import 'package:flutter/material.dart';
import '../models/image.dart';

class ImageList extends StatelessWidget{
  final List<ImageModel> images;

  ImageList(this.images);

  Widget build(context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, int index) {
        return buildImage(images[index]);
      },
    );
  }

  Widget buildImage(ImageModel image) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black)
        ),
        // margin: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 0.0),
        padding: EdgeInsets.all(2.0),
        child: Column(
          children: <Widget>[
            Image.network(image.url),
            Text(image.description)
          ]
          ),
      );
  }
}