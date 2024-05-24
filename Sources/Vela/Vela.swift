//
//  ColorPickerView.swift
//  Vela
//
//  Created by 785 on 2024/5/17.
//

import SwiftUI
import UIKit

let colorNames: [LocalizedStringResource] = [LocalizedStringResource("Vela.selections.cyan", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Vela.selections.blue", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Vela.selections.purple", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Vela.selections.light-purple", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Vela.selections.dark-red", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Vela.selections.orange-red", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Vela.selections.orange", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Vela.selections.light-orange", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Vela.selections.khaki", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Vela.selections.bright-yellow", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Vela.selections.yellow-green", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Vela.selections.lime", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Vela.selections.gradient", bundle: .atURL(Bundle.module.bundleURL))]

public struct VelaPicker<L: View>: View {
  public var color: Binding<Color>
  public var label: () -> L
  public var allowOpacity: Bool
  public init(color: Binding<Color>, label: @escaping () -> L = {Text("Vela")}, allowOpacity: Bool = true) {
    self.color = color
    self.label = label
    self.allowOpacity = allowOpacity
  }
  @State var isColorSheetDisplaying = false
  public var body: some View {
    Button(action: {
      isColorSheetDisplaying.toggle()
    }, label: {
      label()
    })
    .sheet(isPresented: $isColorSheetDisplaying, content: {
      VelaMainView(color: color, allowOpacity: allowOpacity)
    })
  }
}

struct VelaMainView: View {
  @Binding var color: Color
  var allowOpacity = true
  @AppStorage("VelaColorTab") var colorTab: Int = 0
  var body: some View {
    if colorTab == 0 {
      VelaListView(color: $color, allowOpacity: allowOpacity)
    } else if colorTab == 1 {
      VelaSliderView(color: $color, allowOpacity: allowOpacity)
    } else {
      Text("\(colorTab)").monospaced()
    }
  }
}

struct VelaTabSheet: View {
  @AppStorage("VelaColorTab") var colorTab: Int = 0
  @State var colorTabSheetIsDisplaying = false
  @Environment(\.dismiss) var dismiss
  var hideSpacer = false
  let colorTabNames = [LocalizedStringResource("Vela.picker", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Vela.slider", bundle: .atURL(Bundle.module.bundleURL))]
  let colorTabSymbol = ["list.bullet", "slider.horizontal.3"]
  var body: some View {
    NavigationStack {
      HStack {
        if !hideSpacer {
          Spacer()
        }
        Button(action: {
          colorTabSheetIsDisplaying.toggle()
        }, label: {
          Image(systemName: colorTabSymbol[colorTab])
        })
      }
//      .ignoresSafeArea()
      .sheet(isPresented: $colorTabSheetIsDisplaying, content: {
        NavigationStack {
          List {
            ForEach(0..<colorTabNames.count, id: \.self) { displayColorTab in
              Button(action: {
                colorTab = displayColorTab
//                dismiss()
              }, label: {
                VelaLabel(directString: colorTabNames[displayColorTab], labelIcon: colorTabSymbol[displayColorTab])
                //              Label(colorTabNames[displayColorTab], image: colorTabSymbol[displayColorTab])
              })
            }
          }
          .navigationTitle(Text(String(localized: "Vela.tab-sheet", bundle: Bundle.module)))
        }
      })
    }
  }
}


struct VelaColorIndicator: View {
  @Binding var color: Color
  var allowOpacity = true
  @State var colorDetailsSheetIsDisplaying = false
  @AppStorage("VelaColorPreviewTakesFullSpace") var VelaColorPreviewTakesFullSpace = true
  var body: some View {
    NavigationStack {
      Button(action: {
        colorDetailsSheetIsDisplaying.toggle()
      }, label: {
        color
          .mask(Circle())
          .ignoresSafeArea()
          .padding(VelaColorPreviewTakesFullSpace ? -6 : 0)
      })
      .ignoresSafeArea()
      .sheet(isPresented: $colorDetailsSheetIsDisplaying, content: {
        VelaPickerDetailsView(color: color, allowOpacity: allowOpacity)
      })
    }
  }
}

struct VelaPickerDetailsView: View {
  var color: Color
  var allowOpacity = true
  var body: some View {
    if #available(watchOS 10.0, *) {
      NavigationStack {
        ScrollView {
          VStack(alignment: .leading) {
            Group {
              HStack {
                Circle()
                  .foregroundStyle(color)
                  .frame(width: 30)
                Spacer()
              }
              VStack {
                HStack {
                  Text(color.hexCode())
                    .bold()
                    .font(.title3)
                    .monospaced()
                  Spacer()
                }
                if allowOpacity && (color.RGB_values().3)*100==100 {
                  Group {
                    HStack {
                      Text(String(localized: "Vela.opacity", bundle: Bundle.module)) + Text(String(localized: "Vela.colon", bundle: Bundle.module)) + Text(String(Int((color.RGB_values().3)*100))).monospaced() + Text(String("%")).monospaced()
                      Spacer()
                    }
                  }
                  .foregroundStyle(.secondary)
                }
              }
            }
            Divider()
            Group {
              Text(String(localized: "Vela.RGB", bundle: Bundle.module))
                .bold()
                .font(.title3)
              HStack {
                Text(String(localized: "Vela.RGB.red", bundle: Bundle.module))
                Spacer()
                Text("\(color.RGB_values().0)")
                  .monospaced()
              }
              HStack {
                Text(String(localized: "Vela.RGB.green", bundle: Bundle.module))
                Spacer()
                Text("\(color.RGB_values().1)")
                  .monospaced()
              }
              HStack {
                Text(String(localized: "Vela.RGB.blue", bundle: Bundle.module))
                Spacer()
                Text("\(color.RGB_values().2)")
                  .monospaced()
              }
            }
            Divider()
            Group {
              Text(String(localized: "Vela.HSB", bundle: Bundle.module))
                .bold()
                .font(.title3)
              HStack {
                Text(String(localized: "Vela.HSB.hue", bundle: Bundle.module))
                Spacer()
                Text("\(color.HSB_values().0)") + Text(String("˚"))
                  .monospaced()
              }
              HStack {
                Text(String(localized: "Vela.HSB.saturation", bundle: Bundle.module))
                Spacer()
                Text("\(color.HSB_values().1)") + Text(String("%"))
                  .monospaced()
              }
              HStack {
                Text(String(localized: "Vela.HSB.brightness", bundle: Bundle.module))
                Spacer()
                Text("\(color.HSB_values().2)") + Text(String("%"))
                  .monospaced()
              }
            }
            Divider()
            Group {
              Text(String(localized: "Vela.CMYK", bundle: Bundle.module))
                .bold()
                .font(.title3)
              Text(String(localized: "Vela.CMYK.inaccurate", bundle: Bundle.module))
                .foregroundStyle(.secondary)
                .font(.caption)
              HStack {
                Text(String(localized: "Vela.CMYK.cyan", bundle: Bundle.module))
                Spacer()
                Text("\(color.CMYK_values().0)") + Text(String("%"))
                  .monospaced()
              }
              HStack {
                Text(String(localized: "Vela.CMYK.magenta", bundle: Bundle.module))
                Spacer()
                Text("\(color.CMYK_values().1)") + Text(String("%"))
                  .monospaced()
              }
              HStack {
                Text(String(localized: "Vela.CMYK.yellow", bundle: Bundle.module))
                Spacer()
                Text("\(color.CMYK_values().2)") + Text(String("%"))
                  .monospaced()
              }
              HStack {
                Text(String(localized: "Vela.CMYK.black", bundle: Bundle.module))
                Spacer()
                Text("\(color.CMYK_values().3)") + Text(String("%"))
                  .monospaced()
              }
            }
          }
          .padding(.horizontal, 3)
          .navigationTitle(Text(String(localized: "Vela.details", bundle: Bundle.module)))
          .toolbar {
            if #available(watchOS 10.0, *) {
              ToolbarItem(placement: .topBarTrailing, content: {
                NavigationLink(destination: {
                  VelaSettingsView()
                }, label: {
                  Image(systemName: "info")
                })
              })
            }
          }
        }
      }
    }
  }
}

