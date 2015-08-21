//
//  ViewController.swift
//  JSON
//
//  Created by Joshua O'Connor on 3/11/15.
//  Copyright (c) 2015 Joshua O'Connor. All rights reserved.
//




//NEVER HAVE TO CHANGE AT ALL
//THROW IN URL AND SHOULD WORK!

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //make url equal to values
        let urlAsString = "http://date.jsontest.com"
        let url = NSURL(string:urlAsString)!
        //create session with website feeding json.  allows faster parsing and communication
        //session: some sort of token that remembers you
        let urlSession = NSURLSession.sharedSession()
        //create json query
        //completionHandler lets you know when it is done
        let jsonQuery = urlSession.dataTaskWithURL(url, completionHandler:{data,response, error -> Void in
            //error checking
            
            if error != nil {
                println(error.localizedDescription)
            }
            
            var err:NSError?
            
            //grab data
            //NSDictonary is the format of the JSON (looks like a dictionary, they are key value pairs)
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data,options: NSJSONReadingOptions.MutableContainers,error:&err) as NSDictionary
            if err != nil {
                println("JSON ERROR \(err!.localizedDescription)")
            }
            /*
            {
            time: "01:09:50 AM",
            milliseconds_since_epoch: 1426122590536,
            date: "03-12-2015"
            }*/
            

            let JSONDate:String! = jsonResult["date"] as String
            let jsonTime:String! = jsonResult["time"] as String
            
            //finds out if cell or wifi is better
            dispatch_async(dispatch_get_main_queue(),{
                self.timeLabel.text = "\(JSONDate) and \(jsonTime)"
                
            })
            
        })
        jsonQuery.resume()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

