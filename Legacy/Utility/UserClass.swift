//
//  UserClass.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/02/12.
//

import UIKit

class UserInfo {
    static let shared = UserInfo()
    var userID: Int
    var userNickName: String
    var userImg: UIImage?
    var userMessage: String
    var userGoal: Int
    var userAccessToken: String?
    
    private init() {
        self.userID = 1
        self.userGoal = 60
        self.userMessage = ""
        self.userNickName = ""
    }
}
