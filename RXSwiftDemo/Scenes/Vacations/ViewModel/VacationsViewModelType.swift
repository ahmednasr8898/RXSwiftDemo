//
//  VacationsViewModelType.swift
//  RXSwiftDemo
//
//  Created by Semicolon on 28/11/2022.
//

import Foundation
import RxSwift
import RxCocoa

typealias VacationsViewModelType = VacationsViewModelInput & VacationsViewModelOutput


protocol VacationsViewModelInput {
    
}

protocol VacationsViewModelOutput {
    var activityIndicatorStatusObservable: Observable<Bool> { get }
    var errorMessageObservable: Observable<String> { get }
    var errorServiceObservable: Observable<Error> { get }
    var dataIsEmptyObservable: Observable<Bool> { get }
    var vacationsObservable: Observable<[VacationData]> { get }
}
