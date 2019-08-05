//
//  RecipeService.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 09/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import Foundation

class RecipeService {

    // MARK: - Properties

    private let edamamSession: EdemamProtocol
    // ID and Key for Edamam Search API
    let appID = valueForAPIKey(named: "app_id")
    let appKey = valueForAPIKey(named: "app_key")

    // MARK: - Inits

    init(edamamSession: EdemamProtocol = EdamamSession()) {
        self.edamamSession = edamamSession
    }

    // MARK: - Methods
    /**
     * API Call, Edamam Search request with Alamofire
     */
    func getRecipe(ingredientLists: [String],
                   completionHandler: @escaping (Bool, Welcome?) -> Void) {

        let baseURL = "https://api.edamam.com/search?app_id=\(appID)&app_key=\(appKey)"
        let searchURL = baseURL + "&q=" + ingredientLists.joined(separator: ",")
        guard let urlWithKey = URL(string: searchURL) else { return }

        edamamSession.request(url: urlWithKey) { response in
            switch response.result {
            case .success:
                guard response.response?.statusCode == 200 else {
                    completionHandler(false, nil)
                    return
                }
                guard let data = response.data, response.error == nil else {
                    completionHandler(false, nil)
                    return
                }
                guard let edamamResponse = try? JSONDecoder().decode(Welcome.self, from: data) else {
                    completionHandler(false, nil)
                    return
                }
                completionHandler(true, edamamResponse)
            case .failure:
                completionHandler(false, nil)
            }
        }
    }
}
