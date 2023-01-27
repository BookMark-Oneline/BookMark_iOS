//
//  DataClass.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/17.
//

import Foundation

// MARK: - 네트워킹 result 열거형
enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}

// MARK: - 책 세부내용 data class
class BookDetail: Decodable {
    let user_id: Int
    let title: String
    let author: String
    let img_url: String
    let publisher: String
    let ave_reading_time: Int
    let ave_reading_page: Int
}


// MARK: - 서재 data class
class Shelf: Decodable {
    let user_id: Int
    let title: String
    let author: String
    let img_url: String
}


// MARK: - 책 검색 data struct

struct BookSearch: Codable {
    let userID: UserID
    let myData: [MyData]

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case myData
    }
}

// MARK: - BookSearch.MyData
struct MyData: Codable {
    let title: String
    let link: String
    let image: String
    let author, discount, publisher, pubdate: String
    let isbn, description: String
}

// MARK: - BookSearch.UserID
struct UserID: Codable {
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
    }
}

