//
//  RecipeDetailsViewController+CollectionViewDataSource.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 25/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import UIKit

extension RecipeDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipeDetails = recipe?.ingredientLines else { return 0 }
        return recipeDetails.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        guard let recipeDetails = recipe else { return UITableViewCell() }
        let ingredient = "- " + recipeDetails.ingredientLines[indexPath.row]
        cell.textLabel?.text = ingredient
        return cell
    }
}
