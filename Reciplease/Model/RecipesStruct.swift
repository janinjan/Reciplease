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
    let label: String
    let image: String
    let url: String
    let yield: Int
    let ingredientLines: [String]
    let totalTime: Int
}
