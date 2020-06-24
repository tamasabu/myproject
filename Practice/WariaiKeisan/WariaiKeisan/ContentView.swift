//
//  ContentView.swift
//  WariaiKeisan
//
//  Created by 田路達弥 on 2019/11/20.
//  Copyright © 2019 田路達弥. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    var body: some View {
        
        VStack{
            
            Text("割合計算アプリ")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(Color.red)
                .multilineTextAlignment(.center)
            Spacer().frame(height: 80)
            Keisan()
        }
    }
}

struct ShrinkBittonStyle:ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View{
        
        let isPressed = configuration.isPressed
        
        return configuration.label
            .scaleEffect(x: isPressed ? 0.9 : 1, y: isPressed ? 0.9 : 1, anchor: .center)
            .animation(.spring(response: 0.2, dampingFraction: 0.9, blendDuration: 0))
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func nilCheck(check : String)->Bool{
    var result : Bool = false
    if check.isEmpty{
        result = true
    }
    return result
}

func lengthCheck(check : String,mode :Int)->Bool{
    if mode == 1 {
        if check.count > 3{
            return true
        }else{
            return false
        }
    }else{
        if check.count > 8{
            return true
        }else{
            return false
        }
    }
}


struct Keisan :View {
    
    @State var errmessage : String = ""
    @State var textA = ""
    @State var textB = ""
    @State var total = ""
    @State var Grupe = 0.0
    @State var Goukei = 0.0
    @State var finalA = 0
    @State var finalB = 0
    
    var body: some View{
        Section(header: Text("値を入力")){
            VStack {
                Text(errmessage)
                    .foregroundColor(.red)
                HStack {
                    TextField("対象A", text: self.$textA)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(8.0)
                        .frame(width: 100.0)
                        .keyboardType(.numberPad)
                        .lineLimit(4)
                    
                    Spacer().frame(width:50)
                    TextField("対象B", text: self.$textB)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(8.0).frame(width:100.0)
                        .keyboardType(.numberPad)
                        .lineLimit(4)
                }
                TextField("総量", text: self.$total)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(8.0)
                    .frame(width: 200.0).keyboardType(.numberPad)
                
                Spacer().frame(height:20)
                //ボタン処理
                Button(action: {
                    //nilチェック
                    let nilcheck1:Bool = nilCheck(check:self.textA)
                    let nilcheck2:Bool = nilCheck(check:self.textB)
                    let nilcheck3:Bool = nilCheck(check:self.total)
                    //文字数制限チェック
                    let lengthcheck1:Bool = lengthCheck(check: self.textA, mode: 1)
                    let lengthcheck2:Bool = lengthCheck(check: self.textB, mode: 1)
                    let lengthcheck3:Bool = lengthCheck(check: self.total, mode: 2)
                    //判定
                    if nilcheck1 {
                        self.errmessage = "対象Aが入力されていません。"
                    }else if lengthcheck1{
                        self.errmessage = "対象Aの桁数が4桁以上です。3桁以内にしてください。"
                    }else if nilcheck2{
                        self.errmessage = "対象Bが入力されていません。"
                    }else if lengthcheck2{
                        self.errmessage = "対象Bの桁数が4桁以上です。3桁以内にしてください。"
                        
                    }else if nilcheck3{
                        self.errmessage = "総量が入力されていません。"
                    }else if lengthcheck3{
                        self.errmessage = "総量の桁数が9桁以上です。8桁以内にしてください。"
                    }else{
                        self.errmessage = ""
                        //計算開始
                        self.Grupe = Double(self.total)! / (Double(self.textA)! + Double(self.textB)!)
                        
                        self.finalA = Int(round( Double(self.Grupe) * Double(self.textA)!))
                        
                        self.finalB = Int(round( Double(self.Grupe) * Double(self.textB)!))
                    }
                }
                ){
                    Text("計算")
                        .padding(10)
                        .frame(width:80)
                        .background(Color.gray)
                        .cornerRadius(8)
                }.buttonStyle(ShrinkBittonStyle())
                Spacer().frame(height:50)
                HStack {
                    Text("対象Aは、\(self.finalA)")
                    Spacer().frame(width:100)
                    Text("対象Bは、\(self.finalB)")
                }
                Spacer()
            }
        }
    }
}


