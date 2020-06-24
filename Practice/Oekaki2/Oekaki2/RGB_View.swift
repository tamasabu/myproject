//
//  RGB_View.swift
//  Oekaki2
//
//  Created by 田路達弥 on 2020/06/19.
//  Copyright © 2020 田路達弥. All rights reserved.
//

import SwiftUI

struct RGB_View: View {
    @Binding var redColor : Double
    @Binding var greenColor : Double
    @Binding var blueColor : Double
    @Binding var coloreSet : Color
    
    var body: some View {
        HStack{
            VStack{
                HStack {
                    Circle()
                        .foregroundColor(.red)
                        .frame(width: 20, height: 20)
                    Slider(value: $redColor ,
                           in: 0...255,
                           onEditingChanged: {_ in
                            self.coloreSet = Color( red: self.redColor/255, green: self.greenColor/255, blue: self.blueColor/255)
                    },
                           minimumValueLabel: Text("0"),
                           maximumValueLabel: Text("255"),
                           label: {EmptyView()}).frame(width: 150)
                }
                HStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 20, height: 20)
                    Slider(value: $greenColor ,
                           in: 0...255,
                           onEditingChanged: {_ in
                            self.coloreSet = Color( red: self.redColor/255, green: self.greenColor/255, blue: self.blueColor/255)
                    },
                           minimumValueLabel: Text("0"),
                           maximumValueLabel: Text("255"),
                           label: {EmptyView()})
                        .frame(width: 150)
                }
                HStack {
                    Circle()
                        .foregroundColor(.blue)
                        .frame(width: 20, height: 20)
                    Slider(value: $blueColor ,
                           in: 0...255,
                           onEditingChanged: {_ in
                            self.coloreSet = Color( red: self.redColor/255, green: self.greenColor/255, blue: self.blueColor/255)
                    },
                           minimumValueLabel: Text("0"),
                           maximumValueLabel: Text("255"),
                           label: {EmptyView()}).frame(width: 150)
                }
            }
            Spacer().frame(width: 50)
            VStack{
                Text("色")
                Color(red: redColor/255, green: greenColor/255, blue: blueColor/255)
                    .frame(width: 100 , height: 100)
            }
        }
    }
}
