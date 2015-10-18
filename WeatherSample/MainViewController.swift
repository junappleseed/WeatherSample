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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
