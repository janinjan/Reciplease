//
//  UIViewController.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 20/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import UIKit

extension UIViewController {
    /**
     * enum for every error cases
     */
    enum AlertType {
        case noRecipeFound
        case addIngredient
        case removeIngredient
    }

    /**
     * Displays an alert with a custom message by using switch
     */
    func presentAlert(ofType type: AlertType) {
        var message: String
        var title: String

        switch type {
        case .noRecipeFound:
            title = "No recipe found"
            message = ""
        case .addIngredient:
            title = "Error"
            message = "Please add some ingredient to list"
        case .removeIngredient:
            title = "Error"
            message = "Please control ingredients name or remove one"
        }

        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
