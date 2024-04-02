//
//  Stock+CoreDataProperties.swift
//  SimpleProject
//
//  Created by Stepan Borisov on 28.03.24.
//
//

import Foundation
import CoreData


extension Stock {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stock> {
        return NSFetchRequest<Stock>(entityName: "Stock")
    }

    @NSManaged public var stockName: String?

}

extension Stock : Identifiable {

}
