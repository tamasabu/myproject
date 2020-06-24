//
//  SecondView.swift
//  test
//
//  Created by 田路達弥 on 2020/06/16.
//  Copyright © 2020 田路達弥. All rights reserved.
//

import SwiftUI

struct SecondView: View {
    var name = ""
    
    var body: some View {
        Text(name).font(.system(size: 30))
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
