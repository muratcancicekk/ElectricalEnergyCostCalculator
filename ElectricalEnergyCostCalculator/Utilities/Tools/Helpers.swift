//
//  Helpers.swift
//  ElectricalEnergyCostCalculator
//
//  Created by Murat Çiçek on 6.07.2023.
//

import UIKit

final class Helpers {
    static let shared = Helpers()
    
    func countLetters(string: String) -> Int {
        let letters = CharacterSet.letters
        let letterSet = CharacterSet(charactersIn: string)
        let letterCharacterSet = letters.intersection(letterSet)
        let letterCount = string.unicodeScalars.filter(letterCharacterSet.contains).count
        return letterCount
    }

    func checkMeter(_ input: String) -> Bool {
        guard let intValue = Int(input) else {
            // TODO: Alert
             return false
         }
         
         guard intValue >= 0 else {
             return false
         }
         
         return true
    }
    
    func validateString(_ input: String) -> Bool {
        let alphanumericCharacterSet = CharacterSet.alphanumerics
        
        guard input.count == 10 else {
            return false
        }
        
        let inputCharacterSet = CharacterSet(charactersIn: input)
        guard alphanumericCharacterSet.isSuperset(of: inputCharacterSet) else {
            return false
        }
        
        return true
    }
    
}
