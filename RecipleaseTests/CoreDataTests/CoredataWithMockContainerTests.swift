//
//  CoredataWithMockContainerTests.swift
//  RecipleaseTests
//
//  Created by Janin Culhaoglu on 03/08/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import XCTest
import CoreData
@testable import Reciplease

class CoredataWithMockContainerTests: XCTestCase {

    // MARK: - Properties

    lazy var mockContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Reciplease")
        container.loadPersistentStores(completionHandler: { (_, error) in
            XCTAssertNil(error)
        })
        return container
    }()

    // MARK: - Helper Methods

    override func setUp() {
        RecipeEntity.deleteAll(viewContext: mockContainer.viewContext)
    }

    private func addRecipeToFavorite(into managedObjectContext: NSManagedObjectContext) {
        let newRecipeInFavorite = RecipeEntity(context: managedObjectContext)
        newRecipeInFavorite.nameAtb = "Chicken, Lemon, And Dill With Orzo"
        newRecipeInFavorite.yieldAtb = "6"
        newRecipeInFavorite.urlAtb = "http://www.marthastewart.com/317393/chicken-lemon-and-dill-with-orzo"
    }

    private func addIngredientToFavorite(into managedObjectContext: NSManagedObjectContext) {
        let newIngredientInFavorite = IngredientEntity(context: managedObjectContext)
        newIngredientInFavorite.nameAtb = "4 cups low-sodium chicken broth"
    }

    // MARK: - Unit Tests

    func testAddThousandRecipesToFavoriteInPersistentContainer() {
        for _ in 0 ..< 1000 {
            addRecipeToFavorite(into: mockContainer.newBackgroundContext())
        }
        XCTAssertNoThrow(try mockContainer.newBackgroundContext().save())
    }

    func testDeleteAllFavoriteRecipesInPersistentContainer() {
        // Given
        addRecipeToFavorite(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        // When
        RecipeEntity.deleteAll(viewContext: mockContainer.viewContext)
        // Then
        XCTAssertEqual(RecipeEntity.fetchAll(viewContext: mockContainer.viewContext), [])
    }

    func testDeleteOneFavoriteRecipeInPersistentContainer() {
        // Given
        addRecipeToFavorite(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        // When
        RecipeEntity.delete(names: ["Chicken, Lemon, And Dill With Orzo"])
        // Then
        XCTAssertEqual(RecipeEntity.fetchAll(viewContext: mockContainer.viewContext), [])
    }

    func testRecipeAlreadyInFavoriteShouldReturnTrueIfAlreadyExist() {
        // Given
        addRecipeToFavorite(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        // When
        addRecipeToFavorite(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        // Then
        XCTAssertEqual(RecipeEntity.recipeAlreadyInFavorite(name: "Chicken, Lemon, And Dill With Orzo",
                                                            viewContext: mockContainer.viewContext), true)
    }

    func testRecipeAlreadyInFavoriteShouldReturnFalseIfEmptyList() {
        _ = RecipeEntity.fetchAll(viewContext: mockContainer.viewContext)
        XCTAssertFalse(RecipeEntity.recipeAlreadyInFavorite(name: "Chicken, Lemon, And Dill With Orzo",
                                                            viewContext: mockContainer.viewContext))
    }

    func testAddNewRecipeInFavoriteShouldNotReturnEmptyArray() {
        let label = "Chicken, Lemon, And Dill With Orzo"
        let ingredientLines = [
            "4 cups low-sodium chicken broth",
            "1 tablespoon unsalted butter",
            "1 1/4 teaspoons coarse salt",
            "1/4 teaspoon ground pepper",
            "1 pound chicken tenderloins, cut into 1-inch pieces",
            "1 pound orzo",
            "2 cups crumbled feta (4 ounces)",
            "1/4 cup coarsely chopped fresh dill",
            "2 teaspoons finely grated lemon zest, plus 1 tablespoon fresh lemon juice",
            "1 cup grated Parmesan"
        ]
        let yield = 6
        let totalTime = 0
        let image = "https://www.edamam.com/web-img/632/632e302a645d5baade2d351536f06cc5.jpg"
        let url = "http://www.marthastewart.com/317393/chicken-lemon-and-dill-with-orzo"

        let recipe = Recipe(label: label, image: image, url: url,
                            yield: yield, ingredientLines: ingredientLines, totalTime: totalTime)
        RecipeEntity.addRecipeToFavorite(recipe: recipe, viewContext: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        XCTAssertNotNil(RecipeEntity.fetchAll(viewContext: mockContainer.viewContext))
        XCTAssertNotEqual(RecipeEntity.fetchAll(viewContext: mockContainer.viewContext), [])
    }

    func testAddIngredientInFavoriteRecipe() {
        addIngredientToFavorite(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        XCTAssertNotNil(IngredientEntity.fetchAll(viewContext: mockContainer.viewContext))
    }
}
