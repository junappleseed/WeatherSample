//
//  MainViewController.swift
//  WeatherSample
//
//  Created by Jun on 2015/10/18.
//  Copyright © 2015年 junappleseed. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var selectedArea: Area!
    
    @IBOutlet weak var areaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = selectedArea.areaName + "の天気"
        areaLabel.text = selectedArea.areaName
        
        showWeatherData(selectedArea.cityId)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func showWeatherData(cityId: String) {

        let url = NSURL(string: "http://weather.livedoor.com/forecast/webservice/json/v1?city=" + cityId)
        let request = NSURLRequest(URL: url!)
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config, delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
    
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                print(json["title"])
                
                if let location: NSDictionary = NSDictionary(dictionary: json["location"] as! NSDictionary) {
                    print(location["area"])
                    print(location["prefecture"])
                    print(location["city"])
                }
                
                if let forecasts: NSArray = NSArray(array: json["forecasts"] as! NSArray) {
                    if let today: NSDictionary = NSDictionary(dictionary: forecasts[0] as! NSDictionary) {
                        print(today["dateLabel"])
                        print(today["telop"])
                        print(today["date"])
                    }
                }
                
            } catch {
                print("エラー")
            }
        })
        task.resume()
    }
}
