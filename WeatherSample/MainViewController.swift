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
    
    @IBOutlet weak var dateLabel0: UILabel!
    @IBOutlet weak var weatherImage0: UIImageView!
    @IBOutlet weak var weatherLabel0: UILabel!
    
    @IBOutlet weak var publicTimeLabel0: UILabel!
    @IBOutlet weak var minLabel0: UILabel!
    @IBOutlet weak var maxLabel0: UILabel!
    @IBOutlet weak var areaNameLabel0: UILabel!
    
    @IBOutlet weak var dateLabel1: UILabel!
    @IBOutlet weak var weatherImage1: UIImageView!
    @IBOutlet weak var weatherLabel1: UILabel!
    
    @IBOutlet weak var publicTimeLabel1: UILabel!
    @IBOutlet weak var minLabel1: UILabel!
    @IBOutlet weak var maxLabel1: UILabel!
    @IBOutlet weak var areaNameLabel1: UILabel!
    
    @IBOutlet weak var textLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = selectedArea.areaName + "の天気"
        
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
        let session = NSURLSession(
                configuration: config, delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
    
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(
                        data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                if let location: NSDictionary = NSDictionary(dictionary: json["location"] as! NSDictionary) {
                    let area: String = location["area"] as! String
                    let city: String = location["city"] as! String
                    
                    self.areaNameLabel0.text = area + " / " + city
                    self.areaNameLabel1.text = area + " / " + city
                }
                
                let publicTime: String = self.formatDate(
                        (json["publicTime"] as! String), beforeFormat: "yyyy-MM-dd'T'HH:mm:ssZ", afterFormat: "HH時")
                self.publicTimeLabel0.text = publicTime + "発表"
                self.publicTimeLabel1.text = publicTime + "発表"
                
                if let forecasts: NSArray = NSArray(array: json["forecasts"] as! NSArray) {
                    if let today: NSDictionary = NSDictionary(dictionary: forecasts[0] as! NSDictionary) {
                        let dateLabel: String = today["dateLabel"] as! String
                        let dateString: String = today["date"] as! String
                        self.dateLabel0.text = dateLabel + " "
                                + self.formatDate(dateString, beforeFormat: "yyyy-MM-dd", afterFormat: "MM/dd（E）")
                        self.weatherLabel0.text = today["telop"] as? String
                        
                        if let image: NSDictionary = NSDictionary(dictionary: today["image"] as! NSDictionary) {
                            let url: NSURL = NSURL(string: image["url"] as! String)!
                            let imageData: NSData = NSData(contentsOfURL: url)!
                            self.weatherImage0.image = UIImage(data: imageData)
                        }
                        
                        if let temperature: NSDictionary = NSDictionary(dictionary: today["temperature"] as! NSDictionary) {
                            let minValue: AnyObject = temperature["min"]!
                            if minValue.isKindOfClass(NSNull) == false {
                                if let min: NSDictionary = NSDictionary(dictionary: minValue as! NSDictionary) {
                                    self.minLabel0.text = min["celsius"] as! String + "℃"
                                }
                            }
                            let maxValue: AnyObject = temperature["max"]!
                            if maxValue.isKindOfClass(NSNull) == false {
                                if let max: NSDictionary = NSDictionary(dictionary: maxValue as! NSDictionary) {
                                    self.maxLabel0.text = max["celsius"] as! String + "℃"
                                }
                            }
                        }
                    }
                    
                    if let today: NSDictionary = NSDictionary(dictionary: forecasts[1] as! NSDictionary) {
                        let dateLabel: String = today["dateLabel"] as! String
                        let dateString: String = today["date"] as! String
                        self.dateLabel1.text = dateLabel + " "
                                + self.formatDate(dateString, beforeFormat: "yyyy-MM-dd", afterFormat: "MM/dd（E）")
                        self.weatherLabel1.text = today["telop"] as? String
                        
                        if let image: NSDictionary = NSDictionary(dictionary: today["image"] as! NSDictionary) {
                            let url: NSURL = NSURL(string: image["url"] as! String)!
                            let imageData: NSData = NSData(contentsOfURL: url)!
                            self.weatherImage1.image = UIImage(data: imageData)
                        }
                        
                        if let temperature: NSDictionary = NSDictionary(dictionary: today["temperature"] as! NSDictionary) {
                            let minValue: AnyObject = temperature["min"]!
                            if minValue.isKindOfClass(NSNull) == false {
                                if let min: NSDictionary = NSDictionary(dictionary: minValue as! NSDictionary) {
                                    self.minLabel1.text = min["celsius"] as! String + "℃"
                                }
                            }
                            let maxValue: AnyObject = temperature["max"]!
                            if maxValue.isKindOfClass(NSNull) == false {
                                if let max: NSDictionary = NSDictionary(dictionary: maxValue as! NSDictionary) {
                                    self.maxLabel1.text = max["celsius"] as! String + "℃"
                                }
                            }
                        }
                    }
                }
                
                if let description: NSDictionary = NSDictionary(dictionary: json["description"] as! NSDictionary) {
                    self.textLabel.text = description["text"] as! String
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
