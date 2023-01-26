//
//  Network.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/15.
//

import Foundation
import Alamofire

// MARK: - 네트워킹 용 클래스 나중에 싱글톤으로 만들기
class Network {
    // base Url
    let baseUrl = ""
    
    // 책 등록 POST
    func registerBooks(completion: @escaping (() -> Void)) {
        let params: Parameters = ["title": "Do it! 자료구조와 함께 배우는 알고리즘 입문 : 파이썬 편", "img_url": "http://image.yes24.com/goods/91219874/XL", "author": "시바타 보요", "publisher": "이지스퍼블리싱", "isbn": "9791163031727"]
        
        let datarequest = AF.request("url", method: .post, parameters: params, encoding: JSONEncoding.default).validate()
        
        datarequest.responseData(completionHandler: { response in
            switch response.result {
            case .success:
                print("ok")
            case .failure(let e):
                print(e)
            }
            //MARK: todo - completion에 NetworkResult<AnyObject>으로 추가하기 나중에
            completion()
        })
    }
    
    // 책 세부내용 조회 GET
    func getBookDetail(completion: @escaping (NetworkResult<AnyObject>) -> Void) {
        let header: HTTPHeaders = ["값": "값"]
        let datarequest = AF.request("url", method: .get, encoding: JSONEncoding.default, headers: header)
        
        datarequest.responseData(completionHandler: { res in
            switch res.result {
            case .success:
                print("ok")
                guard let value = res.value else {return}
                let bookDetailData = self.decodeJSON(data: value)
                print(bookDetailData)
                
            case .failure(let e):
                print(e)
            }
        })
    }
    
    // 서재 조회 GET
    func getShelf(completion: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = ["값": "값"]
        let datarequest = AF.request("url", method: .get, encoding: JSONEncoding.default, headers: header)
        
        datarequest.responseData(completionHandler: {res in
            switch res.result {
            case .success:
                print("ok")
            case .failure(let e):
                print(e)
            }
        })
    }
    
    // 책 검색(바코드) GET
    func getBookSearch(completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = "https://port-0-server-nodejs-1ih8d2gld1khslm.gksl2.cloudtype.app/search/book/1/?query=9788965049043"

        
//        AF.request(URL,
//                   method: .get, // GET 메소드
//                   parameters: nil,
//                   encoding: URLEncoding.default)
//        .validate(statusCode: 200..<500) // 에러 여부
//        .responseData(completionHandler: { response in
//            switch response.result {
//            case let .success(data):
//                do {
//                    let decoder = JSONDecoder()
//                    let result = try decoder.decode(BookSearchDataModel.self, from: data)
//
//                    completion(.success(result))
//                } catch {
//                    print("ERROR")
//                    completion(.pathErr)
//                }
//            case let .failure(error):
//                completion(.pathErr)
//            }
//        })

        
        let dataRequest = AF.request( URL,
                                      method: .get,
                                      encoding: JSONEncoding.default)

        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                print("SUCCESS")
                guard let statusCode = dataResponse.response?.statusCode else { return }
                
                print(statusCode)

                guard let value = dataResponse.value else { return }

                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)

            case .failure:
                completion(.pathErr)
            }
        }
        
        
        //        dataRequest.responseDecodable(completionHandler: { res in
        //            switch res.result {
        //            case .success:
        //                print("SUCCESS")
        //                guard let statusCode = res.response?.statusCode else { return }
        //
        //                guard let value = res.value else { return }
        //
        //                let bookSearchData = self.decodeJSON(data: value)
        //                print(statusCode)
        //                print(bookSearchData)
        //
        //            case .failure(let e):
        //                print("ERROR")
        //                print(e)
        //            }
        //        })

    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isValidData(data: data)
        case 400: return .pathErr // 요청이 잘못됨
        case 500: return .serverErr // 서버 에러
        default: return .networkFail // 네트워크 에러
        }
    }
    
    private func isValidData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(BookSearch.self, from: data) else {
            return .pathErr }
        
//        print(decodedData)
        
        return .success(decodedData)
    }

    
    
    
    func timerStart(completion: @escaping (() -> Void)) {
        let URL = "https://port-0-server-nodejs-1ih8d2gld1khslm.gksl2.cloudtype.app/timer/start/1/2"
        let dataRequest = AF.request( URL,
                                      method: .post,
                                      encoding: JSONEncoding.default ).validate()
        
        dataRequest.responseData(completionHandler: { dataResponse in
            switch dataResponse.result {
            case .success(let res):
                print("SUCCESS")
                print("응답 데이터 :: ", String(data: res, encoding: .utf8) ?? "")
            case .failure(let e):
                print("ERROR")
                print(e)
            }
            
//MARK: todo2 - completion에 NetworkResult<AnyObject>으로 추가하기 나중에
            completion()
        })
    }
    
    func timerStop(completion: @escaping (() -> Void)) {
        let params: Parameters = [
            "total_reading_time": 1000,
            "current_reading_time": 100
        ]
        // current는 timeCount로, total은 get에서 받아온 토탈에 current 더하기...?
        
        let URL = "https://port-0-server-nodejs-1ih8d2gld1khslm.gksl2.cloudtype.app/timer/finish/1/1"
        let dataRequest = AF.request( URL,
                                      method: .post,
                                      parameters: params,
                                      encoding: JSONEncoding.default ).validate()
        
        dataRequest.responseData(completionHandler: { dataResponse in
            switch dataResponse.result {
            case .success(let res):
                print("SUCCESS")
                print("응답 데이터 :: ", String(data: res, encoding: .utf8) ?? "")
            case .failure(let e):
                print("ERROR")
                print(e)
            }
            
//MARK: todo3 - completion에 NetworkResult<AnyObject>으로 추가하기 나중에
            completion()
        })
    }
    
    // JSON 객체 Decode
    func decodeJSON(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decoding = try? decoder.decode(BookDetail.self, from: data) else {
            return .networkFail
        }
        return .success(decoding)
    }
}

