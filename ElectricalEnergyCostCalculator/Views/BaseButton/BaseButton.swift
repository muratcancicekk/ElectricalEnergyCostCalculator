//
//  BaseButton.swift
//  ElectricalEnergyCostCalculator
//
//  Created by Murat Çiçek on 6.07.2023.
//

import UIKit

protocol CustomButtonViewProtocol {
    func didButtonTapped(_ value: Int?)
}

class BaseButton: BaseView {
    
    @IBOutlet weak var baseButton: UIButton!
    
    var delegate: CustomButtonViewProtocol?

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupButtonUI(title:String, titleColor: UIColor = .white, backgroundColor: UIColor = .blue, cornerRadius: CGFloat = 12, isEnable: Bool = true) {
        baseButton.setButtonProperties(title: title, titleColor: titleColor, for: .normal)
        baseButton.backgroundColor = backgroundColor
        baseButton.setCornerRadius(cornerRadius)
        baseButton.isEnabled = isEnable
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.didButtonTapped((sender as? UIButton)?.tag)
    }
}
