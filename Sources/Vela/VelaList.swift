//
//  VelaList.swift
//  
//
//  Created by 雷美淳 on 2024/5/21.
//

import SwiftUI

struct VelaListView: View {
  @Binding var color: Color
  var defaultColor: Color? = nil
  var allowOpacity = true
  var allowRGB = true
  var allowHSB = true
  var allowCMYK = true
  var HSB_primary = false
  var aboutLinkIsHidden = false
  var body: some View {
    NavigationStack {
      List {
        ForEach(0..<colorSelections.count, id: \.self) { colorGroupIndex in
          NavigationLink(destination: {
            List {
              ForEach(0..<colorSelections[colorGroupIndex].count, id: \.self) { colorSubgroupIndex in
                Button(action: {
                  withAnimation {
                    color = colorSelections[colorGroupIndex][colorSubgroupIndex]
                  }
                }, label: {
                  HStack {
                    Circle()
                      .frame(width: 10)
                      .foregroundStyle(colorSelections[colorGroupIndex][colorSubgroupIndex])
                    Text(colorSelections[colorGroupIndex][colorSubgroupIndex].hexCode())
                  }
                })
              }
            }
            .navigationTitle(Text(colorNames[colorGroupIndex]))
            .toolbar {
              if #available(watchOS 10.0, *) {
                ToolbarItemGroup(placement: .topBarTrailing, content: {
                  VelaColorIndicator(color: $color, allowOpacity: allowOpacity)
                })
                ToolbarItemGroup(placement: .bottomBar, content: {
                  VelaTabSheet(color: $color, defaultColor: defaultColor)
                })
              }
            }
          }, label: {
            HStack {
              Circle()
                .frame(width: 10)
                .foregroundStyle(colorSelections[colorGroupIndex][4])
              Text(colorNames[colorGroupIndex])
            }
          })
        }
      }
      .toolbar {
        if #available(watchOS 10.0, *) {
          ToolbarItemGroup(placement: .topBarTrailing, content: {
            VelaColorIndicator(color: $color, allowOpacity: allowOpacity, allowRGB: allowRGB, allowHSB: allowHSB, allowCMYK: allowCMYK, HSB_primary: HSB_primary, aboutLinkIsHidden: aboutLinkIsHidden)
          })
          ToolbarItemGroup(placement: .bottomBar, content: {
            VelaTabSheet(color: $color, defaultColor: defaultColor)
          })
        }
      }
      .navigationTitle(Text(String(localized: "Vela.picker", bundle: Bundle.module)))
    }
  }
}

