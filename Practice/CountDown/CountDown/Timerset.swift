//
//  Timerset.swift
//  CountDown
//
//  Created by 田路達弥 on 2020/06/03.
//  Copyright © 2020 田路達弥. All rights reserved.
//

import SwiftUI

struct Timerset: View {
    @State var isActiveView = false
    @State var shoeingAlert = false
    @State var date:Date = Date()
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink( destination: ContentView(toDate:date),isActive: $isActiveView ){
                    EmptyView()
                }
                Text("時間を指定")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                DatePicker(selection: $date,
                           in: Date()...,
                           displayedComponents: [.hourAndMinute,.date],
                           label: {Text("約束の日")})
                Spacer()
                Button(action: {
                    if timeCheck(nowDate: self.date){
                    self.isActiveView.toggle()
                    }else{
                        self.shoeingAlert = true
                    }
                })
                {
                    Text("設定")
                        .font(.title)
                }
                .alert(isPresented: $shoeingAlert){
                    Alert(title: Text("エラー"), message: Text("設定した時刻が現在の時間を過ぎています。\n再度設定し直してください。"))
                }
                Spacer()
            }
        }
    }
}

struct Timerset_Previews: PreviewProvider {
    static var previews: some View {
        Timerset()
            .environment(\.locale, Locale(identifier: "ja_JP"))
    }
}

func timeCheck(nowDate:Date) -> Bool {
    if nowDate > Date(){
        return true
    }else{
        return false
    }
}

