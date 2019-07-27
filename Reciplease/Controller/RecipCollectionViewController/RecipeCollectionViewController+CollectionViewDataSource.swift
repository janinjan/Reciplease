//
//  RecipeCollectionViewController+CollectionViewDataSource.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 25/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import UIKit

// MARK: - UICollectionViewDatasource
extension RecipeCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataRecipes.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell",
                                                            for: indexPath) as? RecipeListCollectionViewCell else {
                                                                return UICollectionViewCell()
        }
        cell.hit = dataRecipes[indexPath.row]

        return cell
    }
}
