//
//  RecipeCollectionViewController.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 14/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import UIKit

class RecipeCollectionViewController: UIViewController {

    var imagesRecipeArray = [String]()
    var titlesRecipeArray = [String]()
    var yieldsRecipeArray = [Int]()
    var totalTimesArray = [Int]()
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension RecipeCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titlesRecipeArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeListCollectionViewCell
        cell.recipeListLabel.text = titlesRecipeArray[indexPath.row]
        cell.yieldLabel.text = String(yieldsRecipeArray[indexPath.row]) + " people"
        if totalTimesArray[indexPath.row] > 0 {
            cell.totalTimeLabel.text = String(totalTimesArray[indexPath.row]) + " min"
            cell.totalTimeImageView.isHidden = false
        } else {
            cell.totalTimeLabel.text = nil
            cell.totalTimeImageView.isHidden = true
        }
        
        let imageURL = imagesRecipeArray[indexPath.row]
        if let url = URL(string: imageURL) {
            if let data = NSData(contentsOf: url) {
                guard let image = UIImage(data: data as Data) else { return UICollectionViewCell() }
                let constratedImage = increaseContrast(image)
                cell.recipeListImageView.image = constratedImage
            }
        }
        
        //This creates the shadows and modifies the cards a little bit
        cell.contentView.layer.cornerRadius = 8.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    
    // Add contrast to recipe image
    func increaseContrast(_ image: UIImage) -> UIImage {
        let inputImage = CIImage(image: image)!
        let parameters = [
            "inputContrast": NSNumber(value: 1.05),
            "inputSaturation": NSNumber(value: 1.05)
        ]
        let outputImage = inputImage.applyingFilter("CIColorControls", parameters: parameters)

        let context = CIContext(options: nil)
        let img = context.createCGImage(outputImage, from: outputImage.extent)!
        return UIImage(cgImage: img)
    }
}
