import Foundation

enum CalculatorError: Error {
    case cannotAddMathOperatorAfterAnother
    case expressionIsIncorrect
    case expressionHasNotEnoughElement
    case cannotDivideByZero
    case cannotAddMathOperatorInTheBeginning
    case unknownMathOperator
    
    
    
    var errorMessage: String {
        switch self {
        case .cannotAddMathOperatorAfterAnother: return "Un operateur est déja mis !"
        case .expressionIsIncorrect: return "Entrez une expression correcte !"
        case .expressionHasNotEnoughElement: return "Démarrez un nouveau calcul !"
        case .cannotDivideByZero: return "Division par zéro impossible !"
        case .cannotAddMathOperatorInTheBeginning: return "Vous ne pouvez pas sélectionner un opérateur au début d'une opération !"
        case .unknownMathOperator: return "Math operateur inconnue !"
        }
    }
}
