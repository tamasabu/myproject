//
//  ContentView.swift
//  testCoredata
//
//  Created by 田路達弥 on 2020/07/22.
//  Copyright © 2020 田路達弥. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showPersonAddView: Bool = false
    var body: some View {
        NavigationView{
            VStack{
                PersonData()
                .navigationBarTitle("ユーザ情報管理画面",
                                    displayMode: .inline)
                .navigationBarItems(trailing:
                    Button(action:{self.showPersonAddView.toggle()
                    }){Image(systemName: "person.badge.plus")
                    }.sheet(isPresented: self.$showPersonAddView){
                        PersonDataAddView()
                    }
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
