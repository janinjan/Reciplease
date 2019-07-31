//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 20/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var recipeDetailImageView: UIImageView!
    @IBOutlet weak var recipeListLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var totalTimeImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var favoriteButton: FavoriteButton!

    // MARK: - Properties
    var recipe: Recipe?
    var favoriteRecipes = RecipeEntity.fetchAll()
    var recipeDetailsIsAskedFromFavorite: Bool = false

    // MARK: - Actions
    @IBAction func didTapGetDirections(_ sender: Any) {
        guard let currentRecipeUrl = recipe?.url else { return }
        guard let url = URL(string: currentRecipeUrl) else { return }
        UIApplication.shared.open(url) // Open recipe directions in Safari
    }

    @IBAction func didTapFavoriteButton(_ sender: Any) {
        if favoriteButton.isOn {
            controlAndAddFavorite()
        } else {
            RecipeEntity.delete(names: [recipe!.label])
        }
    }

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        if recipeDetailsIsAskedFromFavorite {
            favoriteButton.isHidden = true
            displayFavoriteRecipeInformation()
        } else {
            if RecipeEntity.recipeAlreadyInFavorite(name: recipe!.label) {
                favoriteButton.activateButton(bool: true)
            }
            favoriteButton.isHidden = false
            displayRecipesInformation()
        }
        tableView.tableFooterView = UIView() // UIKit does not create the empty rows when the
        // table has a footer view displayed below the table cells.
        getDirectionButton.layer.cornerRadius = 6
        recipeDetailImageView.layer.cornerRadius = 6
    }

    private func controlAndAddFavorite() {
        if RecipeEntity.recipeAlreadyInFavorite(name: recipe!.label) {
            presentAlert(ofType: .alreadyInFavorite) // Present alert if recipe in already in favorite
        } else {
            RecipeEntity.addRecipeToFavorite(recipe: recipe!)
        }
    }

    private func displayRecipesInformation() {
        recipeListLabel.text = recipe?.label

        guard let time = recipe?.totalTime else { return }
        if time > 0 {
            totalTimeLabel.text = String(recipe!.totalTime) + " min" // Displays recipe's total time
            totalTimeImageView.isHidden = false
        } else {
            totalTimeLabel.text = nil
            totalTimeImageView.isHidden = true
        }

        guard let yield = recipe?.yield else { return }
        yieldLabel.text = String(yield) + " people"

        guard let currentRecipeURL = recipe?.image else { return }
        guard let url = URL(string: currentRecipeURL) else { return }
        if let data = try? Data(contentsOf: url) {
            guard let image = UIImage(data: data as Data) else { return }
            recipeDetailImageView.image = image
        }
    }

    private func displayFavoriteRecipeInformation() {
        recipeListLabel.text = favoriteRecipes[0].nameAtb

        guard let time = favoriteRecipes[0].durationAtb else { return }
        guard let recipeIntTime = Int(time) else { return }
        displayTime(recipeIntTime)

        guard let yield = favoriteRecipes[0].yieldAtb else { return }
        yieldLabel.text = String(yield) + " people"

        guard let data = favoriteRecipes[0].imageAtb else { return }
        recipeDetailImageView.image = UIImage(data: data) // Displays recipe's image
    }

    // Displays recipe total time
    private func displayTime(_ recipeTime: Int) {
        if  recipeTime > 0 { // Display recipe total time if it is upper than 0
            totalTimeLabel.text = String(recipeTime) + " min"
            totalTimeImageView.isHidden = false
        } else {
            totalTimeLabel.text = nil
            totalTimeImageView.isHidden = true
        }
    }
}

// =========================================
// MARK: - NavigationController Delegate
// =========================================
extension RecipeDetailsViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController, animated: Bool) {
        if viewController is RecipeCollectionViewController {
            if RecipeEntity.recipeAlreadyInFavorite(name: recipe!.label) {
                print("the recipe" + recipe!.label + "is in favorite")
                favoriteButton.activateButton(bool: true)
            }
        }
    }
}

// =========================================
// MARK: - TableView data source
// =========================================
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
