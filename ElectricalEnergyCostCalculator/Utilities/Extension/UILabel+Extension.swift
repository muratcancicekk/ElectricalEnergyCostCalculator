//
//  UILabel+Extension.swift
//  ElectricalEnergyCostCalculator
//
//  Created by Murat Çiçek on 6.07.2023.
//

import UIKit

extension UILabel {
    func configure(text: String? = nil,
                   font: UIFont? = nil,
                   textColor: UIColor? = nil,
                   numberOfLines: Int? = nil) {
        self.text = text
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.numberOfLines = numberOfLines ?? 1
    }
}



