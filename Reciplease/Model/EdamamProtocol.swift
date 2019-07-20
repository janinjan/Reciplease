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
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void)
}
