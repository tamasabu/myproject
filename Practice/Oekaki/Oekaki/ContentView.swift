//
//  ContentView.swift
//  Oekaki
//
//  Created by 田路達弥 on 2020/06/02.
//  Copyright © 2020 田路達弥. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var isDrawing: Drawer = Drawer()
    @State var drawers : [Drawer] = [Drawer]()
    @State var redColor : Double = 0
    @State var greenColor : Double = 0
    @State var blueColor : Double = 0
    @State var coloreSet : Color = Color.red
    @State var drawWigth : CGFloat = 4.0
    
    var body: some View {
        VStack(alignment: .center){
            Text("お絵描きアプリ")
            DrawingArea(isDrawing: $isDrawing,
                        drawers: $drawers,
                        redColor: $redColor,
                        greenColor: $greenColor,
                        blueColor: $blueColor,
                        coloreSet: $coloreSet,
                        drawWigth: $drawWigth)
            Button(action: {
                self.coloreSet = Color(.clear)
            }){
                Image(systemName: "trash.circle")
                Text("クリア")
            }
            HStack{
                Group{
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
                }
                Spacer().frame(width: 50)
                VStack{
                    Text("色")
                    Color(red: redColor/255, green: greenColor/255, blue: blueColor/255)
                        .frame(width: 100 , height: 100)
                }
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Drawer {
    var points:[CGPoint] = [CGPoint]()
}

struct DrawingArea: View {
    
    @Binding var isDrawing: Drawer
    @Binding var drawers : [Drawer]
    @Binding var redColor : Double
    @Binding var greenColor : Double
    @Binding var blueColor : Double
    @Binding var coloreSet : Color
    @Binding var drawWigth : CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            Path { linePath in
                for Drawer in self.drawers{
                    self.addAction(Drawer : Drawer, toPath :&linePath)
                }
                self.addAction(Drawer : self.isDrawing, toPath :&linePath)
                self.coloreSet = Color(red: self.redColor/255,
                                       green: self.greenColor/255,
                                       blue: self.blueColor/255)
            }
            .stroke(self.coloreSet, lineWidth: self.drawWigth)
            .background(Color(white: 0.7))
            .gesture(DragGesture(minimumDistance: 0.05)
            .onChanged({(value) in
                let currenPoint = value.location
                if currenPoint.y >= 0 && currenPoint.y < geometry.size.height{
                    self.isDrawing.points.append(currenPoint)
                }
            })
                .onEnded({(value) in
                    self.drawers.append(self.isDrawing)
                    self.isDrawing = Drawer()
                })
            )
        }
    }
    func addAction(Drawer: Drawer , toPath linePath :inout Path){
        let points = Drawer.points
        if points.count > 1{
            for i in 0..<points.count-1 {
                let previos = points[i]
                let next = points[i+1]
                linePath.move(to: previos)
                linePath.addLine(to: next)
            }
        }
    }
}
