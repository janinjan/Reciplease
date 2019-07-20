//
//  RecipeListCollectionViewCell.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 14/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import UIKit

class RecipeListCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var recipeListImageView: UIImageView!
    @IBOutlet weak var recipeListLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var totalTimeImageView: UIImageView!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var ingredientLabel: UILabel!

    // MARK: - Methods
    // Add shadows and border to cells
    func addShadowsToCell() {
        contentView.layer.cornerRadius = 8.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }

    // Add contrast to recipe image
    func increaseContrast(_ image: UIImage) -> UIImage {
        guard let inputImage = CIImage(image: image) else { return UIImage() }
        let parameters = [
            "inputContrast": NSNumber(value: 1.05),
            "inputSaturation": NSNumber(value: 1.05)
        ]
        let outputImage = inputImage.applyingFilter("CIColorControls", parameters: parameters)

        let context = CIContext(options: nil)
        guard let img = context.createCGImage(outputImage, from: outputImage.extent) else { return UIImage() }
        return UIImage(cgImage: img)
    }

    // Displays recipe total time
    func displayTime(_ recipeTime: Int) {
        if  recipeTime > 0 { // Display recipe total time if it is upper than 0
            totalTimeLabel.text = String(recipeTime) + " min"
            totalTimeImageView.isHidden = false
        } else {
            totalTimeLabel.text = nil
            totalTimeImageView.isHidden = true
        }
    }

    // Convert String URL to UIImage
    func convertUrlToImage(_ imageUrl: String) {
        guard let url = URL(string: imageUrl) else { return }
        if let data = try? Data(contentsOf: url) {
            guard let image = UIImage(data: data as Data) else { return }  // Convert url to image
            let constratedImage = self.increaseContrast(image)
            self.recipeListImageView.image = constratedImage // Add contrast to recipe image
        }
    }
}
