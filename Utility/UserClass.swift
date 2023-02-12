//
//  UserClass.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/02/12.
//

import Foundation

class UserInfo {
    static let shared = UserInfo()
    var userName: String?
    private init() {
        if let name = UserDefaults.standard.string(forKey: "userName") {
            self.userName = name
        }
    }
}
