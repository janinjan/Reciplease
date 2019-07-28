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

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var clearAllButton: UIBarButtonItem!

    // MARK: - Actions
    @IBAction func deleteButtonTapped(_ sender: UIBarButtonItem) {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        guard (try? AppDelegate.viewContext.fetch(request)) != nil else { return }
        if let selectedCells = collectionView.indexPathsForSelectedItems {
            // The selected cells will be reversed and sorted so the items with the highest index will be removed first.
            let items = selectedCells.map { $0.item }.sorted().reversed()
            // the items will be removed from the favoriteRecipes array
            for item in items {
                self.favoriteRecipes.remove(at: item)
            }
            // The selected cells will be deleted from the Collection View Controller and the trash icon will be hidden
            collectionView.deleteItems(at: selectedCells)
            navigationController?.setToolbarHidden(true, animated: true)
            collectionView.reloadData()
            try? AppDelegate.viewContext.save()
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteRecipes = RecipeEntity.fetchAll()
        collectionView.reloadData()
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
