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
        case .multiply: return "×"
        case .divide: return "÷"
        }
    }
}

protocol CalculatorDelegate {
    func didUpdateTextToCompute(textToCompute: String)
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
