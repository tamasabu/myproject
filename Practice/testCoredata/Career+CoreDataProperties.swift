//
//  Career+CoreDataProperties.swift
//  testCoredata
//
//  Created by 田路達弥 on 2020/07/22.
//  Copyright © 2020 田路達弥. All rights reserved.
//
//

import Foundation
import CoreData


extension Career {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Career> {
        return NSFetchRequest<Career>(entityName: "Career")
    }

    @NSManaged public var company: String?
    @NSManaged public var endDate: Date?
    @NSManaged public var startDate: Date?
    @NSManaged public var person: Person?

}
