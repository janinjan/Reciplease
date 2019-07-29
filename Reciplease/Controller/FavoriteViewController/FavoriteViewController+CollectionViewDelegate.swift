//
//  FavoriteViewController+CollectionViewDelegate.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 27/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import UIKit

extension FavoriteViewController: UICollectionViewDelegate {
    // If a cell is selected the trash icon is displayed, otherwise it remains hidden
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEditing {
            favoriteRecipes = [favoriteRecipes[indexPath.row]]
            performSegue(withIdentifier: segueToFavoriteDetailViewIdentifier, sender: self)
            navigationController?.setToolbarHidden(true, animated: true)
        } else {
            navigationController?.setToolbarHidden(false, animated: true)
        }
    }

    // If a cell is deselected and there are no other cells selected, the trash icon is hidden.
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if isEditing {
            if collectionView.indexPathsForSelectedItems!.count == 0 {
                navigationController?.setToolbarHidden(true, animated: true)
            }
        }
    }
}
