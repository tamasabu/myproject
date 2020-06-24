//
//  OverLayView.swift
//  Oekaki2
//
//  Created by 田路達弥 on 2020/06/19.
//  Copyright © 2020 田路達弥. All rights reserved.
//

import SwiftUI

struct DrawPoints: Identifiable {
    var points: [CGPoint]
    var color: Color
    var id = UUID()
}

struct DrawPathView: View {
    var drawPointsArray: [DrawPoints]
    init(drawPointsArray: [DrawPoints]) {
        self.drawPointsArray = drawPointsArray
    }
    var body: some View {
        ZStack {
            ForEach(drawPointsArray) { data in
                Path { path in
                    path.addLines(data.points)
                }
                .stroke(data.color, lineWidth: 10)
            }
        }
    }
}

struct OverlayView: View {
    @State var tmpDrawPoints: DrawPoints = DrawPoints(points: [], color: .red)
    @State var endedDrawPoints: [DrawPoints] = []
    @State var startPoint: CGPoint = CGPoint.zero
    @State var selectedColor: Color = .red
    @State var redColor : Double = 0
    @State var greenColor : Double = 0
    @State var blueColor : Double = 0
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color.white)
                .frame(width: 300, height: 500, alignment: .center)
                .overlay(
                    DrawPathView(drawPointsArray: endedDrawPoints)
                        .overlay(
                            Path { path in
                                path.addLines(self.tmpDrawPoints.points)
                            }
                            .stroke(self.tmpDrawPoints.color, lineWidth: 10)
                    )
            )
                .gesture(
                    DragGesture()
                        .onChanged({ (value) in
                            
                            if self.startPoint != value.startLocation {
                                self.tmpDrawPoints.points.append(value.location)
                                self.tmpDrawPoints.color = self.selectedColor
                                
                            }
                        })
                        .onEnded({ (value) in
                            self.startPoint = value.startLocation
                            self.endedDrawPoints.append(self.tmpDrawPoints)
                            self.tmpDrawPoints = DrawPoints(points: [], color: self.selectedColor)
                        })
            )

            VStack(spacing: 10) {
                Button(action: {
                    self.selectedColor = .white
                }) {
                    Image(systemName: "trash.circle")
                    Text("消しゴム")
                }
                RGB_View(redColor: $redColor, greenColor: $greenColor, blueColor: $blueColor, coloreSet: $selectedColor)
            }
            .frame(minWidth: 0, maxWidth: CGFloat.infinity,maxHeight: 300)
            .border(Color.black, width: 3)
        }
    }
}

struct OverlayView_Previews: PreviewProvider {
    static var previews: some View {
        OverlayView()
    }
}
