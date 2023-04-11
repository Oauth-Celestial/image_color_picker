import 'package:flutter/material.dart';
import 'package:image_color_picker/image_color_picker.dart';

class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  String _hexColor = '';
  Image image = Image.asset("assets/b.jpg");
  Color? color;

  var x = 50;
  var y = 25;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          ColorPicker(
              child: image,
              onChanged: (color) {
                setState(() {
                  this.color = color;
                  print("test");
                  // print("${color.value.}")
                });
              }),
          Container(
            width: 40,
            height: 40,
            color: color,
          )
        ],
      )

    
          ),
    );
  }
}
