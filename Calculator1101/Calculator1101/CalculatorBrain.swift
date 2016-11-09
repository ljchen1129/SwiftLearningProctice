//
//  CalculatorBrain.swift
//  Calculator1101
//
//  Created by 陈良静 on 2016/11/2.
//  Copyright © 2016年 chenliangjing. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
   private var accumulator = 0.0
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
   private var operations: Dictionary<String, Operation> = [
       "π": .Constrant(M_PI),
       "e": .Constrant(M_E),
       "√": Operation.UnaryOperation(sqrt),
       "cos": Operation.UnaryOperation(cos),
       "+": Operation.BinaryOperation({$0 + $1}),
       "−": Operation.BinaryOperation({$0 - $1}),
       "×": Operation.BinaryOperation({$0 * $1}),
       "÷": Operation.BinaryOperation({$0 / $1}),
       "=": Operation.Equals
    ]
    
   private enum Operation {
        case Constrant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
   private struct pendingBinaryOperationInfo {
        var firstOperand: Double
        var binaryOperation: (Double, Double) -> Double
    }
    
   private var pending: pendingBinaryOperationInfo?
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constrant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case.BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = pendingBinaryOperationInfo(firstOperand: accumulator, binaryOperation: function)
            case.Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
   private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryOperation(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
}
