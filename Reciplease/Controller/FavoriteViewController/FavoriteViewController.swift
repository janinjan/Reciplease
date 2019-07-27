//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 14/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    // MARK: - Property
    var favoriteRecipes = RecipeEntity.fetchAll()

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var clearAllButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteRecipes = RecipeEntity.fetchAll()
        collectionView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteRecipes = RecipeEntity.fetchAll()
        collectionView.reloadData()
    }

    @IBAction func didTapClearAllButton(_ sender: Any) {
        RecipeEntity.deleteAll()
        favoriteRecipes = RecipeEntity.fetchAll()
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    // Cell Size
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = (view.frame.width - 30) / 2
        return CGSize(width: side, height: side)
    }

    // Item spacing (y axi)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
