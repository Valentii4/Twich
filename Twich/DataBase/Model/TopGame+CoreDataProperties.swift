//
//  TopGame+CoreDataProperties.swift
//  
//
//  Created by Valentin Mironov on 08.12.2020.
//
//

import Foundation
import CoreData

extension TopGame {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopGame> {
        return NSFetchRequest<TopGame>(entityName: "TopGame")
    }

    @NSManaged public var channels: Int64
    @NSManaged public var image: Data?
    @NSManaged public var imageURL: URL
    @NSManaged public var name: String
    @NSManaged public var viewers: Int64

}
