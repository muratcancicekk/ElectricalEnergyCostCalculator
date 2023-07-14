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
    var usersData: [ElectricalEnergyModel]? { get set }
    func viewDidLoad()
    func start()
    func getUsersData()
}

final class HomeViewModel {
    @Published var customerNumber: String = ""
    @Published var currentMeter: String = ""
    @Published var isReady: Bool = false
    var usersData: [ElectricalEnergyModel]?
    var cancellables: Set<AnyCancellable> = []
    var registeredUser2: ElectricalEnergyModel?
    
    weak var view: HomeViewInterface?
    
    init(view: HomeViewInterface?) {
        self.view = view
    }
}

extension HomeViewModel: HomeViewModelInterface {
    
    func getUsersData() {
        do {
            usersData = try UserDefaultsOrganizer.users.getModel()
        } catch {
            // TODO: Logger
            AlertManager.showAlert(title: "ERROR", message: error.localizedDescription, preferredStyle: .alert)
        }
    }
    
    func start() {
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
