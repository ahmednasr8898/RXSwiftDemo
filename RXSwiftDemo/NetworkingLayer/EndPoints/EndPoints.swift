//
//  URLs.swift
//  HRApp
//
//  Created by Semicolon on 17/10/2022.
//

import Foundation

class EndPoints{
    
    static let shared = EndPoints()
    private init() {}
    
    var baseURL = "https://gostcode.com/petrojetHr/"
}


//MARK: - Login -
//
extension EndPoints {
    func login()-> URL? {
        return URL(string: baseURL + "Employees/appLogin")
    }
}

//MARK: - Vacations -
//
extension EndPoints {
    func Vacations()-> URL? {
        return URL(string: baseURL + "Vacations/appVacations")
    }
}

