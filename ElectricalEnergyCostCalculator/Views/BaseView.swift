//
//  BaseView.swift
//  ElectricalEnergyCostCalculator
//
//  Created by Murat Çiçek on 6.07.2023.
//

import UIKit

class BaseView: UIView {
    required override init(frame: CGRect) {
        super.init(frame: frame)
        ownFirstNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        ownFirstNib()
    }
}
