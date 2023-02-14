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

// MARK: - API 2-1 [GET] 유저 책모임 조회
    func getCommunityList(completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = baseUrl + "/club/user/\(UserInfo.shared.userID)"
        let datarequest = AF.request(URL, method: .get, encoding: JSONEncoding.default)
        
        datarequest.responseData(completionHandler: { res in
            switch res.result {
            case .success:
                print("CommunityList")
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
    
// MARK: - API 2-2 [GET] 책모임(공지, 이름, 게시물 목록) 조회
    func getCommunityInfo(completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = baseUrl + "/club/1"
        let datarequest = AF.request(URL, method: .get, encoding: JSONEncoding.default)
        
        datarequest.responseData(completionHandler: { res in
            switch res.result {
            case .success:
                print("CommunityInfo")
                guard let value = res.value else {return}
                guard let rescode = res.response?.statusCode else {return}
                
                let networkResult = self.judgeStatus(object: 1, by: rescode, value)
                completion(networkResult)
                
            case .failure(let e):
                print(e)
                completion(.pathErr)
            }
        
        })
    }
    
// MARK: - API 2-9 [POST] 책모임 가입 요청 전달

// MARK: - API 2-10 [GET] 책모임 검색 조회
    func getCommunitySearchResult(clubID: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        print("API ClubID \(clubID)")
        let URL = baseUrl + "/club/search/\(clubID)"
//        let URL = baseUrl + "/club/search/1"
        let datarequest = AF.request(URL, method: .get, encoding: JSONEncoding.default)
        
        datarequest.responseData(completionHandler: { res in
            switch res.result {
            case .success:
                print("CommunitySearchInfo")
                guard let value = res.value else {return}
                guard let rescode = res.response?.statusCode else {return}

                let networkResult = self.judgeStatus(object: 2, by: rescode, value)
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
            else if (object == 1) {
                return isValidData_CommunityInfo(data: data)
            }
            else if (object == 2) {
                return isValidData_CommuniySearchResult(data: data)
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
            return .decodeFail
        }
        
        return .success(decodedData)
    }
    
    private func isValidData_CommunityInfo(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(CommunityInfo.self, from: data) else {
            return .decodeFail
        }
        
        return .success(decodedData)
    }
    
    private func isValidData_CommuniySearchResult(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()

        guard let decodedData = try? decoder.decode([CommunitySearch].self, from: data) else {
            return .decodeFail
        }

        return .success(decodedData)
    }
}