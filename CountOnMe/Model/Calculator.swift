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
        
        removeOperationIfHasResult()
        
        if elements.last == "0" {
            textToCompute.removeLast()
        }
        
        textToCompute.append(digit.description)
    }
    
    func addMathOperator(_ mathOperator: MathOperator) throws {
        
        removeOperationIfHasResult()
        
        try ensureCanAddOperator()
        
        textToCompute.append(" \(mathOperator.symbol) ")
    }
    
    func reset() {
        textToCompute.removeAll()
    }
    
    func resolveOperation() throws {
       try ensureCanResolveOperation()
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        var startRectangleIndex = 0
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            guard
                let left = Double(operationsToReduce[startRectangleIndex]),
                let right = Double(operationsToReduce[startRectangleIndex + 2])
                else { throw CalculatorError.expressionIsIncorrect }
            
            let operand = operationsToReduce[startRectangleIndex + 1]
            
            let isOperationContainingPriorityOperator = operationsToReduce.contains("×") || operationsToReduce.contains("÷")
            let isRectangleOperandAPriorityOperator = operand == "×" || operand == "÷"
            
            if isOperationContainingPriorityOperator && !isRectangleOperandAPriorityOperator {
                startRectangleIndex += 2
                continue
            }
            
            let result: Double
            
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "×": result = left * right
            case "÷":
                guard right != 0 else { throw CalculatorError.cannotDivideByZero }
                result = left / right
            default: throw CalculatorError.impossibleAction
                //                fatalError("Unknown operator !")
                
                
            }
            
            operationsToReduce.removeSubrange(startRectangleIndex...startRectangleIndex + 2)
            let formattedResult = getFormattedResult(from: result)
            operationsToReduce.insert("\(formattedResult)", at: startRectangleIndex)
            startRectangleIndex = 0
        }
        
        
        let finalResult = operationsToReduce.first!
        
            
            
        
        textToCompute.append(" = \(finalResult)")
    }
    
    
    // MARK: - PRIVATE
    
    private var elements: [String] {
        return textToCompute.split(separator: " ").map { "\($0)" }
    }
    
    private var expressionIsCorrect: Bool {
        return !isLastElementOperator
    }
    
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    

    private func ensureCanAddOperator() throws {
        guard !isLastElementOperator else {
            throw CalculatorError.cannotAddMathOperatorAfterAnother
        }
        guard !textToCompute.isEmpty else {
            throw CalculatorError.cannotAddMathOperatorInTheBeginning
        }
    }
    
    private func ensureCanResolveOperation() throws {
        guard expressionIsCorrect else {
            throw CalculatorError.expressionIsIncorrect
        }
        
        guard expressionHaveEnoughElement else {
            throw CalculatorError.expressionHasNotEnoughElement
        }
    }
    
    private func getFormattedResult(from result: Double) -> String {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .decimal
        
        let formmatedResult = numberFormatter.string(from: result as NSNumber)!
        
        return formmatedResult
    }
    
    private var isLastElementOperator: Bool {
        return MathOperator.allCases.contains(where: { $0.symbol == elements.last } )
        //return elements.last == "+" || elements.last == "-" || elements.last == "×" || elements.last == "÷"
    }

    
    private var expressionHaveResult: Bool {
        return textToCompute.contains("=")
    }
    
    
    private func removeOperationIfHasResult() {
        if expressionHaveResult {
            textToCompute.removeAll()
        }
    }
    
//    private var operationPriority: Bool {
//
//    }
    
    
    
}
