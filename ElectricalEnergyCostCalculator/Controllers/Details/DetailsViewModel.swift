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
    var customerNumber: String = ""
    var currentMeter: Int = 0
    var previousMeter: Int = 0
    var amount: Double = 0
    var usersData = [ElectricalEnergyModel]()
    var registeredUserData: ElectricalEnergyModel?
    weak var view: DetailsViewControllerInterface?
    
    init(viewData: DetailsViewData, view: DetailsViewControllerInterface) {
        self.customerNumber = viewData.customerNumber
        self.currentMeter = viewData.currentMeter
        self.usersData = viewData.usersData
        self.view = view
    }
    
}
extension DetailsViewModel: DetailsViewModelInterface {
    
    func registeredUser() -> ElectricalEnergyModel? {
        if let foundModel = usersData.first(where: { $0.customerNumber == customerNumber }) {
            var updatedModel = foundModel
            return updatedModel
        } else {
            
        }
        return nil
    }
    
    func setUser() {
        let registerUser = registeredUser()
        if registerUser != nil {
            let data = ElectricalEnergyModel(customerNumber: customerNumber, currentMeter: Int(currentMeter) , lastMeter:registerUser?.lastMeter ?? 0 , paymentValue: amount)
            usersData.append(data)
            do {
                try UserDefaultsOrganizer.users.setModel(usersData)
            } catch {
                // TODO: Logger
                print("error")
            }
        }
        
        let data = ElectricalEnergyModel(customerNumber: customerNumber, currentMeter: Int(currentMeter) , lastMeter: 0, paymentValue: amount)
        usersData.append(data)
        do {
            try UserDefaultsOrganizer.users.setModel(usersData)
        } catch {
            // TODO: Logger
            print("error")
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
        view?.configure()
    }
}
