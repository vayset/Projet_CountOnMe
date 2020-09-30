import UIKit

class CalculatorViewController: UIViewController {
    
    // MARK: - INTERNAL
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator.delegate = self
    }

    // MARK: - PRIVATE
    
    // MARK: Properties - Private
    
    private let calculator = Calculator()
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var operationTextView: UITextView!
    
    // MARK: Methods - Private
    
    private func handleCalculatorError(error: Error) {
        guard let calculatorError = error as? CalculatorError else { return }
        presentSimpleAlert(message: calculatorError.errorMessage)
    }
    
    private func presentSimpleAlert(message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    // MARK: IBActions
    
    @IBAction private func didTapOnDigitButton(_ sender: UIButton) {
        calculator.addDigit(sender.tag)
    }
    
    @IBAction private func didTapOnMathOperatorButton(_ sender: UIButton) {
        let mathOperator = MathOperator.allCases[sender.tag]
        do {
            try calculator.addMathOperator(mathOperator)
        } catch {
            handleCalculatorError(error: error)
        }
    }
    
    @IBAction private func didTapOnResetButton() {
        calculator.reset()
    }
    
    @IBAction private func didTapOnEqualButton(_ sender: UIButton) {
        do {
            try calculator.resolveOperation()
        } catch {
            handleCalculatorError(error: error)
        }
    }
    
}

extension CalculatorViewController: CalculatorDelegate {
    
    func didUpdateTextToCompute(textToCompute: String) {
        operationTextView.text = textToCompute
    }
}
