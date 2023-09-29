//
//  Calculator.swift
//  Calculator
//
//  Created by Saurabh Kumar Verma on 20/07/2023.
//

import Foundation

struct Calculator {
    
    // MARK: - Properties
    
    private var newNumber: Decimal? {
        didSet {
            guard newNumber != nil else { return }
            carryingNegative = false
            carryingDecimal = false
            carryingZeroCount = 0
            pressedClear = false
        }
    }
    private var expression: ArithmeticExpression?
    private var result: Decimal?
    
    private var carryingNegative: Bool = false
    private var carryingDecimal: Bool = false
    private var pressedClear: Bool = false
    private var carryingZeroCount: Int = 0
    
    
    // MARK: - Computed Properties
    var displayText: String {
        return getNumberString(forNumber: number, withCommas: true)
    }
    
    var showAllClear: Bool {
        newNumber == nil && expression == nil && result == nil || pressedClear
    }
    
    /// Current displaying number
    var number: Decimal? {
        if pressedClear || carryingDecimal {
            return newNumber
        }
        return newNumber ?? expression?.number ?? result
    }
    
    /// Will be used by the ViewModel to know which button to show
    private var containsDecimal: Bool {
        return getNumberString(forNumber: number).contains(".")
    }
}

// MARK: - Operations
extension Calculator {
    mutating func setDigit(_ digit: Digit) {
        if containsDecimal && digit == .zero {
            carryingZeroCount += 1
        }
        // 1. Check if you can add the digit (01 should not be possible).
        else if canAddDigit(digit) {
            
            // 2. Convert newNumber Decimal to a String
            let numberString = getNumberString(forNumber: newNumber)
            
            // 3. Append the digit to the end of the string, convert the String back to Decimal and assign its new value to newNumber
            newNumber = Decimal(string: numberString.appending("\(digit.rawValue)"))
        }
    }
    
    mutating func setOperations(_ operation: ArithmeticOperation){
        // 1. Check if there is a number we can use (newNumber or previous result) and assign it to a new variable number
        guard var number = newNumber ?? result else { return }
        
        // 2. Check if there is already an existingExpression, if there is, evaluate it using number and assign the result to number
        if let existingExpression = expression {
            number = existingExpression.evaluate(with: number)
        }
        
        // 3. Assign new ArithmeticExpression with number and operation to expression
        expression = ArithmeticExpression(number: number, operation: operation)
        
        // 4. Reset newNumber
        newNumber = nil
    }
    
    mutating func toggleSign() {
        if let number = newNumber {
            newNumber = -number
            return
        }
        if let number = result {
            result = -number
            return
        }
        
        carryingNegative.toggle()
    }
    
    mutating func setPercent() {
        // To set percent we need to:
        
        // 1. Check if newNumber or result is currently used
        if let number = newNumber {
            // 2. Divide by 100 and assign the new value
            newNumber = number / 100
            return
        }
        
        if let number = result {
            result = number / 100
            return
        }
    }
    
    mutating func setDecimal() {
        // 1. Check if number already contains a decimal, if it does, return
        if containsDecimal { return }
        
        // 2. Make the carryingDecimal property true
        carryingDecimal = true
    }
    
    mutating func evaluate() {
        // To evaluate we need to:
        
        // 1. Unwrap newNumber and expression (expression contains the previous number and operation)
        guard let number = newNumber, let expressionToEvaluate = expression else { return }
        
        // 2. Evaluate expression with newNumber and assign to result
        result = expressionToEvaluate.evaluate(with: number)
        
        // 3. Reset expression and newNumber
        expression = nil
        newNumber = nil
    }
    
    mutating func allClear() {
        newNumber = nil
        expression = nil
        result = nil
        carryingNegative = false
        carryingDecimal = false
        carryingZeroCount = 0
    }
    
    mutating func clear() {
        newNumber = nil
        carryingNegative = false
        carryingDecimal = false
        carryingZeroCount = 0
        
        pressedClear = true
    }
}

// MARK: - Helpers
extension Calculator {
    
    
    private func getNumberString(forNumber number: Decimal?, withCommas: Bool = false) -> String {
        var numberString = (withCommas ? number?.formatted(.number) : number.map(String.init)) ?? "0"
        
        if carryingNegative {
            numberString.insert("-", at: numberString.startIndex)
        }
        
        if carryingDecimal {
            numberString.insert(".", at: numberString.endIndex)
        }
        
        if carryingZeroCount > 0 {
            numberString.append(String(repeating: "0", count: carryingZeroCount))
        }
        
        return numberString
    }
    
    private func canAddDigit(_ digit: Digit) -> Bool {
        return number != nil || digit != .zero
    }
    
    func operationIsHighlighted(_ operation: ArithmeticOperation) -> Bool {
        return expression?.operation == operation && newNumber == nil
    }
}

//MARK: - ArithmeticExpression
extension Calculator {
    
    private struct ArithmeticExpression: Equatable {
        var number: Decimal
        var operation: ArithmeticOperation
        
        func evaluate(with secondNumber: Decimal) -> Decimal {
            switch operation {
            case .addition:
                return number + secondNumber
            case .subtraction:
                return number - secondNumber
            case .multiplication:
                return number * secondNumber
            case .division:
                return number / secondNumber
            }
        }
    }
}
