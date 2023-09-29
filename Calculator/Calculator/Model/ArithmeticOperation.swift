//
//  ArithmeticOperation.swift
//  Calculator
//
//  Created by Saurabh Kumar Verma on 20/07/2023.
//

import Foundation

enum ArithmeticOperation: CaseIterable, CustomStringConvertible {
    case addition, subtraction, multiplication, division
    
    var description: String {
        switch self {
        case .addition:
            return "+"
            
        case .subtraction:
            return "-"
            
        case .multiplication:
            return "x"
            
        case .division:
            return "÷"
        }
    }
}
