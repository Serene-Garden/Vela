//
//
//  VelaSliders.swift
//
//
//  Created by 雷美淳 on 2024/5/19.
//

import SwiftUI
import UIKit

struct VelaSliderView: View {
  @Binding var color: Color
  var defaultColor: Color? = nil
  var allowOpacity = true
  @State var colorIsRGB = true
  @State var sliderRed = 0.0
  @State var sliderGreen = 0.0
  @State var sliderBlue = 0.0
  @State var sliderHue = 0.0
  @State var sliderSaturation = 0.0
  @State var sliderBrightness = 0.0
  @State var sliderOpacity = 100.0
  @State var syncRGB = false
  @State var syncHSB = false
  var allowRGB = true
  var allowHSB = true
  var allowCMYK = true
  var HSB_primary = false
  var body: some View {
    NavigationStack {
      Group {
        if #available(watchOS 10.0, *) {
          ScrollView {
            if colorIsRGB {
              Group {
                VelaSliderUnit(sliderValue: $sliderRed, localizedStringValue: "Vela.RGB.red", maximumValue: 255.0, gradientStarter: Color(red: 0, green: sliderGreen/255, blue: sliderBlue/255), gradientEnder: Color(red: 1, green: sliderGreen/255, blue: sliderBlue/255), syncValueAndRotation: $syncRGB)
                VelaSliderUnit(sliderValue: $sliderGreen, localizedStringValue: "Vela.RGB.green", maximumValue: 255.0, gradientStarter: Color(red: sliderRed/255, green: 0, blue: sliderBlue/255), gradientEnder: Color(red: sliderRed/255, green: 1, blue: sliderBlue/255), syncValueAndRotation: $syncRGB)
                VelaSliderUnit(sliderValue: $sliderBlue, localizedStringValue: "Vela.RGB.blue", maximumValue: 255.0, gradientStarter: Color(red: sliderRed/255, green: sliderGreen/255, blue: 0), gradientEnder: Color(red: sliderRed/255, green: sliderGreen/255, blue: 1), syncValueAndRotation: $syncRGB)
              }
              .onAppear {
                sliderRed = Double(color.RGB_values().0)
                sliderGreen = Double(color.RGB_values().1)
                sliderBlue = Double(color.RGB_values().2)
                sliderOpacity = (color.RGB_values().3)*100
              }
            } else {
              Group {
                VelaSliderUnit(sliderValue: $sliderHue, localizedStringValue: "Vela.HSB.hue", maximumValue: 359.0, unit: "˚", customGradient: [Color(hue: 0/360, saturation: sliderSaturation/100, brightness: sliderBrightness/100), Color(hue: 60/360, saturation: sliderSaturation/100, brightness: sliderBrightness/100), Color(hue: 120/360, saturation: sliderSaturation/100, brightness: sliderBrightness/100), Color(hue: 180/360, saturation: sliderSaturation/100, brightness: sliderBrightness/100), Color(hue: 240/360, saturation: sliderSaturation/100, brightness: sliderBrightness/100), Color(hue: 300/360, saturation: sliderSaturation/100, brightness: sliderBrightness/100), Color(hue: 359/360, saturation: sliderSaturation/100, brightness: sliderBrightness/100)], syncValueAndRotation: $syncHSB)
                VelaSliderUnit(sliderValue: $sliderSaturation, localizedStringValue: "Vela.HSB.saturation", maximumValue: 100.0, gradientStarter: Color(hue: sliderHue/360, saturation: 0, brightness: sliderBrightness/100), gradientEnder: Color(hue: sliderHue/360, saturation: 1, brightness: sliderBrightness/100), unit: "%", syncValueAndRotation: $syncHSB)
                VelaSliderUnit(sliderValue: $sliderBrightness, localizedStringValue: "Vela.HSB.brightness", maximumValue: 100.0, gradientStarter: Color(hue: sliderHue/360, saturation: sliderSaturation/100, brightness: 0), gradientEnder: Color(hue: sliderHue/360, saturation: sliderSaturation/100, brightness: 1), unit: "%", syncValueAndRotation: $syncHSB)
              }
              .onAppear {
                sliderHue = Double(color.HSB_values().0)
                sliderSaturation = Double(color.HSB_values().1)
                sliderBrightness = Double(color.HSB_values().2)
                sliderOpacity = (color.RGB_values().3)*100
              }
            }
            if allowOpacity {
              Divider()
                .padding(.horizontal, 5)
              VelaSliderUnit(sliderValue: $sliderOpacity, localizedStringValue: "Vela.opacity", maximumValue: 100.0, gradientStarter: Color.white, gradientEnder: Color.black, unit: "%", syncValueAndRotation: .constant(false))
            }
            Spacer()
              .frame(height: 10)
          }
          .onChange(of: sliderRed, {
            updateValuesForRGB()
          })
          .onChange(of: sliderGreen, {
            updateValuesForRGB()
          })
          .onChange(of: sliderBlue, {
            updateValuesForRGB()
          })
          .onChange(of: sliderHue, {
            updateValuesForHSB()
          })
          .onChange(of: sliderSaturation, {
            updateValuesForHSB()
          })
          .onChange(of: sliderBrightness, {
            updateValuesForHSB()
          })
          .onChange(of: sliderOpacity, {
            if colorIsRGB {
              updateValuesForRGB()
            } else {
              updateValuesForHSB()
            }
          })
          .onChange(of: colorIsRGB, {
            if colorIsRGB {
              syncRGB = true
            } else {
              syncHSB = true
            }
          })
        }
        
      }
      .onAppear {
        if (!allowRGB || HSB_primary) {
          colorIsRGB = false
        }
      }
      .toolbar {
        if #available(watchOS 10.0, *) {
          ToolbarItemGroup(placement: .topBarTrailing, content: {
            VelaColorIndicator(color: $color, allowOpacity: allowOpacity, allowRGB: allowRGB, allowHSB: allowHSB, allowCMYK: allowCMYK, HSB_primary: HSB_primary)
          })
          ToolbarItemGroup(placement: .bottomBar, content: {
            HStack {
              Button(action: {
                  colorIsRGB.toggle()
              }, label: {
                Image(systemName: "paintpalette")
              })
              .disabled(!allowRGB || !allowHSB)
              Spacer()
              VelaTabSheet(color: $color, defaultColor: defaultColor)
            }
            .background {
              Rectangle()
                .foregroundStyle(.black)
//                .opacity(0.7)
                .blur(radius: 20)
                .padding(.horizontal, -20)
                .padding(.bottom, -20)
                .padding(.top, -5)
            }
          })
        }
      }
      .navigationTitle(Text(String(localized: "Vela.slider", bundle: Bundle.module)))
    }
  }
  func updateValuesForRGB() {
    color = Color(red: sliderRed/255, green: sliderGreen/255, blue: sliderBlue/255, opacity: sliderOpacity/100)
    //      sliderHue = Double(color.HSB_values().0)
    //      sliderSaturation = Double(color.HSB_values().1)
    //      sliderBrightness = Double(color.HSB_values().2)
  }
  func updateValuesForHSB() {
    color = Color(hue: sliderHue/360, saturation: sliderSaturation/100, brightness: sliderBrightness/100, opacity: sliderOpacity/100)
    //      sliderRed = Double(color.RGB_values().0)
    //      sliderGreen = Double(color.RGB_values().1)
    //      sliderBlue = Double(color.RGB_values().2)
  }
}


