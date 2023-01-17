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
