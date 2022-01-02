//
//  tddTests.swift
//  tddTests
//
//  Created by Chakane Shegog on 12/20/21.
//

import XCTest
@testable import tdd

class tddTests: XCTestCase {

    func testLoadWeather() {
        // Arrange
        let weatherData = getTestWeatherJSONData()

        // Act
        var allWeathers = [Weather]()

        do {
            allWeathers = try Weather.getAllWeathers(from: weatherData)
        } catch {
            print(error)
        }

        // Assert
        XCTAssertTrue(allWeathers.count == 3, "Was expecting 3 weather structs, but received \(allWeathers.count)")
    }

    // function to get our local json data using app Bundle
    private func getTestWeatherJSONData() -> Data {
        guard let pathToData = Bundle.main.path(forResource: "testWeather", ofType: "json") else {
            fatalError("testWeather.json file not found")
        }
        let internalUrl = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: internalUrl)
            return data
        } catch {
            fatalError("An error occurred: \(error)")
        }
    }
}
