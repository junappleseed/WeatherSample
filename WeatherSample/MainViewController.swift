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
    
    @IBOutlet weak var dateLabelToday: UILabel!
    @IBOutlet weak var weatherImageToday: UIImageView!
    @IBOutlet weak var weatherLabelToday: UILabel!
    
    @IBOutlet weak var publicTimeLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var areaNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = selectedArea.areaName + "の天気"
        
        showWeatherData(selectedArea.cityId, day: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func showWeatherData(cityId: String, day: Int) {

        let url = NSURL(string: "http://weather.livedoor.com/forecast/webservice/json/v1?city=" + cityId)
        let request = NSURLRequest(URL: url!)
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config, delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
    
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                if let location: NSDictionary = NSDictionary(dictionary: json["location"] as! NSDictionary) {
                    let area: String = location["area"] as! String
                    let city: String = location["city"] as! String
                    
                    self.areaNameLabel.text = area + " / " + city
                }
                
                let publicTime: String = self.formatDate((json["publicTime"] as! String), beforeFormat: "yyyy-MM-dd'T'HH:mm:ssZ", afterFormat: "HH時")
                self.publicTimeLabel.text = publicTime + "発表"
                
                if let forecasts: NSArray = NSArray(array: json["forecasts"] as! NSArray) {
                    if let today: NSDictionary = NSDictionary(dictionary: forecasts[day] as! NSDictionary) {
                        let dateLabel: String = today["dateLabel"] as! String
                        let dateString: String = today["date"] as! String
                        self.dateLabelToday.text = dateLabel + " " + self.formatDate(dateString, beforeFormat: "yyyy-MM-dd", afterFormat: "MM/dd（E）")
                        self.weatherLabelToday.text = today["telop"] as? String
                        
                        if let image: NSDictionary = NSDictionary(dictionary: today["image"] as! NSDictionary) {
                            let url: NSURL = NSURL(string: image["url"] as! String)!
                            let imageData: NSData = NSData(contentsOfURL: url)!
                            self.weatherImageToday.image = UIImage(data: imageData)
                        }
                        
                        if let temperature: NSDictionary = NSDictionary(dictionary: today["temperature"] as! NSDictionary) {
                            if !temperature["min"]!.isKindOfClass(NSNull) {
                                if let min: NSDictionary = NSDictionary(dictionary: temperature["min"] as! NSDictionary)
                                    where ((temperature["min"]?.isKindOfClass(NSNull)) != true) {
                                    self.minLabel.text = min["celsius"] as! String + "℃"
                                }
                                if let max: NSDictionary = NSDictionary(dictionary: temperature["max"] as! NSDictionary) {
                                    self.maxLabel.text = max["celsius"] as! String + "℃"
                                }
                            }
                        }
                    }
                }
                
                if let description: NSDictionary = NSDictionary(dictionary: json["description"] as! NSDictionary) {
                    print(description["text"])
                }
                
            } catch {
                print("システムエラー")
            }
        })
        task.resume()
    }
    
    private func formatDate(dateString: String, beforeFormat: String, afterFormat: String) -> String {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        
        dateFormatter.dateFormat = beforeFormat
        let date: NSDate = dateFormatter.dateFromString(dateString)!
        
        dateFormatter.dateFormat = afterFormat
        return dateFormatter.stringFromDate(date)
    }
}
