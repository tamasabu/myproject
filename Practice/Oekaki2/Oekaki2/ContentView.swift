//
//  ContentView.swift
//  Oekaki2
//
//  Created by 田路達弥 on 2020/06/19.
//  Copyright © 2020 田路達弥. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var tmpDrawPoints: DrawPoints = DrawPoints(points: [], color: .red)
    @State var endedDrawPoints: [DrawPoints] = []
    @State var startPoint: CGPoint = CGPoint.zero
    @State var selectedColor: Color = .red
    @State var redColor : Double = 0
    @State var greenColor : Double = 0
    @State var blueColor : Double = 0
    var body: some View {
        VStack{
            Text("お絵描きアプリ")
            OverlayView(tmpDrawPoints: tmpDrawPoints, endedDrawPoints: self.endedDrawPoints, startPoint: self.startPoint, selectedColor: self.selectedColor, redColor: redColor, greenColor: self.greenColor, blueColor: self.blueColor)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
