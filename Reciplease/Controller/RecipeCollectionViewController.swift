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
        cell.recipeListLabel.text = dataRecipes[indexPath.row].recipe.label
        cell.yieldLabel.text = String(dataRecipes[indexPath.row].recipe.yield) + " people"

        cell.addShadowsToCell() // Add Shadows to cell

        let recipeTotalTime = dataRecipes[indexPath.row].recipe.totalTime
        if  recipeTotalTime > 0 { // Display recipe total time if it is upper than 0
            cell.totalTimeLabel.text = String(recipeTotalTime) + " min"
            cell.totalTimeImageView.isHidden = false
        } else {
            cell.totalTimeLabel.text = nil
            cell.totalTimeImageView.isHidden = true
        }

        let imageURL = dataRecipes[indexPath.row].recipe.image
        if let url = URL(string: imageURL) {
            if let data = NSData(contentsOf: url) {
                guard let image = UIImage(data: data as Data) else {  // Convert url to image
                    return UICollectionViewCell()
                }
                let constratedImage = cell.increaseContrast(image)
                cell.recipeListImageView.image = constratedImage // Add contrast to recipe image
            }
        }
        return cell
    }
}
