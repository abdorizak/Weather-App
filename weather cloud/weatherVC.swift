//
//  weatherVC.swift
//  weather cloud
//
//  Created by Abdirizak Hassan on 9/2/21.
//

import UIKit

class weatherVC: UIViewController {
    @IBOutlet var cityLable: UILabel!
    @IBOutlet var typeclodIconLable: UILabel!
    @IBOutlet var tempratureLable: UILabel!
    @IBOutlet var typecloud: UILabel!
    
    var weatherReport: WeatherReport?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let weatherRp = weatherReport else {
            return
        }
        cityLable.text = weatherRp.city
        typeclodIconLable.text = weatherRp.conditionIcon.text
        tempratureLable.text = weatherReport?.degreesFahrenheit
        typecloud.text = weatherRp.weather.first?.description
    }

}
