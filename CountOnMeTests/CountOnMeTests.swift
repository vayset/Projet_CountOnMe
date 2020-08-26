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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testGivenAddDigitIsNullWhenSelectDigitThenDigitCorrespondToTextCompute() {
        let calculator = Calculator()
        
        calculator.addDigit(4)
        
        XCTAssert(calculator.textToCompute == "4")
    }
    
    func testMathOperation() {
        let calculator = Calculator()
        
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
