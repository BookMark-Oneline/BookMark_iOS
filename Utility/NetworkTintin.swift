//
//  NetworkTintin.swift
//  BookMark
//
//  Created by BoMin on 2023/02/13.
//

import Foundation
import Alamofire

class NetworkTintin {
    let baseUrl = "http://onve.synology.me"

    func getCommunityList(completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = baseUrl + "/club/user/\(UserInfo.shared.userID)"
        let datarequest = AF.request(URL, method: .get, encoding: JSONEncoding.default)
        
        datarequest.responseData(completionHandler: { res in
            switch res.result {
            case .success:
                print("yes")
                guard let value = res.value else {return}
                guard let rescode = res.response?.statusCode else {return}
                
                let networkResult = self.judgeStatus(object: 0, by: rescode, value)
                completion(networkResult)
                
            case .failure(let e):
                print(e)
                completion(.pathErr)
            }
        
        })
    }
}

extension NetworkTintin {
    private func judgeStatus(object: Int = 0, by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200:
            // 책모임 조회 용
            if (object == 0) {
                return isValidData_CommunityList(data: data)
            }
            else {
                return .success(data)
            }
        case 400: return .pathErr // 요청이 잘못됨
        case 500: return .serverErr // 서버 에러
        default: return .networkFail // 네트워크 에러
        }
    }
    
    private func isValidData_CommunityList(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()

        guard let decodedData = try? decoder.decode([CommunityList].self, from: data) else {
            return .decodeFail }
        
        return .success(decodedData)
    }
}
