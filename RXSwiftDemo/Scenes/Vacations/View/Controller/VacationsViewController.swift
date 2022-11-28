//
//  VacationsViewController.swift
//  RXSwiftDemo
//
//  Created by Semicolon on 28/11/2022.
//

import UIKit
import RxSwift
import RxCocoa

class VacationsViewController: UIViewController {

    //MARK: - outlets
    //
    @IBOutlet weak var vacationsTableView: UITableView!
   
    //MARK: - variables
    //
    private let disposeBag = DisposeBag()
    private let viewModel: VacationsViewModelType
    
    //MARK: - init
    //
    init(viewModel: VacationsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        subscribeToIndicatorStatus()
        subscribeToErrorMessage()
        subscribeToErrorService()
        subscribeToTableView()
        subscribeToTableViewIsEmptyData()
        subscribeToSelectedItemInTableView()
    }
}

//MARK: - subscribe to Indicator status
//
extension VacationsViewController {
    private func subscribeToIndicatorStatus() {
        viewModel.activityIndicatorStatusObservable.subscribe { [weak self] isloading in
            guard let self = self else {return}
            Indicator.createIndicator(on: self, start: isloading)
        }.disposed(by: disposeBag)
    }
}

//MARK: - subscribe to ErrorMessage
//
extension VacationsViewController {
    private func subscribeToErrorMessage() {
        viewModel.errorMessageObservable.subscribe {[weak self] message in
            guard let self = self else {return}
            Alert.defaultAlert(on: self, message: message)
        }.disposed(by: disposeBag)
    }
}

//MARK: - subscribe to ErrorService
//
extension VacationsViewController {
    private func subscribeToErrorService() {
        viewModel.errorServiceObservable.subscribe {[weak self] error in
            guard let self = self else {return}
            Alert.failedToConnectWithServerAlert(on: self)
        }.disposed(by: disposeBag)
    }
}

//MARK: - set up table view
//
extension VacationsViewController {
    private func setupTableView() {
        vacationsTableView.register(VacationTableViewCell.Nib(), forCellReuseIdentifier: VacationTableViewCell.Identifier)
        vacationsTableView.rx.rowHeight.onNext(120)
    }
}


//MARK: - subscribe to table view is empty data
//
extension VacationsViewController {
    private func subscribeToTableViewIsEmptyData() {
//        viewModel.dataIsEmptyObservable.bind(to: vacationsTableView.rx.isHidden).disposed(by: disposeBag)
        
        viewModel.dataIsEmptyObservable.subscribe {[weak self] isEmpty in
            guard let self = self else {return}
            self.vacationsTableView.rx.isHidden.onNext(isEmpty)
        }.disposed(by: disposeBag)
    }
}

//MARK: - subscribe to table view
//
extension VacationsViewController {
    private func subscribeToTableView() {
        viewModel.vacationsObservable.bind(to: vacationsTableView.rx.items(cellIdentifier: VacationTableViewCell.Identifier, cellType: VacationTableViewCell.self)) { row, item, cell in
            
            cell.configration(data: item)
        }.disposed(by: disposeBag)
    }
}

//MARK: - subscribe to selected item in table view
//
extension VacationsViewController {
    private func subscribeToSelectedItemInTableView() {
        Observable.zip(vacationsTableView.rx.itemSelected, vacationsTableView.rx.modelSelected(VacationData.self)).bind { indexSelected, vacationModel in
            print("indexSelected", indexSelected.row)
            print("vacationModel", vacationModel)
        }.disposed(by: disposeBag)
    }
}
