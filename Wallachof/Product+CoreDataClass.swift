//
//  Product+CoreDataClass.swift
//  Wallachof
//
//  Created by Dev2 on 20/05/2019.
//  Copyright © 2019 CFTIC. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Product)
public class Product: NSManagedObject {

    static var all: [Product] {
        let productosRequest: NSFetchRequest<Product> = Product.fetchRequest()
        let context = CoreDataManager.shared.persistentContainer.viewContext

        do {
            return try context.fetch(productosRequest)
        }catch {
            return []
        }

    }

}
