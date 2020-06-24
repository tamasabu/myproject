//
//  ContentView.swift
//  CountDown
//
//  Created by 田路達弥 on 2020/06/03.
//  Copyright © 2020 田路達弥. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State var toDate:Date = Date()
    
    var body: some View {
        TimeView(setDate: toDate)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TimeView: View{
    
    @State var nowDate : Date = Date()
    @State var endFlg = false
    let setDate : Date
    private var timer : Timer{
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in if self.endFlg {
            self.timer.invalidate()
            }})
        {_ in
            self.nowDate = Date()
        }
    }
    
    var body: some View{
        VStack(spacing: 30){
            Text("約束の日まで")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.red)
                .shadow(color: .black, radius: 3, x: 10, y: 10)
            Text(TimeFunction(from: setDate))
                .alert(isPresented: $endFlg){
                    Alert(title: Text("時は来た！！"),
                          message: Text("ついに約束の時来れり！！"),
                          dismissButton: .default(Text("いざ！")))}
                .font(.headline)
                .onAppear(perform: {self.timer})
            Button(action: {self.timer.invalidate()}){
                Text("終了")
            }
        }
    }
    func TimeFunction(from date: Date) -> String{
        let calendar = Calendar(identifier: .japanese)
        let timeValue = calendar
            .dateComponents([.day,.hour,.minute,.second], from: nowDate, to: setDate)
        if timeValue.day == 0 && timeValue.hour == 0 && timeValue.minute == 0 && timeValue.second == 0 {
            timer.invalidate()
            self.endFlg = true
            return String(format: "残りaaa"+"%02d日:%02d時間:%02d分:%02d秒",
                          timeValue.day!,
                          timeValue.hour!,
                          timeValue.minute!,
                          timeValue.second!)

        }else{
            return String(format: "残り"+"%02d日:%02d時間:%02d分:%02d秒",
                          timeValue.day!,
                          timeValue.hour!,
                          timeValue.minute!,
                          timeValue.second!)
        }
    }
}
