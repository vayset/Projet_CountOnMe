import Foundation

protocol CalculatorDelegate {
    func didUpdateTextToCompute(textToCompute: String)
}

class Calculator {
    
    // MARK: - INTERNAL
    
    // MARK: Properties - Internal
    
    var delegate: CalculatorDelegate?
    
    var textToCompute: String = "" {
        didSet {
            delegate?.didUpdateTextToCompute(textToCompute: textToCompute)
        }
    }
    

    
    // textToCompute => String => "23 + 5 - 25"
    // elements => [String] => ["23", "+", "5", "-", "0"]
    
    // MARK: Methods - Internal
    
    func addDigit(_ digit: Int) {
        
        if elements.last == "0" {
            textToCompute.removeLast()
        }
        
        textToCompute.append(digit.description)
    }
    
    func addMathOperator(_ mathOperator: MathOperator) throws {
        if canAddOperator {
            textToCompute.append(" \(mathOperator.symbol) ")
        } else {
            throw CalculatorError.cannotAddMathOperator
        }
    }
    
    func reset() {
        textToCompute.removeAll()
    }
    
    func resolveOperation() throws {
        guard expressionIsCorrect else {
            throw CalculatorError.expressionIsIncorrect
        }
        
        guard expressionHaveEnoughElement else {
            throw CalculatorError.expressionHasNotEnoughElement
        }
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "×": result = left * right
            case "÷":
                guard right != 0 else { throw CalculatorError.cannotDivideByZero }
                result = left / right
            default: fatalError("Unknown operator !")
                
                
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        textToCompute.append(" = \(operationsToReduce.first!)")
    }
    
    
    
    
    
    
    // MARK: - PRIVATE
    
    private var elements: [String] {
        return textToCompute.split(separator: " ").map { "\($0)" }
    }
    
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    private var expressionHaveResult: Bool {
        return textToCompute.firstIndex(of: "=") != nil
    }
    
    
    
    
}
