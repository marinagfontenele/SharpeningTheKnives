import Foundation
import UIKit

enum Priority: String, CaseIterable, Codable {
    case low
    case medium
    case high
    case null
    
    var color: UIColor {
        switch self{
            case .low: return .green
            case .medium: return .yellow
            case .high: return .red
            case .null: return .gray
        }
    }
}
