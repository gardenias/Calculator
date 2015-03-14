//
//  ViewController.swift
//  Calculator
//
//  Created by 吴一敏 on 15/3/14.
//  Copyright (c) 2015年 Yimin Learning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var display: UILabel!

    var userInputedANumber : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func digtal(sender: UIButton) {
        let digtal = sender.currentTitle
        if userInputedANumber {
            display.text = display.text! + digtal!
        }else{
            display.text = digtal!
            userInputedANumber = true
        }
        
    }

}

