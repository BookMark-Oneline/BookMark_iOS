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
    case decodeFail
}

// MARK: - 책 세부내용 data class
struct BookDetail: Codable {
    let userID: Int
    let bookID: Int
    let title: String
    let author: String
    let imgURL: String
    let publisher: String
    let totalReadingTime: Int
    let currentReadingPage: Int
    let totalPage: Int?
    let dataDetail: [DataDetail]

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case bookID = "book_id"
        case title
        case author
        case imgURL = "img_url"
        case publisher
        case totalReadingTime = "total_reading_time"
        case currentReadingPage = "current_reading_page"
        case totalPage = "total_page"
        case dataDetail
    }
}

struct DataDetail: Codable {
    let createdAt: String
    let readingTime: Int

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case readingTime = "reading_time"
    }
}

// MARK: - 서재 data class
class Shelf: Decodable {
    let User: UserShelfInfo
    let Book: [BookInfo]
}

// MARK: 서재 유저 data class
class UserShelfInfo: Decodable {
    let user_id: Int
    let img_url: String
    let total_book: Int
    let streak: Int?
    let goal: Int?
}

// MARK: 서재 책 data class
class BookInfo: Decodable {
    let book_id: Int
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

// MARK: BookSearch.MyData
struct MyData: Codable {
    let title: String
    let link: String
    let image: String
    let author, discount, publisher, pubdate: String
    let isbn, description: String
}

// MARK: BookSearch.UserID
struct UserID: Codable {
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
    }
}

