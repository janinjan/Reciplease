//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 29/06/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var whatInFridgeLabelConstraint: NSLayoutConstraint! // outlet for UIView animation
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var clearButton: UIBarButtonItem!
    @IBOutlet weak var searchRecipesButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    let recipeService = RecipeService()
    var ingredientsList = [String]() {
        didSet { // Show "Clear" bar button item if ingredientList is not empty
            if ingredientsList.count > 0 {
                toggleNavigationButtonItem(shown: true, tintColor: #colorLiteral(red: 0.2470588235, green: 0.5843137255, blue: 0.9921568627, alpha: 1))
            } else {
                toggleNavigationButtonItem(shown: false, tintColor: .clear)
            }
        }
    }
    var dataRecipes = [Hit]()
    let segueToCVidentifier = "segueToRecipesList"

    // MARK: - Actions
    @IBAction func addIngredient(_ sender: Any) {
        getIngredientName()
        tableView.reloadData()
        ingredientTextField.text = ""
        ingredientTextField.resignFirstResponder()
    }

    @IBAction func clearIngredient(_ sender: Any) {
        if activityIndicator.isAnimating {
            toggleActivityIndicator(shown: false)
        }
        ingredientsList.removeAll()
        tableView.reloadData()
    }

    @IBAction func searchRecipes(_ sender: Any) {
        getRecipes()
    }

    @IBAction func dismissKeyboard(_ sender: Any) {
        ingredientTextField.resignFirstResponder()
    }

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        searchRecipesButton.layer.cornerRadius = 6
        searchView.layer.cornerRadius = 6
        addButton.layer.cornerRadius = 4
        ingredientTextField.delegate = self
        toggleNavigationButtonItem(shown: false, tintColor: .clear) // hide clear bar button item
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        whatInFridgeLabelConstraint.constant -= view.bounds.width
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
            self.whatInFridgeLabelConstraint.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    private func toggleNavigationButtonItem(shown: Bool, tintColor: UIColor) {
        clearButton.isEnabled = shown
        clearButton.tintColor = tintColor
    }

    private func toggleActivityIndicator(shown: Bool) {
        searchRecipesButton.isHidden = shown
        activityIndicator.isHidden = !shown
    }

    private func getIngredientName() {
        guard let enteredText = ingredientTextField.text else { return }
        if enteredText == "" || enteredText == " " || enteredText == "." {
            print("nothing to add")
        } else {
            let formattedEnteredText = enteredText.replacingOccurrences(of: " ", with: "")
            ingredientsList.append(formattedEnteredText)
        }
    }

    private func getRecipes() {
        toggleActivityIndicator(shown: true)
        // Controls that ingredients list array is not empty
        guard !ingredientsList.isEmpty else {
            presentAlert(ofType: .addIngredient)
            toggleActivityIndicator(shown: false)
            return
        }
        // Get recipes list
        recipeService.getRecipe(ingredientLists: ingredientsList) { (success, data) in
            if let data = data, success {
                self.toggleActivityIndicator(shown: false)
                self.dataRecipes = data.hits
                if self.dataRecipes.isEmpty { // If ingredient entered name is invalid, data from API call is empty
                    self.presentAlert(ofType: .removeIngredient)
                } else {
                    self.performToCollectionView()
                }
            } else {
                self.presentAlert(ofType: .noRecipeFound)
                self.toggleActivityIndicator(shown: false)
            }
        }
    }
}

// MARK: - Segue to CollectionView
extension SearchViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToCVidentifier {
            guard let collectionVC = segue.destination as? RecipeCollectionViewController else { return }
            collectionVC.dataRecipes = dataRecipes
        }
    }

    func performToCollectionView() {
        if !ingredientsList.isEmpty {
            self.performSegue(withIdentifier: segueToCVidentifier, sender: SearchViewController.self)
        }
    }
}

// MARK: - UITextFieldDelegate Dismiss keyboard
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        addIngredient(self)
        return true
    }
}
