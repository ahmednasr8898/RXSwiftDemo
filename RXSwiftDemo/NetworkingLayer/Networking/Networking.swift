//
//  Networking.swift
//  HRApp
//
//  Created by Semicolon on 12/10/2022.
//

import Foundation
import Alamofire

//MARK: - networking
//
class Networking {
    static let shared = Networking()
    private init(){}
}

//MARK: - authorization header
//
extension Networking {
    private func getAuthorizationHeader()-> HTTPHeaders? {
        let userData = LocalStorage.shared.getUserModel()
        guard let userName = userData?.employee?.numWork, let password = userData?.employee?.authKey else {
            return nil
        }

        let credentialData = "\(userName):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers: HTTPHeaders =
        [
            "Content-Type": "application/x-www-form-urlencoded",
            "Cache-Control": "no-cache",
            "Authorization": "Basic \(base64Credentials)",
            "lang": "en"
        ]
        
        return headers
    }
}

//MARK: - generic networking func
//
extension Networking {
    func connectToServer<T: Decodable>(EndPoint: URL, method: HTTPMethod, parameters: Parameters?,
                                       encoding: ParameterEncoding, completion: @escaping (T?, Error?)-> Void){
        
        let headers = getAuthorizationHeader()
        
        AF.request(EndPoint , method: method , parameters: parameters, encoding: encoding, headers: headers).response { (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(_):
                guard let data = response.data else {return}
                do{
                    let json = try JSONDecoder().decode(T.self, from: data)
                    completion(json , nil)
                }catch let jsonError{
                    completion(nil , jsonError)
                }
            }
        }
    }
}
