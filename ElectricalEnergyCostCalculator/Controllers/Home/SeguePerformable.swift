//
//  SeguePerformable.swift
//  ElectricalEnergyCostCalculator
//
//  Created by Murat Çiçek on 6.07.2023.
//

import UIKit

protocol SeguePerformable {
    func performSegue(identifier: String)
}
extension SeguePerformable where Self: UIViewController {
    func performSegue(identifier: String) {
        performSegue(withIdentifier: identifier, sender: self)
    }
    
}
