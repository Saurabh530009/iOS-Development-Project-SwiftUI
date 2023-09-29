//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Saurabh Kumar Verma on 21/07/2023.
//

import Foundation
import Combine

extension CalculatorView {
    final class ViewModel: ObservableObject {
        
        // MARK: - Properties
        @Published private var calculator = Calculator()
        
        var displayText: String {
            return calculator.displayText
        }
        
        var buttonTypes: [[ButtonType]] {
            return [
                [.allClear, .clear, .percent, .operation(.division)],
                [.digit(.seven), .digit(.eight), .digit(.nine), .operation(.multiplication)],
                [.digit(.four), .digit(.five), .digit(.six), .operation(.subtraction)],
                [.digit(.one), .digit(.two), .digit(.three), .operation(.addition)],
                [.digit(.zero), .decimal, .equal]
            ]
        }
        
        // MARK: - Actions
        func performAction(for buttonType: ButtonType) {
            switch buttonType {
            case .digit(let digit):
                calculator.setDigit(digit)
            case .operation(let operation):
                calculator.setOperations(operation)
            case .negative:
                calculator.toggleSign()
            case .percent:
                calculator.setPercent()
            case .decimal:
                calculator.setDecimal()
            case .equal:
                calculator.evaluate()
            case .allClear:
                calculator.allClear()
            case .clear:
                calculator.clear()
            }
        }
        
        //MARK: - Helpers
        func buttonTypeIsHighlighted(buttonType: ButtonType) -> Bool {
            guard case .operation(let operation) = buttonType else { return false}
            return calculator.operationIsHighlighted(operation)
        }
    }
}
