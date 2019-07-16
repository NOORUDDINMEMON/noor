//
//  Student+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Nooruddin on 11/06/19.
//  Copyright © 2019 Nooruddin. All rights reserved.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var name: String?
    @NSManaged public var city: String?

}
