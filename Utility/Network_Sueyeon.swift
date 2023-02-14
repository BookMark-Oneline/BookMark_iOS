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
    func postCommunitySetting(clubID: Int, clubName: String, clubImg: UIImage, clubInvitation: Int, clubLimit: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = baseUrl + "/club/setting/edit/\(clubID)"
        let params: Parameters = ["club_id": clubID, "club_name": clubName, "club_invite_option": clubInvitation,  "max_people_num": clubLimit]
        
        guard let imgData = clubImg.jpegData(compressionQuality: 0.7) else {
            print("jpeg data failed")
            return
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "club_img_url", fileName: "\(clubID)_image.png" , mimeType: "image/png")
            
            for (key, value) in params
            {
                multipartFormData.append("\(value)".data(using: .utf8, allowLossyConversion: false)!, withName: "\(key)")
            }
            
        }, to: URL, method: .post).responseData(completionHandler: { (response) in
            if let err = response.error {
                print("setting post failed: \(err)")
                return
            }
            print(response.result)
            completion(.success(response.result))
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
    
    // API 2-7-1: 책 모임 가입 요청자 상태를 변경 (가입 허용)
    func postCommunityJoinRequestStatus(userID: Int, clubID: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = baseUrl + "/club/members/approval/\(userID)"
        let params: Parameters = ["club_id": clubID]
        let datarequest = AF.request(URL, method: .post, parameters: params, encoding: JSONEncoding.default).validate()
        
        datarequest.responseData(completionHandler: { res in
            switch res.result {
            case .success:
                guard let value = res.value else {return}
                guard let rescode = res.response?.statusCode else {return}
                
                let networkResult = self.tempJudgeStatus(object: 7, by: rescode, value)
                completion(networkResult)
                
            case .failure(let e):
                print(e)
                completion(.pathErr)
            }
        
        })
    }
    
    // API 2-8: 책 모임 생성
    func postNewCommunity(parameter: Parameters, completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = baseUrl + "/club/register"
        
        // let params: Parameters = ["club_id": clubID, "club_name": ,  "club_img_url": , "club_invite_opiton": , "max_people_num": , "club_owner_id": ]
        let datarequest = AF.request(URL, method: .post, parameters: parameter, encoding: JSONEncoding.default).validate()
        
        datarequest.responseData(completionHandler: { res in
            switch res.result {
            case .success:
                guard let value = res.value else {return}
                guard let rescode = res.response?.statusCode else {return}
                
                let networkResult = self.tempJudgeStatus(object: 8, by: rescode, value)
                completion(networkResult)
                
            case .failure(let e):
                print(e)
                completion(.pathErr)
            }
        
        })
    }
    
    // API 2-12: 게시글 like 상태 변경
    func postCommunityPostLikeStatus(clubPostID: Int, userID: Int, likeStatus: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = baseUrl + "/club/post/like/\(clubPostID)"
        
        let params: Parameters = ["club_id": userID, "club_name": likeStatus]
        let datarequest = AF.request(URL, method: .post, parameters: params, encoding: JSONEncoding.default).validate()
        
        datarequest.responseData(completionHandler: { res in
            switch res.result {
            case .success:
                guard let value = res.value else {return}
                guard let rescode = res.response?.statusCode else {return}
                
                let networkResult = self.tempJudgeStatus(object: 8, by: rescode, value)
                completion(networkResult)
                
            case .failure(let e):
                print(e)
                completion(.pathErr)
            }
        
        })
    }
    
    // API 2-13: 게시글 댓글 작성
    func postCommunityPostComment(clubPostID: Int, userID: Int, comment: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = baseUrl + "/club/post/comment/\(clubPostID)"
        
        let params: Parameters = ["user_id": userID, "club_post_id": clubPostID, "comment_content_text": comment]
        let datarequest = AF.request(URL, method: .post, parameters: params, encoding: JSONEncoding.default).validate()

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
    
    private func tempJudgeStatus(object: Int = 0, by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200:
            // API 2-11, API 2-13
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
            // API 2-7-1, API 2-8, API 2-12, API 2-13
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
    
    private func isValidData_CreateNewCommunity(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(CommunityJoinRequest.self, from: data) else {
            return .decodeFail
        }
    
        return .success(decodedData)
    }
}
