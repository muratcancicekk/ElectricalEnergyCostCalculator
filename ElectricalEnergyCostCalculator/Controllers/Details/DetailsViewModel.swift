//
//  DetailsViewModel.swift
//  ElectricalEnergyCostCalculator
//
//  Created by Murat Çiçek on 6.07.2023.
//

import Foundation

struct DetailsViewData {
    let customerNumber: String
    let currentMeter: Int
    let usersData: [ElectricalEnergyModel]
}

protocol DetailsViewModelInterface: AnyObject {
    var view: DetailsViewControllerInterface? { get set }
    func viewDidLoad()
    func electricCalculator()
    func setUser()
    func registeredUser() -> ElectricalEnergyModel?
}

final class DetailsViewModel {
    
   private var customerNumber: String = ""
   private var currentMeter: Int = 0
   private var previousMeter: Int = 0
   private var amount: Double = 0
   private var usersData = [ElectricalEnergyModel]()
   private var registeredUserData: ElectricalEnergyModel?
    weak var view: DetailsViewControllerInterface?
    
    init(viewData: DetailsViewData, view: DetailsViewControllerInterface) {
        self.customerNumber = viewData.customerNumber
        self.currentMeter = viewData.currentMeter
        self.usersData = viewData.usersData
        self.view = view
    }
    
}
extension DetailsViewModel: DetailsViewModelInterface {
    
    // find registered user
    func registeredUser() -> ElectricalEnergyModel? {
        if let foundModel = usersData.first(where: { $0.customerNumber == customerNumber }) {
            let updatedModel = foundModel
            return updatedModel
        }
        return nil
    }
    
    func setUser() {
        let registerUser = registeredUser()
        if registerUser != nil {
            do {
                if let index = usersData.firstIndex(where: { $0.customerNumber == customerNumber }) {
                    usersData[index].currentMeter = currentMeter
                    usersData[index].paymentValue = amount
                    try UserDefaultsOrganizer.users.setModel(usersData)
                }
            } catch {
                LoggerManager.log(.error, error.localizedDescription)
            }
            
        } else {
            let data = ElectricalEnergyModel(customerNumber: customerNumber, currentMeter: Int(currentMeter) , lastMeter: 0, paymentValue: amount)
            usersData.append(data)
            do {
                try UserDefaultsOrganizer.users.setModel(usersData)
            } catch {
                LoggerManager.log(.error, error.localizedDescription)
            }
        }
    }
    
    func electricCalculator() {
        if registeredUserData != nil {
            amount = ElectricalCalculatorManager().calculateElectricityCost(currentReading: currentMeter, previousReading: registeredUserData?.currentMeter ?? 0)
        } else {
            amount = ElectricalCalculatorManager().calculateElectricityCost(currentReading: currentMeter, previousReading: 0)
        }
    }
    
    func viewDidLoad() {
        registeredUserData = registeredUser()
        electricCalculator()
        view?.configure(amount: amount, currentMeter: currentMeter)
    }
}
