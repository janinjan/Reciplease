//
//  RecipeCollectionViewController.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 14/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import UIKit

class RecipeCollectionViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Properties
    var dataRecipes = [Hit]()

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension RecipeCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataRecipes.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell",
                                                            for: indexPath) as? RecipeListCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.addShadowsToCell() // Add Shadows to cell

        let recipTitle = dataRecipes[indexPath.row].recipe.label
        let recipeTotalTime = dataRecipes[indexPath.row].recipe.totalTime
        let recipYield = String(dataRecipes[indexPath.row].recipe.yield)
        let recipImage = dataRecipes[indexPath.row].recipe.image
        let recipIngredient = dataRecipes[indexPath.row].recipe.ingredientLines

        cell.recipeListLabel.text = recipTitle // Displays recipe's title
        cell.yieldLabel.text = recipYield + " people" // Displays number of serving
        cell.displayTime(recipeTotalTime)  // Displays recipe's total time
        cell.convertUrlToImage(recipImage) // Displays recipe's image
        cell.ingredientLabel.text = recipIngredient.joined(separator: ", ")

        return cell
    }
}

    // MARK: - UICollectionViewDelegateFlowLayout
    extension RecipeCollectionViewController: UICollectionViewDelegateFlowLayout {
        // Cell Size
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            let side = (view.frame.width - 30)
            return CGSize(width: side, height: 258)
        }
}
