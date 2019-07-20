//
//  ApiKeys.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 18/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import Foundation

func valueForAPIKey(named keyname: String) -> String {
    let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
    let plist = NSDictionary(contentsOfFile: filePath!)
    let value = plist?.object(forKey: keyname) as? String ?? ""
    return value
}
