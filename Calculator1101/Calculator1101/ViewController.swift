//
//  ViewController.swift
//  Calculator1101
//
//  Created by 陈良静 on 2016/11/1.
//  Copyright © 2016年 chenliangjing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false // 标识当前是否正在输入状态
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDispaly = display.text!
            display.text = textCurrentlyInDispaly + digit
        } else {
            display.text = digit
        }
        
        userIsInTheMiddleOfTyping = true
    }
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOpreation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let methemtiaclSymbol = sender.currentTitle {
            brain.performOperation(symbol: methemtiaclSymbol)
        }
        
        displayValue = brain.result
    }
    
}

