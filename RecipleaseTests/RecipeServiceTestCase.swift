//
//  RecipeServiceTestCase.swift
//  RecipleaseTests
//
//  Created by Janin Culhaoglu on 10/07/2019.
//  Copyright © 2019 Janin Culhaoglu. All rights reserved.
//

import XCTest
@testable import Reciplease
import Alamofire

class RecipeServiceTestCase: XCTestCase {

    func testGetRecipeShouldPostFailedCallbackIfError() {
        //Given
        let fakeResponse = FakeResponse(response: nil,
                                        data: nil,
                                        error: FakeResponseData.networkError)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(edamamSession: edamamSessionFake)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipe(ingredientLists: ["chocolate"]) { (success, recipe) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipeShouldPostFailedCallbackIfNoData() {
        //Given
        let fakeResponse = FakeResponse(response: nil,
                                        data: nil,
                                        error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(edamamSession: edamamSessionFake)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipe(ingredientLists: ["chocolate"]) { (success, recipe) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipeShouldPostFailedCallbackIfIncorrectData() {
        //Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK,
                                        data: FakeResponseData.incorrectData,
                                        error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let recipeSevice = RecipeService(edamamSession: edamamSessionFake)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeSevice.getRecipe(ingredientLists: ["chocolate"]) { (success, recipe) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
//    func testGetRecipeShouldPostFailedCallbackIfResponseKO() {
//        //Given
//        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO,
//                                        data: FakeResponseData.correctData,
//                                        error: nil)
//        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
//        let recipeService = RecipeService(edamamSession: edamamSessionFake)
//        //When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        recipeService.getRecipe(ingredientLists: ["chocolate"]) { (success, recipe) in
//            //Then
//            XCTAssertFalse(success)
//            XCTAssertNil(recipe)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }

    func testGetRecipeShouldPostFailedCallbackIfResponseCorrectAndNilData() {
        //Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK,
                                        data: nil,
                                        error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(edamamSession: edamamSessionFake)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipe(ingredientLists: ["chocolate"]) { (success, recipe) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipShouldPostSuccessCallbackIfNoErrorWithCorrectData() {
        //Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK,
                                        data: FakeResponseData.correctData,
                                        error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(edamamSession: edamamSessionFake)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipe(ingredientLists: ["chocolate"]) { (success, recipe) in
            //Then
            XCTAssertNotNil(recipe)
            XCTAssertTrue(success)
            XCTAssertEqual(recipe?.hits[0].recipe.label, "Chicken, Lemon, And Dill With Orzo")
            XCTAssertEqual(recipe?.hits[0].recipe.yield, 6)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
