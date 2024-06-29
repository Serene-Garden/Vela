# Vela
A Color Picker for watchOS

![:name](https://counter.seku.su/cmoe?name=Garden785-Vela&theme=r34)

I believe that SwiftUI team could definetly sketch and make a color picker for watchOS.

But they just didn't.

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
VelaPicker(color: $color, defaultColor: Color.blue, allowOpacity: true, allowRGB: true, allowHSB: true, allowCMYK: true, HSB_primary: false, label: {Text("Vela")}, onSubmit: {print("Vela color submitted")})
```
### color
`color: Binding<Color>` determine what is the color.

### defaultColor
`defaultColor: Color?` allows users to reset their color to the default one

Default as `nil`

### allowOpacity
`allowOpacity: Bool` shows if the opacity value is allowed to be seen and changed.

Default as `true`

### allowRGB, allowHSB & allowCMYK
`allowRGB: Bool`, `allowHSB: Bool`, `allowCMYK: Bool` determines if the values will be shown in the details view and if it's available to be edited via sliders (except CMYK)

Default as `true`

### HSB_primary
`HSB_primary: Bool` can make HSB the primary option for checking and editing the color.

Default as `false`

### label
`label: () -> L` recieves a view for the picker's label.

Default as `Text("Vela")`

### onSubmit
`onSubmit: () -> Void` receives actions and will be run when the sheet is closed.

This works like `onSubmit` in the native SwiftUI.

Default as `{}` (runs nothing when submit)

## Requirements
### Declarement
You are responsible for adding one of the following description to your app, where ever it is as long as it could be found. Pick one below

> Powered by Vela

or

> Powered by Garden Vela

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

## Notes
I picked "Vela" from the constellation list in Wikipedia. I thought is was a good name and I added it into my note, then gave it to her (Vela).

I would never thought that Xiaomi picked Vela too. I wanna declare that Garden Vela has no connection to Xiaomi Vela, it's just a color picker.

Garden Vela doesn't make any profit, and it's just coincidence for having the same name with Xiaomi Vela. Please do not sue me, please.
