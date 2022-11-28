//
//  Helper.swift
//  HRApp
//
//  Created by Semicolon on 16/10/2022.
//

import Foundation

//MARK: - local storage
//
struct LocalStorage {
    static let shared = LocalStorage()
    private init() {}
}

//MARK: - save user data model
//
extension LocalStorage {
    func saveUserModel(loginModel: LoignResponseModel?) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(loginModel) {
            UserDefaults.standard.set(encoded, forKey: "UserModel")
        }
    }
    
    func getUserModel()-> LoignResponseModel?{
        let defaults = UserDefaults.standard
        guard let savedPerson = defaults.object(forKey: "UserModel") as? Data else {
            return nil
        }
        let decoder = JSONDecoder()
        guard let loadedPerson = try? decoder.decode(LoignResponseModel.self, from: savedPerson) else {
            return nil
        }
        return loadedPerson
    }
}
