//
//  ElectricalEnergyModel.swift
//  ElectricalEnergyCostCalculator
//
//  Created by Murat Çiçek on 6.07.2023.
//

import Foundation


struct ElectricalEnergyModel: Codable {
    let customerNumber: String
    var currentMeter: Int
    var lastMeter: Int
    var paymentValue: Double
}
