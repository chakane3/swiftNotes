//
//  MusixMatchTests.swift
//  MusixMatchTests
//
//  Created by Chakane Shegog on 12/31/21.
//

import XCTest
@testable import MusixMatch

class MusixMatchTests: XCTestCase {
    
    
    func testArtistQuery() {
        let name = "John".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "nil"
        let testEndpoint = "http://api.musixmatch.com/ws/1.1/artist.search?q_artist=\(name)&page_size=5&apikey=\(SecretKey.privateKey)"
        let exp = XCTestExpectation(description: "data found!")
        
        NetworkRequest.shared.getData(from: testEndpoint) { (result) in
            switch result {
            case .failure(let networkError):
                XCTFail("\(networkError)")
            case .success(let data):
                exp.fulfill()
                XCTAssertGreaterThan(data.count, 2000)
            }
        }
        wait(for: [exp], timeout: 5.0)
    }
}
