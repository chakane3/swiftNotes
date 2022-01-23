//
//  UserHoroscopeTests.swift
//  UserHoroscopeTests
//
//  Created by Chakane Shegog on 1/21/22.
//

import XCTest
@testable import UserHoroscope

class UserHoroscopeTests: XCTestCase {

    func testNetworkConnection() {
        let urlString = "http://sandipbgt.com/theastrologer/api/horoscope/gemini/today"
        guard let url = URL(string: urlString) else { return }
        let endpoint = URLRequest(url: url)
        let exp = XCTestExpectation(description: "data found")
        
        NetworkRequest.shared.performDataTask(with: endpoint) { (result) in
            switch result {
            case .failure(let networkError):
                XCTFail("\(networkError)")
                
            case .success(let _):
                exp.fulfill()
            }
        }
    }

}
