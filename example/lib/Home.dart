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
  PickerResponse? userResponse;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          ColorPicker(
              child: image,
              onChanged: (response) {
                setState(() {
                  userResponse = response;
                  this.color = response.selectionColor;
                });
              }),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  "Selected Color  :-",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: userResponse?.selectionColor ?? Colors.red,
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(20)),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Hex Code  :- ${userResponse?.hexCode ?? ""}",
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Red :- ${userResponse?.redScale ?? ""}",
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Green  :- ${userResponse?.greenScale ?? ""}",
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Blue :- ${userResponse?.blueScale ?? ""}",
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ],
            ),
          )

          // ${userResponse?.hexCode ?? ""}
        ],
      )),
    );
  }
}
