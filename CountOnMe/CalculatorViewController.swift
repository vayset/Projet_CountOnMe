import UIKit

enum MathOperator: CaseIterable {
    case plus
    case minus
    case divide
    case multiply
    
    
    var symbol: String {
        switch self {
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "x"
        case .divide: return "/"
        }
    }
}

protocol CalculatorDelegate {
    func didUpdateTextToCompute(textToCompute: String)
}


class Calculator {
    //zzz
    
    var delegate: CalculatorDelegate?
    
    var textToCompute: String = "" {
        didSet {
            delegate?.didUpdateTextToCompute(textToCompute: textToCompute)
        }
    }
    
    var elements: [String] {
        return textToCompute.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveResult: Bool {
        return textToCompute.firstIndex(of: "=") != nil
    }
    
    
    func addDigit(_ digit: Int) {
        
        textToCompute.append(digit.description)
    }
    
    func addMathOperator(_ mathOperator: MathOperator) {
        if canAddOperator {
            textToCompute.append(" \(mathOperator.symbol) ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            //self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    
    func resolveOperation() {
        guard expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            //return self.present(alertVC, animated: true, completion: nil)
            return
        }
        
        guard expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            //return self.present(alertVC, animated: true, completion: nil)
            return
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
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        textToCompute.append(" = \(operationsToReduce.first!)")
    }
    
    
}

class CalculatorViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator.delegate = self
    }
    
    private let calculator = Calculator()
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        calculator.addDigit(sender.tag)
    }
    
    @IBAction func tappedMathOperatorButton(_ sender: UIButton) {
        let mathOperator = MathOperator.allCases[sender.tag]
        calculator.addMathOperator(mathOperator)
    }
    
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculator.resolveOperation()
    }
    
}


extension CalculatorViewController: CalculatorDelegate {
    func didUpdateTextToCompute(textToCompute: String) {
        textView.text = textToCompute
    }
    
    
}