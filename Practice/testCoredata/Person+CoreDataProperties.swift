//
//  Person+CoreDataProperties.swift
//  testCoredata
//
//  Created by 田路達弥 on 2020/07/22.
//  Copyright © 2020 田路達弥. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var birthday: Date?
    @NSManaged public var carrers: NSSet?

}

// MARK: Generated accessors for carrers
extension Person {

    @objc(addCarrersObject:)
    @NSManaged public func addToCarrers(_ value: Career)

    @objc(removeCarrersObject:)
    @NSManaged public func removeFromCarrers(_ value: Career)

    @objc(addCarrers:)
    @NSManaged public func addToCarrers(_ values: NSSet)

    @objc(removeCarrers:)
    @NSManaged public func removeFromCarrers(_ values: NSSet)

}
