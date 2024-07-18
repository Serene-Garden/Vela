//
//  VelaAbout.swift
//
//
//  Created by 雷美淳 on 2024/5/18.
//

import SwiftUI

public let VelaVersion = "2.3.0"

public struct VelaSettingsView: View {
  public init(VelaColorPreviewTakesFullSpace: Bool = true) {
    self.VelaColorPreviewTakesFullSpace = VelaColorPreviewTakesFullSpace
  }
  @AppStorage("VelaColorPreviewTakesFullSpace") var VelaColorPreviewTakesFullSpace = true
  @AppStorage("VelaSlidersCrownSensitivity") var VelaSlidersCrownSensitivity = 1
  public var body: some View {
    if #available(watchOS 10.0, *) {
      Group {
        List {
          Group {
            HStack {
              Spacer()
              VStack(alignment: .center) {
                Text(verbatim: "Vela")
                  .bold()
                  .font(.title2)
                Group {
                  Text(verbatim: "By Serene Garden")
                  Text(verbatim: VelaVersion)
                    .monospaced()
                }
                //        .foregroundStyle(.secondary)
                .font(.caption)
              }
              Spacer()
            }
          }
          .listRowBackground(Rectangle().opacity(0).frame(height: 0))
          Section {
            Toggle(isOn: $VelaColorPreviewTakesFullSpace, label: {
              VelaLabel(localizedStringKey: "Vela.about.settings.color-circle-fully-filled", labelIcon: "circle.dotted", labelIconIsSymbol: true)
            })
            Picker(String(localized: "Vela.about.settings.crown-sensitivity-for-sliders", bundle: Bundle.module), selection: $VelaSlidersCrownSensitivity) {
              Text(String(localized: "Vela.about.settings.crown-sensitivity-for-sliders.low", bundle: Bundle.module)).tag(0)
              Text(String(localized: "Vela.about.settings.crown-sensitivity-for-sliders.medium", bundle: Bundle.module)).tag(1)
              Text(String(localized: "Vela.about.settings.crown-sensitivity-for-sliders.high", bundle: Bundle.module)).tag(2)
            }
            NavigationLink(destination: {
              List {
                Section(content: {
                  Text(verbatim: "ThreeManager785")
                  Text(verbatim: "WindowsMEMZ")
                }, footer: {
                  Text(verbatim: "https://github.com/Serene-Garden/Vela")
                })
              }
            }, label: {
              HStack {
                Image(systemName: "fleuron")
                  .font(.system(size: 20))
                  .foregroundStyle(.tint)
                  .fontDesign(.rounded)
                VStack(alignment: .leading) {
                  Text(String(localized: "Vela.about.credits", bundle: Bundle.module))
                }
              }
            })
          }
        }
      }
    }
  }
}

struct VelaLabel: View {
  var localizedStringKey: String.LocalizationValue = "Vela.placeholder"
  var directString: LocalizedStringResource = ""
  var labelIcon: String = "Aa"
  var labelIconIsSymbol: Bool = true
  var body: some View {
    if #available(watchOS 9.1, *) {
      HStack {
        Group {
          if labelIconIsSymbol {
            Image(systemName: labelIcon)
          } else {
            Text(labelIcon)
          }
        }
        .font(.system(size: 20))
        .foregroundStyle(.tint)
        .fontDesign(.rounded)
        VStack(alignment: .leading) {
          if directString.key.isEmpty {
            Text(String(localized: localizedStringKey, bundle: Bundle.module))
          } else {
            Text(directString)
          }
        }
      }
      
    }
  }
}

