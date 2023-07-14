//
//  UIButton+Extension.swift
//  ElectricalEnergyCostCalculator
//
//  Created by Murat Çiçek on 6.07.2023.
//

import UIKit

extension UIButton {

    func setCornerRadius(_ cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
    
    func setShadow(color: UIColor, offset: CGSize, radius: CGFloat, opacity: Float) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    func setButtonProperties(title: String?, titleColor: UIColor, for state: UIControl.State) {
           setTitle(title, for: state)
           setTitleColor(titleColor, for: state)
       }
}
