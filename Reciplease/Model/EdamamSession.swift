//
//  EdamamSession.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 09/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import Foundation
import Alamofire

class EdamamSession: EdemamProtocol {
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).validate().responseJSON { response in
            completionHandler(response)
        }
    }
}
