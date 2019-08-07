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
        self.navigationController?.navigationBar.tintColor = .orangeRed
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToDetailViewIdentifier {
            if let destination = segue.destination as? RecipeDetailsViewController {
                destination.recipeDetailsIsAskedFromFavorite = false
                destination.recipe = currentRecipe // Perfom is in RecipeControllerViewDelegate extension
            }
        }
    }
}

// =========================================
// MARK: - CollectionView Delegate FlowLayout
// =========================================

extension RecipeCollectionViewController: UICollectionViewDelegateFlowLayout {
    // Cell Size
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = (view.frame.width - 30)
        return CGSize(width: side, height: 258)
    }
}

// =========================================
// MARK: - Implement protocol RecipeCellDelegate
// =========================================

extension RecipeCollectionViewController: RecipeCellDelegate { // protocol defines in RecipListCollectionViewCell
    func addFavorite(cell: RecipeListCollectionViewCell) { // Add to favorite if favButton isOn
        guard let recipe = cell.hit?.recipe else { return }
        if RecipeEntity.recipeAlreadyInFavorite(name: recipe.label) {
            presentAlert(ofType: .alreadyInFavorite) // Present alert if recipe in already in favorite
        } else {
            RecipeEntity.addRecipeToFavorite(recipe: recipe) // Add recipe to favorite
        }
    }

    func deleteFavorite(cell: RecipeListCollectionViewCell) { // Remove from favorite if favButton !isOn
        guard let hit = cell.hit else { return }
        RecipeEntity.delete(names: [hit.recipe.label])
    }
}

// =========================================
// MARK: - CollectionView data source
// =========================================

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
        cell.delegate = self
        cell.hit = dataRecipes[indexPath.row]

        return cell
    }
}

// =========================================
// MARK: - CollectionView delegate
// =========================================

extension RecipeCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentRecipe = dataRecipes[indexPath.row].recipe
        performSegue(withIdentifier: segueToDetailViewIdentifier, sender: self)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        let translationMovement = CATransform3DTranslate(CATransform3DIdentity, 0, 10, 0)
        cell.layer.transform = translationMovement
        cell.alpha = 0
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
}
