# Unit Testing

## XCTest
This is a framework that helps us create and run unit, performance, and UI Tests. It tests "assert" that certain conditions are satisified during code execution,  and record test failures if those conditions aret satisfied. We use this to measure the performance of blocks of code. We can also test user interaction flows. Heres a detailed guide <a href="https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/testing_with_xcode/chapters/04-writing_tests.html"> writing test classes and methods.</a>

# Motivation
Tests lets us define what certain methods should be doing, it can help us ensure we wont break the codebase when implementing a new feature. This example loads weather objects into a table view and test it to make sure our model works as intended and alert a developer to see if their changes break the codebase. <br></br>
This is the json file we'll be using:
<details>
  <summary>json file</summary>
  
  ```c++
{
	"message": "accurate",
	"cod": "200",
	"count": 3,
	"list": [{
		"id": 2641549,
		"name": "Newtonhill",
		"coord": {
			"lat": 57.0333,
			"lon": -2.15
		},
		"main": {
			"temp": 275.15,
			"pressure": 1010,
			"humidity": 93,
			"temp_min": 275.15,
			"temp_max": 275.15
		},
		"dt": 1521204600,
		"wind": {
			"speed": 9.3,
			"deg": 120,
			"gust": 18
		},
		"sys": {
			"country": ""
		},
		"rain": null,
		"snow": null,
		"clouds": {
			"all": 75
		},
		"weather": [{
			"id": 311,
			"main": "Drizzle",
			"description": "rain and drizzle",
			"icon": "09d"
		}]
	}, {
		"id": 2636814,
		"name": "Stonehaven",
		"coord": {
			"lat": 56.9637,
			"lon": -2.2118
		},
		"main": {
			"temp": 275.15,
			"pressure": 1010,
			"humidity": 93,
			"temp_min": 275.15,
			"temp_max": 275.15
		},
		"dt": 1521204600,
		"wind": {
			"speed": 9.3,
			"deg": 120,
			"gust": 18
		},
		"sys": {
			"country": ""
		},
		"rain": null,
		"snow": null,
		"clouds": {
			"all": 75
		},
		"weather": [{
			"id": 311,
			"main": "Drizzle",
			"description": "rain and drizzle",
			"icon": "09d"
		}]
	}, {
		"id": 2640030,
		"name": "Portlethen",
		"coord": {
			"lat": 57.0547,
			"lon": -2.1307
		},
		"main": {
			"temp": 275.15,
			"pressure": 1010,
			"humidity": 93,
			"temp_min": 275.15,
			"temp_max": 275.15
		},
		"dt": 1521204600,
		"wind": {
			"speed": 9.3,
			"deg": 120,
			"gust": 18
		},
		"sys": {
			"country": ""
		},
		"rain": null,
		"snow": null,
		"clouds": {
			"all": 75
		},
		"weather": [{
			"id": 311,
			"main": "Drizzle",
			"description": "rain and drizzle",
			"icon": "09d"
		}]
	}]
}
  ```
  
</details>

# The model
This model will give us data object for weather metrics.
<details>
  <summary></summary>
</details>

# Testing
Theres 3 parts to a unit test
<ul>
<li>Arrange</li>
	<ul>
	<li>Do any setup that you need</li>
	<li>Load the json from the bundle</li>
	</ul>
<li>Act</li>
	<ul>
	<li>Call the function you want to test</li>
	<li>We'll "act" by calling the getAllWeathers(from:) method we made in our model.</li>
	</ul>
<li>Assert</li>
	<ul>
	<li>Make an assertion which tests is our expectations are true</li>
	<li>We'll assert that theres 3 structs in the array we generated</li>
	</ul>
</ul>

<details>
	<summary>Tests</summary>
	
```swift
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
```
	
</details>
