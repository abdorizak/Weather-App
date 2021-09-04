//
//  WeatherReport.swift
//  weather cloud
//
//  Created by Abdirizak Hassan on 9/4/21.
//

import UIKit

struct WeatherReport: Codable {
    let city: String
    let main : WeatherBreakdown
    let weather: [WeatherCondition]
    private enum CodingKeys: String, CodingKey {
        case city = "name"
        case main, weather
    }
}

extension WeatherReport {
    var degreesFahrenheit: String {
        let wholeTemp = Int(main.temperature)
        let degreesFahrenheit = String(wholeTemp) + "˚"
        return degreesFahrenheit
    }
    
    var conditionIcon: UILabel {
        guard let mainCondition = weather.first else {
            return UILabel()
        }
        
        let label = UILabel()
        switch mainCondition.id {
        case 200...299: label.text = "🌩"
        case 300...399: label.text = "☁️"
        case 500...599: label.text = "🌦"
        case 600...699: label.text = "🌨"
        case 700...799: label.text = "🌫"
        case 800: label.text = "🌝"
        case 801...804: label.text = "🌤"
        default:
            label.text = "😅"
        }
        return label
    }
    
}

struct WeatherBreakdown: Codable {
    let temperature: Double
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
    }
}

struct WeatherCondition: Codable {
    let id: Int
    let description: String
}
