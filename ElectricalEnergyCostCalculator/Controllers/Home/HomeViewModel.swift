//
//  HomeViewModel.swift
//  ElectricalEnergyCostCalculator
//
//  Created by Murat Çiçek on 6.07.2023.
//

import Foundation
import Combine

protocol HomeViewModelInterface: AnyObject {
    var view: HomeViewInterface? { get set }
    func viewDidLoad()
    func endEditing(text: String)
    func didButtonTapped()
}

final class HomeViewModel {
    @Published var customerNumber: String = ""
    @Published var currentMeter: String = ""
    @Published var isReady: Bool = false
   private var usersData: [ElectricalEnergyModel]?
   private var cancellables: Set<AnyCancellable> = []
   private var registeredUser2: ElectricalEnergyModel?
   private var registeredUserCurrentMeter: Int = 0
    
    weak var view: HomeViewInterface?
    
    init(view: HomeViewInterface?) {
        self.view = view
    }
}

extension HomeViewModel: HomeViewModelInterface {
    
    func didButtonTapped() {
        if Helpers.shared.checkMeter(currentMeter) == true && Helpers.shared.validateString(customerNumber) == true {
            if registeredUserCurrentMeter > Int(currentMeter ) ?? 0  {
                view?.showAlert(title: Constants.shared.globalError, message: Constants.shared.errorMessageHome + String(registeredUserCurrentMeter))
            } else {
                view?.pushVC(viewData: DetailsViewData(customerNumber: customerNumber, currentMeter: Int(currentMeter) ?? 0, usersData: usersData ?? [ElectricalEnergyModel(customerNumber: customerNumber, currentMeter: Int(currentMeter) ?? 0, lastMeter: 0, paymentValue: 0)]))
            }
        }
    }
    
    // When the textfield is end editing, it checks if there is a user belonging to the same customer number.
    func endEditing(text: String) {
        let registerUser = usersData?.filter { $0.customerNumber == text }
        if registerUser != [] || registerUser != nil {
            registeredUserCurrentMeter = registerUser?.first?.currentMeter ?? 0
        }
    }
    
   private func getUsersData() {
        do {
            usersData = try UserDefaultsOrganizer.users.getModel()
        } catch {
            LoggerManager.log(.error, error.localizedDescription)
            AlertManager.showAlert(title: Constants.shared.globalError, message: error.localizedDescription, preferredStyle: .alert)
        }
    }
    
   private func start() {
        Publishers.CombineLatest($customerNumber, $currentMeter).map {
            customerNumber, currentMeter in
            return !customerNumber.isEmpty && !currentMeter.isEmpty
        }
        .assign(to: \.isReady, on: self)
        .store(in: &cancellables)
    }
    
    func viewDidLoad() {
        start()
        view?.configureView()
        getUsersData()
    }
}
