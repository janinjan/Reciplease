//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 29/06/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    let recipeService = RecipeService()

    // MARK: - Outlets
    @IBOutlet weak var whatInFridgeLabelConstraint: NSLayoutConstraint! // outlet for UIView animation

    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    var ingredientsList = [String]()

    @IBAction func addIngredient(_ sender: Any) {
        getIngredientName()
        tableView.reloadData()
        ingredientTextField.text = ""
    }

    @IBAction func searchRecipes(_ sender: Any) {
        getRecipes()
    }

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        whatInFridgeLabelConstraint.constant -= view.bounds.width
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseInOut, animations: {
            self.whatInFridgeLabelConstraint.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    func getIngredientName() {
        guard let enteredText = ingredientTextField.text else { return }
        ingredientsList.append(enteredText)
    }

    @IBAction func dismissKeyboard(_ sender: Any) {
        ingredientTextField.resignFirstResponder()
    }

    func getRecipes() {
        recipeService.getRecipe(ingredientLists: ingredientsList) { (success, data) in
            if let data = data, success {
                print(data.hits)
            } else {
                print("ooooh")
            }
        }
    }
}

extension SearchViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        let ingredient = ingredientsList[indexPath.row]
        cell.textLabel?.text = ingredient
//        cell.contentView.backgroundColor = UIColor(red: 133/255, green: 239/255, blue: 71/255, alpha: 1)
//        cell.backgroundColor = UIColor(red: 133/255, green: 239/255, blue: 71/255, alpha: 1)
        return cell
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        ingredientsList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
