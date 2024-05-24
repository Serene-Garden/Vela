# Vela
A Color Picker for watchOS

![:name](https://counter.seku.su/cmoe?name=Garden785-Vela&theme=r34)

I believe that SwiftUI team could definetly sketch and make a color picker for watchOS.

But thet just didn't.

So I had to make a color picker by my own, in order to select a color on Watch.

## Features
- Select Color in List
- Adjust Color in Sliders
  - Supports RGB & HSB
  - Supports Opacity Edit
- Check Color Details
  - Hex Code
  - Opacity
  - RGB & HSB Values
  - *CMYK Values (only for reference)*
 
## Parameters
```swift
VelaPicker(color: $color, allowOpacity: true, label: {
    Text("Vela")
})
```
### color
`color: Binding<Color>` determine what is the color.

### allowOpacity
`allowOpacity: Bool` shows if the opacity value is allowed to be seen and changed.

Default as `true`.

### label
`label: () -> L` recieves a view for the picker's label.

Default as `Text("Vela")`

## Requirements
### Declarement
You are responsible for adding the following description to your app, where ever it is as long as it could be found.

> Powered by Vela

If Vela is unable to be enabled, such as in watchOS 9, then this text could be removed.


## Credits
**ThreeManager785**
- Design
- Develop
- Acknowlegements Learning
- Almost Everything, I think

## Privacy
Vela collects literally nothing.

It only stores 2 setting values.

No data are shared or uploaded to neither other devices nor the Internet.

Vela won't be able to know what color you've inputted.
