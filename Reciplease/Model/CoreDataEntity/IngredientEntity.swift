//
//  IngredientEntity.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 29/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import Foundation
import CoreData

class IngredientEntity: NSManagedObject {
    static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [IngredientEntity] {
        let request: NSFetchRequest<IngredientEntity> = IngredientEntity.fetchRequest()
        guard let favIngredient = try? viewContext.fetch(request) else { return [] }
        return favIngredient
    }
}
