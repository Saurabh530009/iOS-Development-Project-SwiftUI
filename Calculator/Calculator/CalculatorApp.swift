//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Saurabh Kumar Verma on 20/07/2023.
//

import SwiftUI

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            CalculatorView()
                .environmentObject(CalculatorView.ViewModel())
        }
    }
}
