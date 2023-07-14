//
//  ElectricalCalculatorManager.swift
//  ElectricalEnergyCostCalculator
//
//  Created by Murat Çiçek on 6.07.2023.
//

import Foundation

final class ElectricalCalculatorManager {
    
    func calculateElectricityCost(currentReading: Int, previousReading: Int) -> Double {
        let unit1Cost: Double = 5
        let unit2Cost: Double = 8
        let unit3Cost: Double = 10
        
        let unit1Limit: Int = 100
        let unit2Limit: Int = 500
        
        var cost: Double = 0
        
        let consumption = currentReading - previousReading
        
        if consumption <= 0 {
            // TODO: Alert
            print("Hata: Geçersiz okuma değerleri!")
            return cost
        }
        
        if consumption <= unit1Limit {
            cost = Double(consumption) * unit1Cost
        } else if consumption <= unit2Limit {
            cost = Double(unit1Limit) * unit1Cost
            cost += Double(consumption - unit1Limit) * unit2Cost
        } else {
            cost = Double(unit1Limit) * unit1Cost
            cost += Double(unit2Limit - unit1Limit) * unit2Cost
            cost += Double(consumption - unit2Limit) * unit3Cost
        }
        
        return cost
    }

    
}
