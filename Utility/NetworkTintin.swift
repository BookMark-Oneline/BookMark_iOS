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

// MARK: - API 2-9 [POST] 책모임 가입 요청 전달
    func postCommunityJoinRequest(userID: String, clubID: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = baseUrl + "/club/request/1?club_id=\(clubID)"
        let params: Parameters = ["user_id": userID]
        let datarequest = AF.request(URL, method: .post, parameters: params, encoding: JSONEncoding.default).validate()
        
        datarequest.responseData(completionHandler: { res in
            switch res.result {
            case .success:
                guard let value = res.value else {return}
                guard let rescode = res.response?.statusCode else {return}
                
                let networkResult = self.judgeStatus(object: 3, by: rescode, value)
                completion(networkResult)

            case .failure(let e):
                print(e)
                completion(.pathErr)
            }
        })
    }
    
//MARK: - API 1-5(FIX) [POST] 타이머 종료
    func postTimerStopFixed(bookID: Int, userID: Int, totalReadTime: Int, curReadPage: Int, nowRead: Int, readTime: Int, lastCal: String, goal: Int, streak: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = baseUrl + "/timer/finish/\(userID)/\(bookID)"
        
        
        let params: Parameters = ["total_reading_time": totalReadTime, "current_reading_time": curReadPage, "now_reading": nowRead, "reading_time": readTime, "last_cal": lastCal, "goal": goal, "streak": streak]
        let datarequest = AF.request(URL, method: .post, parameters: params, encoding: JSONEncoding.default).validate()
        
        datarequest.responseData(completionHandler: { res in
            switch res.result {
            case .success:
                guard let value = res.value else {return}
                guard let rescode = res.response?.statusCode else {return}
    
                let networkResult = self.judgeStatus(object: 5, by: rescode, value)
                completion(networkResult)
                
            case .failure(let e):
                print(e)
                completion(.pathErr)
            }
        })
    }
    
//MARK: - API 2-14-1 [POST] 게시글 제목, 내용 게시 (사진 포함 X)
    func postCommunityPostWithoutImg(clubID: Int, userID: Int, clubPostTitle: String, clubPostContent: String, imgStatus: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = baseUrl + "/club/post/register/\(clubID)"
        print(clubPostTitle)
        print(clubPostContent)
        
        let params: Parameters = ["user_id": userID, "club_id": clubID, "club_post_title": clubPostTitle, "post_content_text": clubPostContent, "img_status": imgStatus]
        let datarequest = AF.request(URL, method: .post, parameters: params, encoding: JSONEncoding.default).validate()
        
        datarequest.responseData(completionHandler: { res in
            switch res.result {
            case .success:
                guard let value = res.value else {return}
                guard let rescode = res.response?.statusCode else {return}
    
                let networkResult = self.judgeStatus(object: 5, by: rescode, value)
                completion(networkResult)
                
            case .failure(let e):
                print(e)
                completion(.pathErr)
            }
        })
    }
    
//MARK: - API 2-14-2 [POST] 게시글 제목, 내용 게시 (사진 포함 O)
    func postCommunityPostWithImg(clubID: Int, userID: Int, clubPostTitle: String, clubPostContent: String, imgStatus: Int, img: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = baseUrl + "/club/post/register/\(clubID)"
        print(clubPostTitle)
        print(clubPostContent)
        print(img)
        
        let params: Parameters = ["user_id": userID, "club_id": clubID, "club_post_title": clubPostTitle, "post_content_text": clubPostContent, "img_status": imgStatus, "img": img]
        let datarequest = AF.request(URL, method: .post, parameters: params, encoding: JSONEncoding.default).validate()
        
        datarequest.responseData(completionHandler: { res in
            switch res.result {
            case .success:
                guard let value = res.value else {return}
                guard let rescode = res.response?.statusCode else {return}
    
                let networkResult = self.judgeStatus(object: 5, by: rescode, value)
                completion(networkResult)
                
            case .failure(let e):
                print(e)
                completion(.pathErr)
            }
        })
    }
    
//MARK: - API 2-15 [POST] 게시글 공지 등록
    func postCommunityNotice(clubID: Int, userID: Int, clubPostID: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = baseUrl + "/club/post/register/notice/\(clubID)"
        print(clubPostID)
        
        let params: Parameters = ["user_id": userID, "club_post_id": clubPostID]
        let datarequest = AF.request(URL, method: .post, parameters: params, encoding: JSONEncoding.default).validate()
        
        datarequest.responseData(completionHandler: { res in
            switch res.result {
            case .success:
                guard let value = res.value else {return}
                guard let rescode = res.response?.statusCode else {return}
    
                let networkResult = self.judgeStatus(object: 5, by: rescode, value)
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
            else if (object == 3) {
                return isValidData_CommunityJoinRequest(data: data)
            }
            else if (object == 5) {
                return isValidData_PostRequestResponse(data: data)
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
    
    private func isValidData_CommunityJoinRequest(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(CommunityJoinResponse.self, from: data) else {
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
    
    private func isValidData_PostRequestResponse(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()

        guard let decodedData = try? decoder.decode(PostRequestResponse.self, from: data) else {
            return .decodeFail
        }

        return .success(decodedData)
    }
}
