//
//  ViewController.swift
//  WeatherSample
//
//  Created by Jun on 2015/10/16.
//  Copyright © 2015年 junappleseed. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var areaTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        areaTableView.dataSource = self
        areaTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Area.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        cell.textLabel!.text = Area.items[indexPath.row].areaName
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("toMainViewController", sender: nil)
    }
    
    // MARK: - Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toMainViewController" {
            if let indexPath = areaTableView.indexPathForSelectedRow {
                let controller = segue.destinationViewController as! MainViewController
                controller.selectedArea = Area.items[indexPath.row]
            }
        }
    }
}

