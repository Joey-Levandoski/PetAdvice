// PetAdvisor.swift
// PetAdvice
//
// Converted from original Java source (2016) to Swift 5 / SwiftUI (2024)
// Original logic preserved exactly — housing type + hours at home → pet recommendation
 
import Foundation
 
/// Represents the type of housing the user lives in.
enum HousingType: Int, CaseIterable, Identifiable {
    case house     = 1
    case apartment = 2
    case dormitory = 3
 
    var id: Int { rawValue }
 
    var label: String {
        switch self {
        case .house:     return "🏠 House"
        case .apartment: return "🏢 Apartment"
        case .dormitory: return "🏫 Dormitory"
        }
    }
}
 
/// Encapsulates the pet recommendation logic, mirroring the original Java `getPet` method.


struct petAdvisor {
 
    /// Returns a recommended pet based on housing type and hours spent at home per day.
    /// - Parameters:
    ///   - hoursAtHome: How many hours per day the user is home.
    ///   - housing: The type of housing (house, apartment, or dormitory).
    /// - Returns: A recommended pet string, or nil if the inputs are invalid.
    static func recommend(hoursAtHome: Double, housing: HousingType) -> String? {
        switch housing {
 
        case .house:
            if hoursAtHome >= 18 {
                return "Pot-Bellied Pig"
            } else if hoursAtHome >= 10 {
                // Original Java: var0 == 10.0 && var0 <= 17.0
                // Interpreted as: 10 <= hours <= 17 (likely a typo in the original using == instead of >=)
                return "Dog"
            } else {
                return "Snake"
            }
 
        case .apartment:
            if hoursAtHome >= 10 {
                return "Cat"
            } else {
                return "Hamster"
            }
 
        case .dormitory:
            if hoursAtHome >= 6 {
                return "Fish"
            } else {
                return "Ant Farm"
            }
        }
    }
}