struct VelaSliderUnit: View {
  @Binding var sliderValue: Double
  var localizedStringValue: String.LocalizationValue = "Vela.placeholder"
  var minimumValue: Double = 0.0
  var maximumValue: Double
  var gradientStarter: Color = Color.white
  var gradientEnder: Color = Color.black
  var unit: String = ""
  var customGradient: [Color] = []
  @Binding var syncValueAndRotation: Bool
  
  @AppStorage("VelaSlidersCrownSensitivity") var VelaSlidersCrownSensitivity = 1
  let displayBackground = false
  let sensitivities: [DigitalCrownRotationalSensitivity] = [.low, .medium, .high]
  
  @FocusState var sliderIsOnFocus
  @State var digitalCrownRotation = 0
  var body: some View {
    if #available(watchOS 10.0, *) {
      Group {
        ZStack {
          if displayBackground {
            RoundedRectangle(cornerRadius: 10)
              .foregroundStyle(.secondary)
              .opacity(0.5)
          }
          Group {
            RoundedRectangle(cornerRadius: 10)
              .stroke(lineWidth: 1)
              .opacity(sliderIsOnFocus ? 1 : 0)
              .foregroundStyle(.tint)
              .padding(.horizontal, -0)
              .padding(.vertical, -3)
            VStack(alignment: .leading) {
              HStack {
                Text(String(localized: localizedStringValue, bundle: Bundle.module))
                Spacer()
                Text("\(Int(sliderValue))") + Text(unit)
              }
              Gauge(
                value: sliderValue,
                in: minimumValue...maximumValue,
                label: {
                  if false {
                    Text(String(localized: "Vela.placeholder", bundle: Bundle.module))
                  }
                }
              )
              .gaugeStyle(LinearGaugeStyle(tint: Gradient(colors: customGradient.isEmpty ? [gradientStarter, gradientEnder] : customGradient)))
              //          .focusable(currentFocusID == 0 || currentFocusID == sliderID)
              .focusable()
              .focused($sliderIsOnFocus)
              
            }
            .digitalCrownRotation(detent: $digitalCrownRotation, from: Int(minimumValue), through: Int(maximumValue), by: 1, sensitivity: sensitivities[VelaSlidersCrownSensitivity], isContinuous: false)
            .onAppear {
              digitalCrownRotation = Int(sliderValue)
//              Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
//                
//              }
            }
            .onChange(of: syncValueAndRotation, {
              if syncValueAndRotation {
                syncValueAndRotation = false
                digitalCrownRotation = Int(sliderValue)
              }
            })
            .onChange(of: digitalCrownRotation, {
              sliderValue = Double(digitalCrownRotation)
            })
          }
          .padding(displayBackground ? 3 : 0)
        }
      }
    }
  }
}
