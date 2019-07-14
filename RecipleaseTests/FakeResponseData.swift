//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Janin Culhaoglu on 10/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import Foundation

class FakeResponseData {
    //Response
    static let responseOK = HTTPURLResponse(url: URL(string: "https://www.openclassrooms.com")!,
                                            statusCode: 200,
                                            httpVersion: nil,
                                            headerFields: nil)
    static let responseKO = HTTPURLResponse(url: URL(string: "https://www.openclassrooms.com")!,
                                            statusCode: 500,
                                            httpVersion: nil,
                                            headerFields: nil)
    //Data
    static var correctData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Recipe", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let incorrectData = "erreur".data(using: .utf8)
    //Error
    class NetworkError: Error {}
    static let networkError = NetworkError()
}
