//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 吴一敏 on 15/3/31.
//  Copyright (c) 2015年 Yimin Learning. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    private var opStack = [Op]()
    private var supportOps = [String:Op]()

    private enum Op {
        case Operand(Double)
        case BinnaryOperation(String, (Double, Double)->Double)
        case UnaryOperation(String, Double->Double)
    }

    init() {

        //binnary operation,
        supportOps["+"] = Op.BinnaryOperation("+", +)
        supportOps["-"] = Op.BinnaryOperation("-", {$1 - $0})
        supportOps["×"] = Op.BinnaryOperation("×", *)
        supportOps["÷"] = Op.BinnaryOperation("÷", {$1 / $0})
        
        //unary operation
        // TODO...
        
    }

    func pushOperand(operand:Double) -> Double?
    {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }

    func perforOperation(symbol : String) -> Double?
    {
        if let opration = supportOps[symbol] {
            opStack.append(opration)
        }
        return evaluate()
    }

    func evaluate() -> Double?
    {
        let (result,remaninOps) = evaluate(opStack)
        return result
    }
    
    private func evaluate(ops :[Op])->(result : Double?, remaningOps :[Op])
    {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            
            switch op {
            case .Operand(let operand) :
                    return (operand,remainingOps)
            case .BinnaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remaningOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1,operand2),op2Evaluation.remaningOps)
                    }
                }
            case .UnaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
            }
        }
        return (nil, ops)
    }
}