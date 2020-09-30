import Foundation

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
