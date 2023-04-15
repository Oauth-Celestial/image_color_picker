#  Image Color Picker

Image color picker allows you to sample specific colors from an image and obtain their hex color code by just dragging over the image area.


# Usage 

```
 Image image = Image.asset("assets/b.jpg");
 ColorPicker(
    child: image, # Your Image widget
    onChanged: (response) {
        String hexcode = response.hexCode;
        // Get Selected Color
        Color color = response.selectionColor;
        // Get Red Channel Color
        int redValue = response.redScale;
        // Get Blue Channel Color
        int blueValue = response.blueScale;
        // Get Green Channel Color
        int greenValue = response.greenScale;  
                  
});       
```


