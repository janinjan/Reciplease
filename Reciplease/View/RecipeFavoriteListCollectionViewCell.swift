//
//  RecipeFavoriteListCollectionViewCell.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 25/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import UIKit
/**
 * RecipeFavoriteListCollectionViewCell inherits from UICollectionViewCell class.
 It defines the favorite recipe list cell's elements
 */
class RecipeFavoriteListCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var recipeListImageView: UIImageView!
    @IBOutlet weak var recipeListLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var totalTimeImageView: UIImageView!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var recipeInfoStackView: UIStackView!
    @IBOutlet weak var checkImageView: UIImageView!

    // MARK: - Properties
    var favorite: RecipeEntity? { // Displays for FavoriteViewController
        didSet {
            guard let favorite = favorite else { return }
            recipeListLabel.text = favorite.nameAtb // Displays recipe's title

            guard let data = favorite.imageAtb else { return }
            recipeListImageView.image = UIImage(data: data) // Displays recipe's image

            guard let yield = favorite.yieldAtb else { return }
            yieldLabel.text = yield + " p" // Displays number of serving

            guard let time = favorite.durationAtb else { return }
            guard let intTime = Int(time) else { return }
            if intTime > 0 {
                totalTimeLabel.text = time + " min" // Displays recipe's total time
                totalTimeImageView.isHidden = false
            } else {
                totalTimeLabel.text = nil
                totalTimeImageView.isHidden = true
            }
        }
    }

    // Implement Editing Mode
    /**
     * A property observer is created which will toggle the visibility of the checkmark label
     according if the collection view controller is in editing mode or not.
     */
    var isInEditingMode: Bool = false {
        didSet {
            recipeInfoStackView.isHidden = isInEditingMode
            checkImageView.isHidden = !isInEditingMode
        }
    }
    // Another property observer is created which will display/remove the checkmark when the cell is selected or not.
    override var isSelected: Bool {
        didSet {
            if isInEditingMode {
                checkImageView.image = UIImage(named: isSelected ? "Checked" : "Unchecked")
                let bgColor = isSelected ? #colorLiteral(red: 0.9882352941, green: 0.2392156863, blue: 0.2235294118, alpha: 1) : #colorLiteral(red: 0.9764705882, green: 0.968627451, blue: 0.9647058824, alpha: 1)
                whiteView.backgroundColor = bgColor
            }
        }
    }

    // MARK: - Methods
    override func awakeFromNib() {
        addShadowsToCell()
    }

    // Add shadows and border to cells
    private func addShadowsToCell() {
        contentView.layer.cornerRadius = 8.0
        whiteView.layer.cornerRadius = 8.0
        recipeListImageView.layer.cornerRadius = 8.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.7
        layer.masksToBounds = false
    }

    // Add contrast to recipe image
    private func increaseContrast(_ image: UIImage) -> UIImage {
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
}
