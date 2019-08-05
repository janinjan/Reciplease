//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 14/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {

    // MARK: - Properties

    var favoriteRecipes = RecipeEntity.fetchAll()
    var favoriteRecipe: RecipeEntity?
    let segueToFavoriteDetailViewIdentifier = "segueFromFavToDetailVC"
    var isInFavorite: Bool = false
    var recipesNames = [String]()

    // MARK: - Outlets

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var clearAllButton: UIBarButtonItem!

    // MARK: - Actions

    @IBAction func deleteButtonTapped(_ sender: UIBarButtonItem) {
        if let selectedCellsIndex = collectionView.indexPathsForSelectedItems {
            let items = selectedCellsIndex.map { $0.item }.sorted().reversed()
            for item in items {
                guard let name = favoriteRecipes[item].nameAtb else { return }
                recipesNames.append(name) // Add recipe's name to names array
                favoriteRecipes.remove(at: item) // Remove items from favoriteRecipes array
            }
            collectionView.deleteItems(at: selectedCellsIndex) // Delete selected cells from CollectionVC
            RecipeEntity.delete(names: recipesNames) // Delete selected recipes stored in CoreData
            collectionView.reloadData()
            recipesNames = []
            navigationController?.setToolbarHidden(true, animated: true) // Hide the trash icon
        }
    }

    @IBAction func didTapClearAllButton(_ sender: Any) {
        RecipeEntity.deleteAll()
        favoriteRecipes = RecipeEntity.fetchAll()
        collectionView.reloadData()
    }

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isToolbarHidden = true // Toolbar with Trash icon is hidden
        navigationItem.leftBarButtonItem = editButtonItem // Add Edit Button item in navigation bar
        favoriteRecipes = RecipeEntity.fetchAll()
        collectionView.reloadData()
        self.navigationController?.navigationBar.tintColor = .orangeRed
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToFavoriteDetailViewIdentifier {
            if let destination = segue.destination as? RecipeDetailsViewController {
                destination.recipeDetailsIsAskedFromFavorite = true
                destination.favoriteRecipe = favoriteRecipe // Perfom is in FavoriteVCDelegate extension
            }
        }
    }

    // This method will check if a cell is in editing mode
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        clearAllButton.isEnabled = !editing
        collectionView.allowsMultipleSelection = editing // select multiple cells
        let indexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in indexPaths {
            collectionView.deselectItem(at: indexPath as IndexPath, animated: false)
            let cell = collectionView!.cellForItem(at: indexPath) as? RecipeFavoriteListCollectionViewCell
            cell!.isInEditingMode = editing
        }
    }
}

// =========================================
// MARK: - CollectionView Delegate FlowLayout
// =========================================

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    // Defines the Cell Size
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

// =========================================
// MARK: - CollectionView data source
// =========================================

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
        favoriteCell.isInEditingMode = isEditing
        return favoriteCell
    }
}

// =========================================
// MARK: - CollectionView delegate
// =========================================

extension FavoriteViewController: UICollectionViewDelegate {
    // If a cell is selected the trash icon is displayed, otherwise it remains hidden
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEditing {
            favoriteRecipe = favoriteRecipes[indexPath.row]
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
