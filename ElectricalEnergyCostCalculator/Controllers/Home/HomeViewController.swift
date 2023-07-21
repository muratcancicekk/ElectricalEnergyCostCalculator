//
//  HomeViewController.swift
//  ElectricalEnergyCostCalculator
//
//  Created by Murat Çiçek on 6.07.2023.
//

import UIKit
import Combine

protocol HomeViewInterface: AnyObject, SeguePerformable {
    func configureView()
    func bind()
    func pushVC(viewData: DetailsViewData)
    func showAlert(title: String, message: String)
}

final class HomeViewController: UIViewController {
    /// Customer Number
    @IBOutlet private weak var customerNumberLabel: UILabel!
    @IBOutlet private weak var customerNumberTextField: BaseTextField!
    /// Current Meter
    @IBOutlet private weak var currentMeterLabel: UILabel!
    @IBOutlet private weak var currentMeterTextField: BaseTextField!
    /// SubmitButton
    @IBOutlet private weak var submitButton: BaseButton!
    
    private lazy var viewModel = HomeViewModel(view: self)
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        bind()
    }
}
extension HomeViewController: HomeViewInterface {
    func showAlert(title: String, message: String) {
        AlertManager.showAlert(title: title , message: message, preferredStyle: .alert)
    }
    
    func pushVC(viewData: DetailsViewData ) {
        let detailsVC = DetailsViewController(viewData: viewData)
        detailsVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func bind() {
        customerNumberTextField.$fieldValue.assign(to: &viewModel.$customerNumber)
        currentMeterTextField.$fieldValue.assign(to: &viewModel.$currentMeter)
        
        viewModel.$isReady.sink {  isReady in
            self.submitButton.setupButtonUI(title: Constants.shared.globalSubmit, backgroundColor: isReady ? .blue.withAlphaComponent(0.6) : .gray.withAlphaComponent(0.6) , cornerRadius: 12)
        }.store(in: &cancellables)
        
    }
    
    func configureView() {
        customerNumberTextField.delegate = self
        submitButton.delegate = self
        submitButton.setupButtonUI(title: Constants.shared.globalSubmit, backgroundColor: .gray.withAlphaComponent(0.6), cornerRadius: 12)
        /// Customer Number Configure
        customerNumberLabel.configure(text: Constants.shared.customerNumber, font: .systemFont(ofSize: 16), textColor: .black, numberOfLines: 1)
        customerNumberTextField.setupTextfieldUI(cornerRadius: 12, placeHolder: Constants.shared.customerNumberPlaceHolder, textFiedldTypeChoose: .alphaNumerics)
        /// Customer Meter Configure
        currentMeterLabel.configure(text: Constants.shared.currentMeter, font: .systemFont(ofSize: 16), textColor: .black, numberOfLines: 1)
        customerNumberTextField.setupTextfieldUI(cornerRadius: 12, placeHolder: Constants.shared.currentMeterPlaceHolder, textFiedldTypeChoose: .number)
    }
}
extension HomeViewController: CustomButtonViewProtocol {
    func didButtonTapped(_ value: Int?) {
        viewModel.didButtonTapped()
    }
}
extension HomeViewController: BaseTextFieldEndEditingProtocol {
    func endEditing(text: String) {
        viewModel.endEditing(text: text)
    }
}
