//
//  AlertemError.swift
//  test2
//
//  Created by 田路達弥 on 2020/06/18.
//  Copyright © 2020 田路達弥. All rights reserved.
//

import SwiftUI

struct AlertemError: Identifiable, CustomStringConvertible {
    var description: String{
        "title: \(title) \nmessage: \(message) \nok: \(ok)"
    }
    var id = UUID()
    var title: String
    var message: String
    var ok: String
}

