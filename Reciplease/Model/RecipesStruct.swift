//
//  RecipesStruct.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 09/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.

import Foundation

// MARK: - Welcome
struct Welcome: Decodable {
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Decodable {
    let recipe: Recipe
}

// MARK: - Recipe
struct Recipe: Decodable {
    let uri: String
    let label: String
    let image: String
    let source: String
    let url: String
    let yield: Int
    let dietLabels: [String]
    let healthLabels: [String]
    let cautions: [String]
    let ingredientLines: [String]
    let ingredients: [Ingredient]
//    let calories, totalWeight: Double
    let totalTime: Int
//    let totalNutrients, totalDaily: [String: Total]
//    let digest: [Digest]
}

// MARK: - Ingredient
struct Ingredient: Decodable {
    let text: String
//    let weight: Double
}
