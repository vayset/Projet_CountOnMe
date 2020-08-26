import Foundation

enum CalculatorError: Error {
    case cannotAddMathOperator
    case expressionIsIncorrect
    case expressionHasNotEnoughElement
    case cannotDivideByZero
    
    
    var errorMessage: String {
        switch self {
        case .cannotAddMathOperator: return "Un operateur est déja mis !"
        case .expressionIsIncorrect: return "Entrez une expression correcte !"
        case .expressionHasNotEnoughElement: return "Démarrez un nouveau calcul !"
        case .cannotDivideByZero: return "Division par zéro impossible !"
        }
    }
}
