//
//  WeatherModel.swift
//  tdd
//
//  Created by Chakane Shegog on 12/19/21.
//

import Foundation

struct Weather: Codable {
    let name: String
    let mainInformation: MainWeatherInformation
    let windInformation: WindInformation
    let weatherDescription: [WeatherDescription]
    
    static func getAllWeathers(from JSONData: Data) -> [Weather] {
        do {
            let allWeathers = try JSONDecoder().decode([Weather].self, from: JSONData)
            return allWeathers
        } catch {
            return []
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case mainInformation = "main"
        case windInformation = "wind"
        case weatherDescription = "weather"
    }
}

struct MainWeatherInformation: Codable {
    let temperatureInKelvin: Double
    
    private enum CodingKeys: String, CodingKey {
        case temperatureInKelvin = "temp"
    }
}

struct WindInformation: Codable {
    let speed: Double
    let deg: Int
}

struct WeatherDescription: Codable {
    let description: String
}
