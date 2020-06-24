//
//  ContentView.swift
//  test3
//
//  Created by 田路達弥 on 2020/06/23.
//  Copyright © 2020 田路達弥. All rights reserved.
//

import SwiftUI

struct ContentView:View {
    
    @State private var showingSwiftUI = false
    
    var body: some View{
        VStack{
            Toggle(isOn: $showingSwiftUI.animation()){
                Text("Animeition Toggle label")
            }
            
            if showingSwiftUI {
                Text("Hello swiftUI!")
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.locale, Locale(identifier: "ja_jp"))
    }
}

