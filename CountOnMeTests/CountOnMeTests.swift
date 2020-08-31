//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Saddam Satouyev on 26/08/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

@testable import CountOnMe
import XCTest

class CountOnMeTests: XCTestCase {
    
    var calculator: Calculator!
    
    override func setUp() {
        calculator = Calculator()
    }
    
    // MARK: - addDigit
    
    func testGivenEmptyOperation_WhenAddSingleDigit_ThenOperationIsDigit() {
        
        calculator.addDigit(4)
        
        XCTAssertEqual(calculator.textToCompute, "4")
    }
    
    func testGivenEmptyOperation_WhenAddMultipleDigits_ThenOperationIsDigits() {
        
        calculator.addDigit(4)
        calculator.addDigit(8)
        
        XCTAssertEqual(calculator.textToCompute, "48")
    }
    
    func testGivenEmptyOperation_WhenAddSingleZero_ThenOperationIsSingleZero() {
        
        calculator.addDigit(0)
        
        XCTAssertEqual(calculator.textToCompute, "0")
    }
    
    func testGivenEmptyOperation_WhenAddMultipleZero_ThenOperationIsSingleZero() {
        
        calculator.addDigit(0)
        calculator.addDigit(0)
        
        XCTAssertEqual(calculator.textToCompute, "0")
    }
    
    func testGivenZero_WhenAddOtherDigit_ThenOperationIsDigit() {
        
        calculator.addDigit(0)
        calculator.addDigit(1)
        
        XCTAssertEqual(calculator.textToCompute, "1")
    }
    
    
    func testGivenSimpleOperationWithZero_WhenAddExtraZero_ThenOperationIsNotAddingZero() {
        
        calculator.addDigit(0)
        try! calculator.addMathOperator(.plus)
        calculator.addDigit(0)
        
        calculator.addDigit(0)
        
        XCTAssertEqual(calculator.textToCompute, "0 + 0")
    }
    
    
    func testGivenSimpleOperationWithZero_WhenAddExtraOtherDigit_ThenOperationIsReplacingLastZero() {
        
        calculator.addDigit(0)
        try! calculator.addMathOperator(.plus)
        calculator.addDigit(0)
        
        calculator.addDigit(1)
        
        XCTAssertEqual(calculator.textToCompute, "0 + 1")
    }
    
    
    // MARK: - addMathOperator
    
    func testGivenOneDigit_WhenAddMathOperator_ThenGetDigitAndMathOperator() {
        
        calculator.addDigit(4)
        
        try! calculator.addMathOperator(.plus)
        
        XCTAssertEqual(calculator.textToCompute, "4 + ")
    }
    
    func testGivenEmptyOperation_WhenAddMathOperator_ThenGetError() {

        XCTAssertThrowsError(try calculator.addMathOperator(.plus), "") { (error) in
            let calculatorError = error as! CalculatorError
            XCTAssertEqual(calculatorError, CalculatorError.cannotAddMathOperator)
        }
    }
    
    
    
    func testGivenOneDigitAndOperator_WhenAddAnotherMathOperator_ThenGetError() {
        
        calculator.addDigit(4)
        try! calculator.addMathOperator(.plus)
        
        XCTAssertThrowsError(try calculator.addMathOperator(.plus), "") { (error) in
            let calculatorError = error as! CalculatorError
            XCTAssertEqual(calculatorError, CalculatorError.cannotAddMathOperator)
        }
    
    }
    
    
    // MARK: - resolveOperation
    
    func testGivenSimpleOperation_WhenResolvingOperation_ThenGetCorrectResult() {
        calculator.addDigit(2)
        try! calculator.addMathOperator(.plus)
        calculator.addDigit(2)
        
        try! calculator.resolveOperation()
        
        XCTAssertEqual(calculator.textToCompute, "2 + 2 = 4")
        
    }
    
    
    
}
