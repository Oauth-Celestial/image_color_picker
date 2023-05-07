#  Pick_Color

Pick_Color allows you to sample specific colors from an image and obtain their hex color code by just dragging over the image area.

![pick_color](https://user-images.githubusercontent.com/119127289/236672640-a16c8012-9d5c-4cdf-8a7d-6ad0ab63b552.png)


# Add Dependency
```
pick_color : any
```


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


That's all it takes 😃

Feel Free to contribute or file an issue happy coding.