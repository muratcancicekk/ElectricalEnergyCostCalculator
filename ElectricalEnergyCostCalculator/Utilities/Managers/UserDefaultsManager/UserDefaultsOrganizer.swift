//
//  UserDefaultsOrganizer.swift
//  ElectricalEnergyCostCalculator
//
//  Created by Murat Çiçek on 6.07.2023.
//

import Foundation

enum UserDefaultsOrganizer {
    static let users = UserDefaultsUnityManager<[ElectricalEnergyModel]>(key: .USERS)
}
