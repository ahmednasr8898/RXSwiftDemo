//
//  LoginViewController.swift
//  RXSwiftDemo
//
//  Created by Semicolon on 27/11/2022.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    //MARK: - outlets
    //
    @IBOutlet weak private var phoneTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var loginButton: UIButton!
    
    //MARK: - variables
    //
    private let disposeBag = DisposeBag()
    private let viewModel: LoginViewModelType
    
    //MARK: - init
    //
    init(viewModel: LoginViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToTextFields()
        subscribeToButtonEnabled()
        subscribeToIndicatorStatus()
        subscribeToErrorMessage()
        subscribeToErrorService()
        subscribeToLoignStatus()
        bindToLoginButton()
    }
}

//MARK: - bind to text fields
//
extension LoginViewController {
    private func bindToTextFields() {
        phoneTextField.rx.text.orEmpty.bind(to: viewModel.phone).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: disposeBag)
    }
}

//MARK: - subscribe to button enabled
//
extension LoginViewController {
    private func subscribeToButtonEnabled() {
        viewModel.buttonIsEnabled.subscribe { [weak self] buttonEnabled in
            guard let self = self else {return}
            self.loginButton.isEnabled = buttonEnabled
            switch buttonEnabled {
            case true:
                self.loginButton.backgroundColor = .blue
            case false:
                self.loginButton.backgroundColor = .gray
            }
        }.disposed(by: disposeBag)
    }
}

//MARK: - subscribe to Indicator status
//
extension LoginViewController {
    private func subscribeToIndicatorStatus() {
        viewModel.activityIndicatorStatusObservable.subscribe { [weak self] isloading in
            guard let self = self else {return}
            Indicator.createIndicator(on: self, start: isloading)
        }.disposed(by: disposeBag)
    }
}

//MARK: - subscribe to ErrorMessage
//
extension LoginViewController {
    private func subscribeToErrorMessage() {
        viewModel.loginErrorMessageObservable.subscribe {[weak self] message in
            guard let self = self else {return}
            Alert.defaultAlert(on: self, message: message)
        }.disposed(by: disposeBag)
    }
}

//MARK: - subscribe to ErrorService
//
extension LoginViewController {
    private func subscribeToErrorService() {
        viewModel.loginErrorServiceObservable.subscribe {[weak self] error in
            guard let self = self else {return}
            Alert.failedToConnectWithServerAlert(on: self)
        }.disposed(by: disposeBag)
    }
}

//MARK: - subscribe to login status
//
extension LoginViewController {
    private func subscribeToLoignStatus() {
        viewModel.loginStatusObservable.subscribe {[weak self] loginStatus in
            guard let _ = self else {return}
            if loginStatus {
                let vacationsPage = VacationsViewController(viewModel: VacationsViewModel())
                self?.navigationController?.pushViewController(vacationsPage, animated: true)
            }
        }.disposed(by: disposeBag)
    }
}

//MARK: - bind to login button
//
extension LoginViewController {
    private func bindToLoginButton() {
        loginButton.rx.tap.throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance).subscribe {[weak self] _ in
            guard let self = self else {return}
            self.viewModel.login()
        }.disposed(by: disposeBag)
    }
}

