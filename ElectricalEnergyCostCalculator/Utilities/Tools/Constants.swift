//
//  Constants.swift
//  ElectricalEnergyCostCalculator
//
//  Created by Murat Çiçek on 6.07.2023.
//

import Foundation

final class Constants {
    static let shared = Constants()
    /// Gloabal
    let globalOk = "OK"
    let globalCancel = "Cancel"
    let globalSubmit = "Submit"
    let globalError = "Error"
    let globalSave = "Save"
    /// Alert
    let alphaNumericAlertHeader = "Invalid Customer Number"
    let alphaNumericAlertDesc = "Please check the customer number you entered"
    /// Home
    let customerNumber = "Customer number:"
    let customerNumberPlaceHolder = "Customer number*"
    let currentMeter = "Current Meter:"
    let currentMeterPlaceHolder = "Current meter*"
    let errorMessageHome = "You need to enter a value higher than the one you entered in the past. Last entered value:"
    let electricMeter = "Electric Meter:"
    let paymentAmount = "Payment Amount:"
}
