//
//  LoginModel.swift
//  HRApp
//
//  Created by Semicolon on 13/10/2022.
//

import Foundation


//MARK: - Login Data Model
struct LoginDataModel: Encodable {
    var phone: String
    var passowrd: String
}

// MARK: - LoginModel
struct LoginModel: Codable {
    let success: Bool?
    let message: String?
    let data: LoignResponseModel?
}

// MARK: - LoignResponseModel
struct LoignResponseModel: Codable {
    let employee: Employee?
    let profession: BasicItemInfo?
    let company: Company?
    let professiony, nationality: BasicItemInfo?
    let religion, timesWork: BasicItemInfo?
    let sallary: Sallary?
    let currency, nameWebsite, emailWebsite, addres: String?
    let phone, fax, logo, loginLogo: String?

    enum CodingKeys: String, CodingKey {
        case employee = "Employee"
        case profession = "Profession"
        case company = "Company"
        case professiony = "Professiony"
        case nationality = "Nationality"
        case religion = "Religion"
        case timesWork = "TimesWork"
        case sallary = "Sallary"
        case currency
        case nameWebsite = "name_website"
        case emailWebsite = "email_website"
        case addres, phone, fax, logo
        case loginLogo = "login_logo"
    }
}

// MARK: - Employee
struct Employee: Codable {
    let id, numWork, fullName, authKey: String?
    let deviceToken: String?
    let phoneNum, email, sex, comment: String?
    let socialStatus, durationVacation, timesWorkID, birthday: String?
    let professionID, nationalityID, religionID, visaNumber: String?
    let dateFirstEntry, dateIssuacePassport, expirationPassport, residencyNumber: String?
    let dateIssuaceResidency, yearContract: String?
    let photo: String?
    let insuranceNumber: String?
    let dateStartInsurance, dateEndInsurance, numberEntro: String?
    let startWork, dateEndContract, professionI, passportNumber: String?
    let qr: Bool?
    let lang, transferSalaryType, companyID: String?
    let virification_code: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case numWork = "num_work"
        case fullName = "full_name"
        case authKey = "auth_key"
        case deviceToken = "device_token"
        case phoneNum = "phone_num"
        case email, sex, comment
        case socialStatus = "social_status"
        case durationVacation = "duration_vacation"
        case timesWorkID = "times_work_id"
        case birthday
        case professionID = "profession_id"
        case nationalityID = "nationality_id"
        case religionID = "religion_id"
        case visaNumber = "visa_number"
        case dateFirstEntry = "date_first_entry"
        case dateIssuacePassport = "date_issuace_passport"
        case expirationPassport = "expiration_passport"
        case residencyNumber = "residency_number"
        case dateIssuaceResidency = "date_issuace_residency"
        case yearContract = "year_contract"
        case photo
        case insuranceNumber = "insurance_number"
        case dateStartInsurance = "date_start_insurance"
        case dateEndInsurance = "date_end_insurance"
        case numberEntro = "number_entro"
        case startWork = "start_work"
        case dateEndContract = "date_end_contract"
        case professionI = "profession_i"
        case passportNumber = "passport_number"
        case qr, lang
        case transferSalaryType = "transfer_salary_type"
        case companyID = "company_id"
        case virification_code
    }
}

//MARK: - profession
struct BasicItemInfo: Codable {
    var id: String?
    var title, description, off_days: String?
}


// MARK: - Company
struct Company: Codable {
    let id, nameCompany, companieState, companieCity: String?
    let companieCountry, companiePhone, companieFax, companieMobile: String?
    let companieEmail, invoiceLogo, companieAddress1: String?

    enum CodingKeys: String, CodingKey {
        case id
        case nameCompany = "name_company"
        case companieState = "companie_state"
        case companieCity = "companie_city"
        case companieCountry = "companie_country"
        case companiePhone = "companie_phone"
        case companieFax = "companie_fax"
        case companieMobile = "companie_mobile"
        case companieEmail = "companie_email"
        case invoiceLogo = "invoice_logo"
        case companieAddress1 = "companie_address_1"
    }
}

// MARK: - Sallary
struct Sallary: Codable {
    let id, basicSalary, mountSubsistence, housingAllowance: String?
    let accoubtNumber, otherSalary, employeeID, created: String?
    let modified, total: String?

    enum CodingKeys: String, CodingKey {
        case id
        case basicSalary = "basic_salary"
        case mountSubsistence = "mount_subsistence"
        case housingAllowance = "housing_allowance"
        case accoubtNumber = "accoubt_number"
        case otherSalary = "other_salary"
        case employeeID = "employee_id"
        case created, modified, total
    }
}
