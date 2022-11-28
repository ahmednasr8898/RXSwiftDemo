//
//  VacationsViewModel.swift
//  RXSwiftDemo
//
//  Created by Semicolon on 28/11/2022.
//

import Foundation
import RxSwift
import RxCocoa

class VacationsViewModel: VacationsViewModelInput, VacationsViewModelOutput  {
    
    private var activityIndicatorStatus = PublishSubject<Bool>()
    var activityIndicatorStatusObservable: Observable<Bool> {
        return activityIndicatorStatus
    }
    
    private var errorMessage = PublishSubject<String>()
    var errorMessageObservable: Observable<String> {
        return errorMessage
    }
    
    private var errorService = PublishSubject<Error>()
    var errorServiceObservable: Observable<Error> {
        return errorService
    }
    
    private var dataIsEmpty = BehaviorRelay<Bool>(value: false)
    var dataIsEmptyObservable: Observable<Bool> {
        return dataIsEmpty.asObservable()
    }
   
    private var vacations = PublishSubject<[VacationData]>()
    var vacationsObservable: Observable<[VacationData]> {
        return vacations
    }
    
    init() {
        fetchVacations()
    }
}

//MARK: - fetch vacations
//
extension VacationsViewModel {
    private func fetchVacations() {
        activityIndicatorStatus.onNext(true)
        
        Repositories.shared.vacations {[weak self] vacationModel, error in
            guard let self = self else {return}
            self.activityIndicatorStatus.onNext(false)
            
            guard let vacationModel = vacationModel else {
                self.errorService.onNext(error!)
                return
            }
            
            guard vacationModel.success == true, vacationModel.message == nil else {
                self.errorMessage.onNext(vacationModel.message ?? "")
                return
            }
            
            guard let data = vacationModel.data, !data.isEmpty else {
                self.dataIsEmpty.accept(true)
                return
            }
            self.vacations.onNext(data)
        }
    }
}
