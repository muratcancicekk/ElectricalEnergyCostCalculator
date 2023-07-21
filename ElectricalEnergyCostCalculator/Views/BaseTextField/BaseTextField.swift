//
//  BaseTextField.swift
//  ElectricalEnergyCostCalculator
//
//  Created by Murat Çiçek on 6.07.2023.
//

import UIKit

enum TextFieldTypeChoose {
    case alphaNumerics
    case normal
    case number
}

protocol BaseTextFieldEndEditingProtocol: AnyObject {
    func endEditing(text: String)
}

class BaseTextField: BaseView {
    
    @IBOutlet private weak var textField: UITextField!
    
    var textFieldType: TextFieldTypeChoose = .normal
    var delegate: BaseTextFieldEndEditingProtocol?
    
    @Published var fieldValue = "" {
        didSet {
            if !fieldValue.isEmpty {
                textField.text = fieldValue
                textField.placeholder = ""
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textField.delegate = self
    }
    
    func setupTextfieldUI(cornerRadius: CGFloat, placeHolder: String, textFiedldTypeChoose: TextFieldTypeChoose) {
        textField.applyCornerRadius(cornerRadius: cornerRadius)
        textField.applyShadow(color: .gray, offset: CGSize(width: 1, height: 3), radius: 3, opacity: 0.2)
        textField.placeholder = placeHolder
        setKeyboardType(for: textFieldType)
        textFieldType = textFiedldTypeChoose
    }
    
}

extension BaseTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.blue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textFieldType == .alphaNumerics {
            if !validateAlphanumeric() {
                let okAction = UIAlertAction(title: Constants.shared.globalOk, style: .default, handler: nil)
                let cancelAction = UIAlertAction(title: Constants.shared.globalCancel, style: .cancel, handler: nil)

                AlertManager.showAlert(title: Constants.shared.alphaNumericAlertHeader, message: Constants.shared.alphaNumericAlertDesc, preferredStyle: .alert, actions: [okAction, cancelAction])
            }
        }
        
        if textField.text?.isEmpty ?? true {
            textField.layer.borderColor = UIColor.black.cgColor
        }
        delegate?.endEditing(text: textField.text ?? "")
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        fieldValue = textField.text ?? ""
    }
}

extension BaseTextField {
    
    func setKeyboardType(for type: TextFieldTypeChoose) {
        switch type {
        case .alphaNumerics:
            textField.keyboardType = .asciiCapable
        case .normal:
            textField.keyboardType = .default
        case .number:
            textField.keyboardType = .numberPad
        }
    }
    
    func validateAlphanumeric() -> Bool {
        guard let text = textField.text else {
            return false
        }
        
        let alphanumericCharacterSet = CharacterSet.alphanumerics
        let inputCharacterSet = CharacterSet(charactersIn: text)
        return alphanumericCharacterSet.isSuperset(of: inputCharacterSet)
    }
}
