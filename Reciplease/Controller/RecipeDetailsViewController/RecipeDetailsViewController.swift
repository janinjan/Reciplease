//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 20/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController {

    // MARK: - Properties
    var recipe: Recipe?

    @IBOutlet weak var recipeDetailImageView: UIImageView!
    @IBOutlet weak var recipeListLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var totalTimeImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var getDirectionButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        displayRecipesInformation()
        tableView.reloadData()
        tableView.tableFooterView = UIView() // UIKit does not create the empty rows when the
        // table has a footer view displayed below the table cells.
        getDirectionButton.layer.cornerRadius = 6
        recipeDetailImageView.layer.cornerRadius = 6
    }

    @IBAction func didTapGetDirections(_ sender: Any) {
        guard let currentRecipeUrl = recipe?.url else { return }
        guard let url = URL(string: currentRecipeUrl) else { return }
        UIApplication.shared.open(url) // Open recipe directions in Safari
    }

    func displayRecipesInformation() {
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
}
