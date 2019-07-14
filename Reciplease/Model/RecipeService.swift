//
//  RecipeService.swift
//  Reciplease
//
//  Created by Janin Culhaoglu on 09/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import Foundation

class RecipeService {

    private let edamamSession: EdemamProtocol
    init(edamamSession: EdemamProtocol = EdamamSession()) {
        self.edamamSession = edamamSession
    }

    func getRecipe(ingredientLists: [String],
                   completionHandler: @escaping (Bool, Welcome?) -> Void) {
        guard let urlWithKey = URL(string: edamamSession.urlWithKey + "q=" + ingredientLists.joined(separator:",")) else { return }
        edamamSession.request(url: urlWithKey) { response in
            switch response.result {
            case .success:
                guard let data = response.data, response.error == nil else {
                completionHandler(false, nil)
                return
                }
                guard let edamamResponse = try? JSONDecoder().decode(Welcome.self, from: data) else {
                completionHandler(false, nil)
                return
                }
//                print(ingredientLists)
//                print(urlWithKey)
                completionHandler(true, edamamResponse)
            case .failure:
                completionHandler(false, nil)
            }
        }
    }
}
