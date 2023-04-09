# Example

```
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImagePickerScreen(),
    );
  }
}


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
```
