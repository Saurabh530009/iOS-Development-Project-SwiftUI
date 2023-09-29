//
//  ButtonType.swift
//  Calculator
//
//  Created by Saurabh Kumar Verma on 20/07/2023.
//

import Foundation
import SwiftUI

enum ButtonType: Hashable, CustomStringConvertible {
    case digit(_ digit: Digit)
    case operation(_ operation: ArithmeticOperation)
    case negative
    case percent
    case decimal
    case equal
    case allClear
    case clear
    
    var description: String {
        switch self {
        case .digit(let digit):
            return digit.description
        case .operation(let operation):
            return operation.description
        case .negative:
            return "-"
        case .percent:
            return "%"
        case .decimal:
            return "."
        case .equal:
            return "="
        case .allClear:
            return "AC"
        case .clear:
            return "C"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .allClear, .clear, .negative, .percent:
            return Color(.lightGray)
            
        case .operation, .equal:
            return .orange
            
        case .digit, .decimal:
            return .secondary
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .allClear, .clear, .negative, .percent:
            return .black
        default:
            return .white
        }
    }
}