@ViewBuilder func ColorBox(_ color: Color) -> some View { //Deprecated
  RoundedRectangle(cornerRadius: 7)
    .foregroundStyle(color)
    .frame(width: 70, height: 30)
}

func CMYK_to_RGB(cyan: Int, magenta: Int, yellow: Int, black: Int, opacity: CGFloat) -> (Int, Int, Int, CGFloat) { //Deprecated
  let red = 255*(1-cyan)*(1-black)
  let green = 255*(1-magenta)*(1-black)
  let blue = 255*(1-yellow)*(1-black)
  return (red, green, blue, opacity)
}

extension Int {
  func hex() -> String {
    return String(format: "%02X", self)
  }
}

extension Color {
  func RGB_values() -> (Int, Int, Int, CGFloat) {
    let color = UIColor(self)
    let RGB = color.cgColor.components ?? [0, 0, 0, 0]
    let red = Int(RGB[0] * 255)
    let green = Int(RGB[1] * 255)
    let blue = Int(RGB[2] * 255)
    let opacity = RGB[3]
    return (red, green, blue, opacity)
  }
  
  func HSB_values() -> (Int, Int, Int, CGFloat) {
    let color = UIColor(self)
    var hue: CGFloat = -1
    var saturation: CGFloat = -1
    var brightness: CGFloat = -1
    var opacity: CGFloat = -1
    _ = color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &opacity)
    return (Int(hue*359), Int(saturation*100), Int(brightness*100), opacity)
  }
  
  func CMYK_values() -> (Int, Int, Int, Int, CGFloat) {
    let red: Double = Double(self.RGB_values().0)/255
    let green: Double = Double(self.RGB_values().1)/255
    let blue: Double = Double(self.RGB_values().2)/255
    let opacity = self.RGB_values().3
    let black = 1 - max(red, green, blue)
    let cyan = (1-red-black)/(1-black)
    let magenta = (1-green-black)/(1-black)
    let yellow = (1-blue-black)/(1-black)
    return(Int(cyan*100), Int(magenta*100), Int(yellow*100), Int(black*100), opacity)
  }
  
  func hexCode() -> String {
    let r = self.RGB_values().0
    let g = self.RGB_values().1
    let b = self.RGB_values().2
    return String(format: "#%02X%02X%02X", r, g, b)
  }
}

extension UIColor {
  var rgb: [CGFloat] {
    let cgColor = self.cgColor
    return cgColor.components ?? [0, 0, 0, 0]
  }
}
