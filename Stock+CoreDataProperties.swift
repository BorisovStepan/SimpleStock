//
//  Stock+CoreDataProperties.swift
//  SimpleProject
//
//  Created by Stepan Borisov on 4.04.24.
//
//

import Foundation
import CoreData


extension Stock {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stock> {
        return NSFetchRequest<Stock>(entityName: "Stock")
    }

    @NSManaged public var stockName: String?
    @NSManaged public var openPrice: Double
    @NSManaged public var differencePrice: Double

}

extension Stock : Identifiable {

}
