//
//  UserInfo+CoreDataProperties.swift
//  Login
//
//  Created by 田路達弥 on 2020/07/21.
//  Copyright © 2020 田路達弥. All rights reserved.
//
//

import Foundation
import CoreData


extension UserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }

    @NSManaged public var loginID: String
    @NSManaged public var password: String
    @NSManaged public var username: String
    @NSManaged public var birthday: Date

}
