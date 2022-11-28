//
//  LoginViewModelType.swift
//  RXSwiftDemo
//
//  Created by Semicolon on 28/11/2022.
//

import Foundation
import RxSwift
import RxCocoa

typealias LoginViewModelType = loginViewModelInput & LoginViewModelOutput


protocol loginViewModelInput {
    var phone: BehaviorRelay<String> { get }
    var password: BehaviorRelay<String> { get }
}


protocol LoginViewModelOutput {
    var activityIndicatorStatusObservable: Observable<Bool> { get }
    var loginStatusObservable: Observable<Bool> { get }
    var loginErrorMessageObservable: Observable<String> { get }
    var loginErrorServiceObservable: Observable<Error> { get }
    var buttonIsEnabled: Observable<Bool> { get }
    func login()
}
