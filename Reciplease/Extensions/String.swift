//
//  String.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 09/08/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import UIKit

extension String {

    var isBlank: Bool {
        return self.trimmingCharacters(in: .alphanumerics) == String() ? true : false
    }
}
