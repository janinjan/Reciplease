//
//  EdamamSessionFake.swift
//  RecipleaseTests
//
//  Created by Janin Culhaoglu on 10/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import Foundation
import Alamofire
@testable import Reciplease

class EdamamSessionFake: EdemamProtocol {

    private let fakeResponse: FakeResponse

    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }

    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
        let error = fakeResponse.error
        let result: Result<Any>
        let urlRequest = URLRequest(url: URL(string: "https://google.fr")!)

        if let requestError = error {
            result = .failure(requestError)
        } else {
            result = .success("success")
        }

        completionHandler(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
    }
}
