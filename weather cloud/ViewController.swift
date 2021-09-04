//
//  ViewController.swift
//  weather cloud
//
//  Created by Abdirizak Hassan on 9/2/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var cityTextbox: UITextField!
    
    @IBAction func didTapGo() {
        
        guard cityTextbox.text?.isEmpty == false else {
             return showAlert(title: "Empty..!", message: "Text Box cannot Be empty..!")
        }
        
        
        var components = URLComponents(string: "http://api.openweathermap.org/data/2.5/weather?")
        let cityQuery = URLQueryItem(name: "q", value: cityTextbox.text)
        let appIdQuery = URLQueryItem(name: "appid", value: "Past here")
        let unitsQuery = URLQueryItem(name: "units", value: "imperial")
        
        components?.queryItems = [cityQuery, appIdQuery, unitsQuery]
        
        guard let url = components?.url else { return }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, _, error) in
            if let err = error {
                print(err)
            } else if let data = data {
                self.parse(json: data)
            }
        }
        dataTask.resume()
    }
    
    func showAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    func parse(json: Data) {
        do {
//                    let json = try JSONSerialization.jsonObject(with: data , options: [])
//                    print(json)
            let weatherReport = try JSONDecoder().decode(WeatherReport.self, from: json)
            print(weatherReport)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "segue.Main.cityWeather", sender: weatherReport)
            }
        } catch {
            print(error)
        }
    }
    
    @IBAction func returnToMainVC(_ sender: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let weatherVC = segue.destination as? weatherVC, let weatherR = sender as? WeatherReport {
            weatherVC.weatherReport = weatherR
        }
    }

}

