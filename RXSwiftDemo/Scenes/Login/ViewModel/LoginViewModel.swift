//
//  LoginViewModel.swift
//  RXSwiftDemo
//
//  Created by Semicolon on 27/11/2022.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel: loginViewModelInput, LoginViewModelOutput {

    //MARK: - varaibles
    var phone = BehaviorRelay<String>(value: "")
    var password = BehaviorRelay<String>(value: "")
    
    private var activityIndicatorStatus = PublishSubject<Bool>()
    var activityIndicatorStatusObservable: Observable<Bool> {
        return activityIndicatorStatus
    }
    
    private var loginStatus = PublishSubject<Bool>()
    var loginStatusObservable: Observable<Bool> {
        return loginStatus
    }
    
    private var loginErrorMessage = PublishSubject<String>()
    var loginErrorMessageObservable: Observable<String> {
        return loginErrorMessage
    }
    
    private var loginErrorService = PublishSubject<Error>()
    var loginErrorServiceObservable: Observable<Error> {
        return loginErrorService
    }
    
    private var phoneIsValid: Observable<Bool> {
        return phone.asObservable().map { phone in
            let isEmpty = !phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && phone.count >= 6
            return isEmpty
        }
    }
    
    private var passwordIsValid: Observable<Bool> {
        return password.asObservable().map { password in
            let isEmpty = !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && password.count >= 6
            return isEmpty
        }
    }
    
    var buttonIsEnabled: Observable<Bool> {
        return Observable.combineLatest(phoneIsValid, passwordIsValid) { phoneIsEmpty, passwordIsEmpty in
            let buttonEnabled = phoneIsEmpty && passwordIsEmpty
            return buttonEnabled
        }
    }
}


//MARK: - login method
//
extension LoginViewModel {
    func login() {
        activityIndicatorStatus.onNext(true)
        
        let loginDataModel = LoginDataModel(phone: self.phone.value, passowrd: self.password.value)
        
        Repositories.shared.login(loginDataModel: loginDataModel) { [weak self] loginModel, error in
            guard let self = self else {return}
            self.activityIndicatorStatus.onNext(false)
            
            guard let loginModel = loginModel else {
                self.loginStatus.onNext(false)
                self.loginErrorService.onNext(error!)
                return
            }
            
            if loginModel.success == true {
                LocalStorage.shared.saveUserModel(loginModel: loginModel.data)
                self.loginStatus.onNext(true)
            } else {
                self.loginStatus.onNext(false)
                self.loginErrorMessage.onNext(loginModel.message!)
            }
        }
    }
}
