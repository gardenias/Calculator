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

    var userInputedANumber = false
    
    @IBAction func digtal(sender: UIButton) {
        let digtal = sender.currentTitle
        if userInputedANumber {
            display.text = display.text! + digtal!
        }else{
            display.text = digtal!
            userInputedANumber = true
        }
    }
    
    var operandStack = [Double]()
    
    @IBAction func enter() {
        userInputedANumber = false
        operandStack.append(displayValue)
    }
    
    var operatorStack = Array<NSString>()
    
    @IBAction func operate(sender: UIButton) {
        enter()
        displayValue = performCalculat(sender.currentTitle!)
    }
    
    func performCalculat(operate:NSString) -> Double{
        switch operate {
            case "+": performOperation ({$0+$1})
            case "-": performOperation ({$1-$0})
            case "*": performOperation ({$0*$1})
            case "/": performOperation ({$1/$0})
            default : break
        }
        return displayValue
    }
    
    func performOperation(operation : (op1: Double,op2:Double) -> Double){
        if(operandStack.count>=2){
              displayValue  =  operation(op1: operandStack.removeLast(),op2: operandStack.removeLast())
        }
    }
    
    var displayValue:Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            userInputedANumber = false
            display.text = "\(newValue)"
        }
    }
}

