//
//  UserClass.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/02/12.
//

import UIKit

class UserInfo {
    static let shared = UserInfo()
    var userName: String
    var userID: Int
    var userNickName: String
    var userImg: UIImage?
    var userMessage: String
    var userGoal: Int
    var userAccessToken: String?
    
    private init() {
        if let name = UserDefaults.standard.string(forKey: "userName") {
            self.userName = name
        }
        else {
            self.userName = "이름 없음"
        }
        self.userID = 1
        self.userGoal = 60
        self.userMessage = ""
        self.userNickName = self.userName
    }
}
