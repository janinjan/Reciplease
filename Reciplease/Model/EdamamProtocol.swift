//
//  EdamamProtocol.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 09/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import Foundation
import Alamofire

protocol EdemamProtocol {
    var urlWithKey: String { get }
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void)
}

extension EdemamProtocol {
    var urlWithKey: String {
        return "https://api.edamam.com/search?app_id=4c5fc873&app_key=5d33c99c8d4522a29dae7bd158098b54&"
    }
}
