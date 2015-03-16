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
    
    
    var operatorStack = Array<NSString>()
    
    @IBAction func operate(sender: UIButton) {
        
        enter()
        
        operatorStack.append(sender.currentTitle!)
        println("operatorStack = \(operatorStack)")
    }

    var operandStack = Array<Double>()
    
    @IBAction func enter() {
       userInputedANumber = false
        operandStack.append(displayValue)
       
        if(operatorStack.count==1 &&  operandStack.count==2){
            performCalculat()
        }else if(operandStack.count == operatorStack.count + 1){
            //do nothing
        }else{
            operandStack.removeAll(keepCapacity: true)
            operatorStack.removeAll(keepCapacity: true)
        }
        
        println("operandStack = \(operandStack)")
    }
    
    
    func performCalculat() -> Double{
       let operatorS = operatorStack.removeLast()
        switch operatorS {
            case "+": performOperation ({$0+$1})
            case "-":performOperation ({$1-$0})
            case "*":performOperation ({$0*$1})
            case "/":performOperation ({$1/$0})
            default : break
        }
        println("perform calculat result \(displayValue)")
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

