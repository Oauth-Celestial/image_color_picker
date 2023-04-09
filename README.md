#  Image Color Picker

Image color picker allows you to sample specific colors from an image and obtain their hex color code by just dragging over the image area.


# Usage 

```
 Image image = Image.asset("assets/b.jpg");
 ColorPicker(
    child: image, # Your Image widget
    onChanged: (color) {
    this.color = color;             
});       
```


