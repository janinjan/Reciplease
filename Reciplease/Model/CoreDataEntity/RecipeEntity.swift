//
//  RecipeEntity.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 24/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import Foundation
import CoreData

class RecipeEntity: NSManagedObject {
    static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [RecipeEntity] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        guard let favoriteRecipes = try? viewContext.fetch(request) else { return [] }
        return favoriteRecipes
    }

    static func deleteAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        RecipeEntity.fetchAll(viewContext: viewContext).forEach({ viewContext.delete($0) })
        try? viewContext.save()
    }

    static func addRecipeToFavorite(viewContext: NSManagedObjectContext = AppDelegate.viewContext, hit: Hit) {
        let favRecipe = RecipeEntity(context: viewContext)
        favRecipe.nameAtb = hit.recipe.label
        favRecipe.durationAtb =  String(hit.recipe.totalTime)
        favRecipe.yieldAtb = String(hit.recipe.yield)

        let image = hit.recipe.image
        guard let imageURL = URL(string: image) else { return }
        favRecipe.imageAtb = try? Data(contentsOf: imageURL)
        try? viewContext.save()
    }
}
