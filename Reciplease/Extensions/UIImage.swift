//
//  UIImage.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 05/08/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import UIKit

extension UIImage {

    /// Add contrast to recipe image
    public class func increaseContrast(_ image: UIImage) -> UIImage? {
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
