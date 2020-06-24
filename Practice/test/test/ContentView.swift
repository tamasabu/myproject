    //
    //  ContentView.swift
    //  test
    //
    //  Created by 田路達弥 on 2020/06/08.
    //  Copyright © 2020 田路達弥. All rights reserved.
    //
    
    import SwiftUI
    
    struct ContentView: View {
        @State var mfgs = ["Kawasaki","Honda","Yamaha","Suzuki","Ducati","BMW"]
        @State var showingDetail = false
        
        var body: some View{
            List{
                Text("Manufacturig").font(.system(size: 30))
                ForEach( mfgs, id: \.self){ mfg in
                    Button(action: { self.showingDetail.toggle() }){
                        Text(mfg)
                    }.sheet(isPresented: self.$showingDetail){
                        SecondView(name: mfg)
                    }
                }
            }
        }
    }
    
    
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .environment(\.locale, Locale(identifier: "ja_jp"))
        }
    }
