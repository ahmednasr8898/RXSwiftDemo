//
//  Repositories.swift
//  HRApp
//
//  Created by Semicolon on 19/10/2022.
//

import Foundation
import Alamofire

class Repositories {
    static let shared = Repositories()
    private init() {}
}

//MARK: - for convert model to Dictionary (parameters)
//
extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}


//MARK: - login
//
extension Repositories {
    func login(loginDataModel: LoginDataModel, completion: @escaping (LoginModel?, Error?)->Void) {
        let parameters = try! loginDataModel.asDictionary()
        guard let url = EndPoints.shared.login() else {return}
        Networking.shared.connectToServer(EndPoint: url, method: .post, parameters: parameters, encoding: URLEncoding.default) { (loginModel: LoginModel?, error: Error?) in
            
            completion(loginModel, error)
        }
    }
}

//MARK: - vacations -
//
extension Repositories {
    func  vacations(completion: @escaping (VacationModel?, Error?)-> Void) {
        guard let url = EndPoints.shared.Vacations() else {return}
        Networking.shared.connectToServer(EndPoint: url, method: .get, parameters: nil, encoding: JSONEncoding.default) { (vacationModel: VacationModel?, error: Error?) in
            
            completion(vacationModel, error)
        }
    }
}

