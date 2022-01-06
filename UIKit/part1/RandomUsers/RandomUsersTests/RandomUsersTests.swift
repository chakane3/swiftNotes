//
//  RandomUsersTests.swift
//  RandomUsersTests
//
//  Created by Chakane Shegog on 1/5/22.
//

import XCTest
@testable import RandomUsers

class RandomUsersTests: XCTestCase {
    
    func testEndpoint() {
        let endpoint = "https://randomuser.me/api/?results=2"
        let exp = XCTestExpectation(description: "data found")
        let request = URLRequest(url: URL(string: endpoint)!)
        NetworkRequest.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                XCTFail("app error: \(appError)")
                
            case .success(let data):
                exp.fulfill()
                XCTAssertGreaterThan(data.count, 3000, "data should be bigger than 3k bytes. \(data.count) bytes was found")
            }
            
        }
        
    }

}
