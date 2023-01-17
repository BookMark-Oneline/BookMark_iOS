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
    
    // JSON 객체 Decode
    func decodeJSON(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decoding = try? decoder.decode(BookDetail.self, from: data) else {
            return .networkFail
        }
        return .success(decoding)
    }
}