let colorSelections: [[Color]] = [
  [
    Color(red: 20/255, green: 54/255, blue: 72/255),
    Color(red: 30/255, green: 76/255, blue: 99/255),
    Color(red: 47/255, green:108/255, blue: 140/255),
    Color(red: 61/255, green: 138/255, blue: 176/255),
    Color(red: 71/255, green: 159/255, blue: 211/255),
    Color(red: 90/255, green: 196/255, blue: 247/255),
    Color(red: 120/255, green: 211/255, blue: 248/255),
    Color(red: 165/255,green: 225/255,blue: 250/255),
    Color(red: 210/255,green: 239/255, blue: 253/255)
  ],
  [
    Color(red: 8/255, green: 28/255, blue: 84/255),
    Color(red: 16/255, green: 46/255, blue: 118/255),
    Color(red: 25/255, green: 65/255, blue: 163/255),
    Color(red: 35/255, green: 85/255, blue: 206/255),
    Color(red: 40/255, green: 95/255, blue: 245/255),
    Color(red: 79/255, green: 133/255, blue: 246/255),
    Color(red: 127/255, green: 166/255, blue: 248/255),
    Color(red: 173/255, green: 197/255, blue: 250/255),
    Color(red: 214/255, green: 226/255, blue: 252/255)
  ],
  [
    Color(red: 15/255, green: 5/255, blue: 56/255),
    Color(red: 24/255, green: 11/255, blue: 79/255),
    Color(red: 40/255, green: 11/255, blue: 114/255),
    Color(red: 51/255, green: 27/255, blue: 142/255),
    Color(red: 71/255, green: 36/255, blue: 171/255),
    Color(red: 88/255, green: 50/255, blue: 226/255),
    Color(red: 126/255, green: 82/255, blue: 245/255),
    Color(red: 171/255, green: 141/255, blue: 247/255),
    Color(red: 214/255, green: 202/255, blue: 250/255)
  ],
  [
    Color(red: 42/255, green: 9/255, blue: 59/255),
    Color(red: 63/255, green: 18/255, blue: 86/255),
    Color(red: 89/255, green: 30/255, blue: 120/255),
    Color(red: 112/255, green: 48/255, blue: 152/255),
    Color(red: 140/255, green: 51/255, blue: 182/255),
    Color(red: 175/255, green: 67/255, blue: 235/255),
    Color(red: 196/255, green: 95/255, blue: 246/255),
    Color(red: 215/255, green: 150/255, blue: 248/255),
    Color(red: 233/255, green: 203/255, blue: 251/255)
  ],
  [
    Color(red: 54/255, green: 12/255, blue: 27/255),
    Color(red: 78/255, green: 22/255, blue: 41/255),
    Color(red: 111/255, green: 34/255, blue: 61/255),
    Color(red: 141/255, green: 46/255, blue: 79/255),
    Color(red: 170/255, green: 57/255, blue: 93/255),
    Color(red: 212/255, green: 74/255, blue: 122/255),
    Color(red: 222/255, green: 120/255, blue: 157/255),
    Color(red: 232/255, green: 167/255, blue: 191/255),
    Color(red: 243/255, green: 212/255, blue: 224/255)
  ],
  [
    Color(red: 84/255, green: 17/255, blue: 7/255),
    Color(red: 120/255, green: 30/255, blue: 14/255),
    Color(red: 166/255, green: 44/255, blue: 23/255),
    Color(red: 208/255, green: 58/255, blue: 32/255),
    Color(red: 235/255, green: 81/255, blue: 46/255),
    Color(red: 237/255, green: 108/255, blue: 89/255),
    Color(red: 240/255, green: 146/255, blue: 134/255),
    Color(red: 244/255, green: 184/255, blue: 177/255),
    Color(red: 249/255, green: 220/255, blue: 217/255)
  ],
  [
    Color(red: 83/255, green: 32/255, blue: 9/255),
    Color(red: 114/255, green: 47/255, blue: 16/255),
    Color(red: 160/255, green: 70/255, blue: 26/255),
    Color(red: 202/255, green: 90/255, blue: 36/255),
    Color(red: 237/255, green: 115/255, blue: 46/255),
    Color(red: 239/255, green: 140/255, blue: 86/255),
    Color(red: 242/255, green: 169/255, blue: 132/255),
    Color(red: 246/255, green: 199/255, blue: 175/255),
    Color(red: 250/255, green: 227/255, blue: 216/255)
  ],
  [
    Color(red: 83/255, green: 53/255, blue: 13/255),
    Color(red: 115/255, green: 76/255, blue: 22/255),
    Color(red: 160/255, green: 107/255, blue: 35/255),
    Color(red: 200/255, green: 135/255, blue: 46/255),
    Color(red: 243/255, green: 175/255, blue: 61/255),
    Color(red: 243/255, green: 183/255, blue: 86/255),
    Color(red: 246/255, green: 201/255, blue: 131/255),
    Color(red: 249/255, green: 218/255, blue: 174/255),
    Color(red: 252/255, green: 237/255, blue: 215/255)
  ],
  [ //10
    Color(red: 82/255, green: 62/255, blue: 15/255),
    Color(red: 115/255, green: 89/255, blue: 26/255),
    Color(red: 159/255, green: 125/255, blue: 40/255),
    Color(red: 201/255, green: 159/255, blue: 53/255),
    Color(red: 245/255, green: 201/255, blue: 68/255),
    Color(red: 246/255, green: 205/255, blue: 91/255),
    Color(red: 249/255, green: 218/255, blue: 133/255),
    Color(red: 250/255, green: 229/255, blue: 175/255),
    Color(red: 253/255, green: 242/255, blue: 216/255)
  ],
  [
    Color(red: 101/255, green: 97/255, blue: 27/255),
    Color(red: 140/255, green: 134/255, blue: 41/255),
    Color(red: 195/255, green: 188/255, blue: 60/255),
    Color(red: 243/255, green: 236/255, blue: 78/255),
    Color(red: 253/255, green: 251/255, blue: 103/255),
    Color(red: 254/255, green: 247/255, blue: 129/255),
    Color(red: 254/255, green: 249/255, blue: 161/255),
    Color(red: 254/200, green: 251/255, blue: 192/255),
    Color(red: 254/255, green: 252/255, blue: 224/255)
  ],
  [
    Color(red: 80/255, green: 85/255, blue: 24/255),
    Color(red: 112/255, green: 118/255, blue: 37/255),
    Color(red: 157/255, green: 165/255, blue: 54/255),
    Color(red: 198/255, green: 209/255, blue: 71/255),
    Color(red: 221/255, green: 235/255, blue: 92/255),
    Color(red: 230/255, green: 239/255, blue: 122/255),
    Color(red: 235/255, green: 242/255, blue: 155/255),
    Color(red: 243/255, green: 247/255, blue: 190/255),
    Color(red: 248/255, green: 250/255, blue: 222/255)
  ],
  [
    Color(red: 43/255, green: 61/255, blue: 22/255),
    Color(red: 63/255, green: 86/255, blue: 35/255),
    Color(red: 88/255, green: 121/255, blue: 52/255),
    Color(red: 114/255, green: 156/255, blue: 68/255),
    Color(red: 134/255, green: 185/255, blue: 83/255),
    Color(red: 163/255, green: 209/255, blue: 110/255),
    Color(red: 186/255, green: 220/255, blue: 148/255),
    Color(red: 210/255, green: 231/255, blue: 186/255),
    Color(red: 226/255, green: 238/255, blue: 214/255)
  ],
  [Color(red: 255/255, green: 255/255, blue: 255/255),
   Color(red: 235/255, green: 235/255, blue: 235/255),
   Color(red: 214/255, green: 214/255, blue: 214/255),
   Color(red: 194/255, green: 194/255, blue: 194/255),
   Color(red: 173/255, green: 173/255, blue: 173/255),
   Color(red: 153/255, green: 153/255, blue: 153/255),
   Color(red: 133/255, green: 133/255, blue: 133/255),
   Color(red: 112/255, green: 112/255, blue: 112/255),
   Color(red: 92/255, green: 92/255, blue: 92/255),
   Color(red: 71/255, green: 71/255, blue: 71/255),
   Color(red: 51/255, green: 51/255, blue: 51/255),
   Color(red: 0/255, green: 0/255, blue: 0/255)
  ]
]
