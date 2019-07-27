//
//  FavoriteViewController+CollectionViewDataSource.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 25/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import UIKit

extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if favoriteRecipes.count == 0 {
            collectionView.setEmptyMessage("Add recipes to favorite")
        } else {
            collectionView.restore()
        }
        return favoriteRecipes.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let favoriteCell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath)
            as? RecipeFavoriteListCollectionViewCell else { return UICollectionViewCell() }
        favoriteCell.favorite = favoriteRecipes[indexPath.row]

        return favoriteCell
    }
}
