//
//  Network_Sueyeon.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/02/13.
//

import Foundation
import Alamofire

// MARK: - 네트워킹 용 클래스 나중에 싱글톤으로 만들기
extension Network {
    // API 2-11: 게시물의 제목, 내용, 작성자, 댓글 조회
    func getCommunityPost(postID: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = baseUrl + "/club/post/\(postID)"
        let datarequest = AF.request(URL, method: .get, encoding: JSONEncoding.default)
        
        datarequest.responseData(completionHandler: { res in
            switch res.result {
            case .success:
                guard let value = res.value else {return}
                guard let rescode = res.response?.statusCode else {return}
                
                let networkResult = self.tempJudgeStatus(object: 3, by: rescode, value)
                completion(networkResult)
                
            case .failure(let e):
                print(e)
                completion(.pathErr)
            }
        
        })
    }
    
    // API 2-3: 책 모임 설정 조회
    func getCommunitySetting(clubID: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = baseUrl + "/club/setting/\(clubID)"
        let datarequest = AF.request(URL, method: .get, encoding: JSONEncoding.default)
        
        datarequest.responseData(completionHandler: { res in
            switch res.result {
            case .success:
                guard let value = res.value else {return}
                guard let rescode = res.response?.statusCode else {return}
                
                let networkResult = self.tempJudgeStatus(object: 4, by: rescode, value)
                completion(networkResult)
                
            case .failure(let e):
                print(e)
                completion(.pathErr)
            }
        
        })
    }
    
    // API 2-4: 책 모임 설정 변경
    func postCommunitySetting(clubID: Int, clubName: String, clubImg: String, clubInvitation: Int, clubLimit: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = baseUrl + "/club/setting/setting/edit/\(clubID)"
        let params: Parameters = ["club_id": clubID, "club_name": clubName, "club_img_url": clubImg, "club_invite_option": clubInvitation,  "max_people_num": clubLimit]
        let datarequest = AF.request(URL, method: .get, parameters: params, encoding: JSONEncoding.default).validate()
        
        datarequest.responseData(completionHandler: { res in
            switch res.result {
            case .success:
                guard let value = res.value else {return}
                guard let rescode = res.response?.statusCode else {return}
                
                let networkResult = self.tempJudgeStatus(object: 4, by: rescode, value)
                completion(networkResult)
                
            case .failure(let e):
                print(e)
                completion(.pathErr)
            }
        
        })
    }
    
    // API 2-5: 책 모임 소속 회원 정보 조회
    func getCommunityUserInfo(clubID: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = baseUrl + "/club/member/\(clubID)"
        let datarequest = AF.request(URL, method: .get, encoding: JSONEncoding.default)
        
        datarequest.responseData(completionHandler: { res in
            switch res.result {
            case .success:
                guard let value = res.value else {return}
                guard let rescode = res.response?.statusCode else {return}
                
                let networkResult = self.tempJudgeStatus(object: 5, by: rescode, value)
                completion(networkResult)
                
            case .failure(let e):
                print(e)
                completion(.pathErr)
            }
            
        })
    }
    
    // API 2-6: 책 모임 가입 요청자 조회
    func getCommunityJoinRequestList(clubID: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = baseUrl + "/club/members/request/\(clubID)"
        let datarequest = AF.request(URL, method: .get, encoding: JSONEncoding.default)
        
        datarequest.responseData(completionHandler: { res in
            switch res.result {
            case .success:
                guard let value = res.value else {return}
                guard let rescode = res.response?.statusCode else {return}
                
                let networkResult = self.tempJudgeStatus(object: 6, by: rescode, value)
                completion(networkResult)
                
            case .failure(let e):
                print(e)
                completion(.pathErr)
            }
            
        })
    }
    
    private func tempJudgeStatus(object: Int = 0, by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200:
            // API 2-11
            if (object == 3) {
                return isValidData_CommunityPost(data: data)
            }
            // API 2-3
            else if (object == 4) {
                return isValidData_CommunitySetting(data: data)
            }
            // API 2-5
            else if (object == 5) {
                return isValidData_CommunityUserList(data: data)
            }
            // API 2-6
            else if (object == 6) {
                return isValidData_CommunityUserRequest(data: data)
            }
            else {
                return .success(data)
            }
        case 400: return .pathErr // 요청이 잘못됨
        case 500: return .serverErr // 서버 에러
        default: return .networkFail // 네트워크 에러
        }
    }
    
    private func isValidData_CommunityPost(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(CommunityPost.self, from: data) else {
            return .decodeFail }
    
        return .success(decodedData)
    }
    
    private func isValidData_CommunitySetting(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(CommunitySetting.self, from: data) else {
            return .decodeFail }
    
        return .success(decodedData)
    }
    
    private func isValidData_CommunityUserList(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode([CommunityUserList].self, from: data) else {
            return .decodeFail
        }
    
        return .success(decodedData)
    }
    
    private func isValidData_CommunityUserRequest(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(CommunityJoinRequest.self, from: data) else {
            return .decodeFail
        }
    
        return .success(decodedData)
    }
}
