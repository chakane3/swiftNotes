//
//  RecipiesTests.swift
//  RecipiesTests
//
//  Created by Chakane Shegog on 12/22/21.
//

import XCTest
@testable import Recipies

class RecipiesTests: XCTestCase {
    
    // This test checks out our network connection
    func testSearchChristmasCookies() {
        
        // arrange
        // come up with a possible search query such as Chicken, or Beef, etc
        // addingPercentEncoding makes encodes the query (i.e spaces) to make it "url friendly"
        let searchQuery = "tacos".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let exp = XCTestExpectation(description: "search found")
        let recipeEndpoint = "https://api.edamam.com/search?q=\(searchQuery)&app_id=\(SecretKey.appID)&app_key=\(SecretKey.appKey)&from0&to=50"
        
        let request = URLRequest(url: URL(string: recipeEndpoint)!)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case.failure(let appError):
                XCTFail("app error: \(appError)")
            
            case .success(let data):
                // assert
                exp.fulfill() // assert will never get called without this
                XCTAssertGreaterThan(data.count, 600000, "data should be bigger than 600k bytes or \(data.count)")
            }
        }
        // if we dont get our data in 5 seconds or less we just assume something is wrong
        wait(for: [exp], timeout: 5.0)
    }
    
    // This test checks if we can get 50 recipes back
    func testFetchRecipes() {
        //arrage
        let expectedRecipeCount = 50
        let exp = XCTestExpectation(description: "recipes found")
        let searchQuery = "tacos".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        // act
        RecipeAPI.fetchRecipe(for: searchQuery) { (result) in
            switch result {
            case .failure(let appError):
                XCTFail("appError: \(appError)")
                
                
            case .success(let recipes):
                exp.fulfill()
                XCTAssertEqual(recipes.count, expectedRecipeCount)
            }
        }
        wait(for: [exp], timeout: 5.0)
    }
}
