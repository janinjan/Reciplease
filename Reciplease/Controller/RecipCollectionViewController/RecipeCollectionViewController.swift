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
    var currentRecipe: Recipe?
    let segueToDetailViewIdentifier = "segueToDetailVC"
    var isInFavorite: Bool = false

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToDetailViewIdentifier {
            if let destination = segue.destination as? RecipeDetailsViewController {
                destination.isInFavorite = false
                destination.recipe = currentRecipe // Perfom is in RecipeControllerViewDelegate extension
            }
        }
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

// MARK: - Implement protocol RecipeCellDelegate defines in RecipeListCollectionViewCell
/**
 * extension of view controller that adopts the protocol in order to conform to the layout defined in RecipeCellDelegate
 */
extension RecipeCollectionViewController: RecipeCellDelegate {
    func addFavorite(cell: RecipeListCollectionViewCell) { // Add to favorite if favButton isOn
        guard let hit = cell.hit else { return }
        RecipeEntity.addRecipeToFavorite(hit: hit)
    }

    func deleteFavorite(cell: RecipeListCollectionViewCell) { // Remove from favorite if favButton !isOn
        guard let hit = cell.hit else { return }
        RecipeEntity.delete(names: [hit.recipe.label])
    }
}
