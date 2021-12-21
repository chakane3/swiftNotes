//
//  WeatherModel.swift
//  tdd
//
//  Created by Chakane Shegog on 12/20/21.
//

import Foundation

struct WeatherWrapper: Codable {
    let list: [Weather]
}

struct Weather: Codable {
    let name: String
    let mainInformation: MainWeatherInformation
    let windInformation: WindInformation
    let weatherDescriptions: [WeatherDescription]
    
        var farenheitTemperature: Double {
            return mainInformation.temperatureInKelvin * 1.8 - 459.67
        }
    
    static func getAllWeathers(from JSONData: Data) throws -> [Weather] {
        do {
            let allWeathers = try JSONDecoder().decode(WeatherWrapper.self, from: JSONData)
            return allWeathers.list
            
        } catch {
            throw error
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case mainInformation = "main"
        case windInformation = "wind"
        case weatherDescriptions = "weather"
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
