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
    let label: String // "Chicken Vesuvio"
    let image: String // "https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg"
    let source: String // "Serious Eats"
    let url: String // "http://www.seriouseats.com/recipes/2011/12/chicken-vesuvio-recipe.html"
//    let shareAs: String
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

//// MARK: - Digest
//struct Digest: Codable {
//    let label, tag: String
//    let schemaOrgTag: String?
//    let total: Double
//    let hasRDI: Bool
//    let daily: Double
//    let unit: Unit
//    let sub: [Digest]?
//}

//enum Unit: String, Codable {
//    case empty = "%"
//    case g = "g"
//    case iu = "IU"
//    case kcal = "kcal"
//    case mg = "mg"
//    case µg = "µg"
//}

// MARK: - Ingredient
struct Ingredient: Decodable {
    let text: String
//    let weight: Double
}

//// MARK: - Total
//struct Total: Codable {
//    let label: String
//    let quantity: Double
//    let unit: Unit
//}
//
//// MARK: - Params
//struct Params: Codable {
//    let sane: [JSONAny]
//    let q, from, appKey, to: [String]
//    let appID: [String]
//
//    enum CodingKeys: String, CodingKey {
//        case sane, q, from
//        case appKey = "app_key"
//        case to
//        case appID = "app_id"
//    }
//}
