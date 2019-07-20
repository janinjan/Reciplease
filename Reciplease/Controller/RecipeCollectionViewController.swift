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

        cell.recipeListLabel.text = dataRecipes[indexPath.row].recipe.label
        cell.yieldLabel.text = String(dataRecipes[indexPath.row].recipe.yield) + " people"
        // Displays recipe's total time
        let recipeTotalTime = dataRecipes[indexPath.row].recipe.totalTime
        cell.displayTime(recipeTotalTime)
        // Displays recipe's image
        let imageURL = dataRecipes[indexPath.row].recipe.image
        cell.convertUrlToImage(imageURL)

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
