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

    static func delete(names: [String], viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        for name in names {
            request.predicate = NSPredicate(format: "nameAtb = %@", name)
            guard let favoriteRecipes = try? viewContext.fetch(request) else { return }
            guard let recipe = favoriteRecipes.first else { return }
            viewContext.delete(recipe)
        }
        try? viewContext.save()
    }

    static func addRecipeToFavorite(hit: Hit, viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        let favRecipe = RecipeEntity(context: viewContext)
        favRecipe.nameAtb = hit.recipe.label
        favRecipe.durationAtb =  String(hit.recipe.totalTime)
        favRecipe.yieldAtb = String(hit.recipe.yield)

        let image = hit.recipe.image
        guard let imageURL = URL(string: image) else { return }
        favRecipe.imageAtb = try? Data(contentsOf: imageURL)

        let ingredient = IngredientEntity(context: viewContext)
        ingredient.nameAtb = hit.recipe.ingredientLines[0]
        ingredient.recipe = favRecipe

        try? viewContext.save()
    }

    // If a recipe is already in favorite, function returns true
    static func recipeAlreadyInFavorite(name: String,
                                        viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> Bool {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "nameAtb = %@", name)
        guard let favoriteRecipe = try? viewContext.fetch(request) else { return false }
        if favoriteRecipe.isEmpty {
            return false
        }
        return true
    }
}
