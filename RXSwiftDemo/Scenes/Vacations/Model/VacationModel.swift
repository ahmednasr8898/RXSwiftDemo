//
//  VacationModel.swift
//  HRApp
//
//  Created by Semicolon on 06/11/2022.
//

import Foundation


// MARK: - VacationModel
struct VacationModel: Codable {
    let success: Bool?
    let message: String?
    let data: [VacationData]?
}

// MARK: - VacationData
struct VacationData: Codable {
    let vacation: Vacation?

    enum CodingKeys: String, CodingKey {
        case vacation = "Vacation"
    }
}

// MARK: - Vacation
struct Vacation: Codable {
    let id, name, vacationDescription, startVaction: String?
    let endVation, numOfDays, employeeID, created: String?
    let modified: String?
    let active: Bool?
    let typeID: String?
    let photo: String?
    let totalPrice, vacationDiscount: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case vacationDescription = "description"
        case startVaction = "start_vaction"
        case endVation = "end_vation"
        case numOfDays = "num_of_days"
        case employeeID = "employee_id"
        case created, modified, active
        case typeID = "type_id"
        case photo
        case totalPrice = "total_price"
        case vacationDiscount = "vacation_discount"
    }
}
