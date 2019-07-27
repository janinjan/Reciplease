//
//  RecipeCollectionViewController+CollectionViewDelegate.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 25/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import UIKit

// MARK: - UICollectionViewDelegate
extension RecipeCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentRecipe = dataRecipes[indexPath.row].recipe
        performSegue(withIdentifier: segueToDetailViewIdentifier, sender: self)
    }
}
