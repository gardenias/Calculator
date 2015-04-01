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
    
    var brain = CalculatorBrain()

    var userIsInTheMiddleOfTypingANumber = false

    @IBAction func digtal(sender: UIButton) {
        let digtal = sender.currentTitle
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digtal!
        }else{
            display.text = digtal!
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        }else{
            displayValue = 0
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber{
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.perforOperation(operation){
                displayValue = result
            }else{
                displayValue = 0
            }
        }
    }
    
    var displayValue:Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            userIsInTheMiddleOfTypingANumber = false
            display.text = "\(newValue)"
        }
    }
}

