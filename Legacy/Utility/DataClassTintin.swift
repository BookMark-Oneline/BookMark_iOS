//
//  DataClassTintin.swift
//  BookMark
//
//  Created by BoMin on 2023/02/13.
//

import Foundation

//MARK: - 2-1 책모임 List
class CommunityList: Decodable {
    let clubID: Int
    let clubImgURL: String
    let clubName: String
    let clubOwnerID: Int
    
    enum CodingKeys: String, CodingKey {
        case clubID = "club_id"
        case clubImgURL = "club_img_url"
        case clubName = "club_name"
        case clubOwnerID = "club_owner_id"
    }
}

//MARK: - 2-2 책모임 정보(공지, 게시물 등)
class CommunityInfo: Decodable {
    let clubID: Int
    let announcementID: Int?
    let postResponse: [PostResponse]
    
    enum CodingKeys: String, CodingKey {
        case clubID = "club_id"
        case announcementID = "announcement_id"
        case postResponse = "PostResponse"
    }
}

class PostResponse: Decodable {
    let clubPostID: Int
    let clubPostTitle: String
    let postContentText: String
    let likeNum: Int
    let commentNum: Int
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case clubPostID = "club_post_id"
        case clubPostTitle = "club_post_title"
        case postContentText = "post_content_text"
        case likeNum = "like_num"
        case commentNum = "comment_num"
        case createdAt = "created_at"
    }
}

//MARK: - 2-9 책모임 가입 요청 응답 메세지
class CommunityJoinResponse: Decodable {
    let message: String
}

//MARK: - 2-10 책모임 검색
class CommunitySearch: Decodable {
    let clubID: Int
    let clubName: String
    let clubImgURL: String?
    let clubInviteOption: String
    let userID: Int
    let userName: String
    let imgURL: String?
    
    enum CodingKeys: String, CodingKey {
        case clubID = "club_id"
        case clubName = "club_name"
        case clubImgURL = "club_img_url"
        case clubInviteOption = "club_invite_option"
        case userID = "user_id"
        case userName = "user_name"
        case imgURL = "img_url"
    }
}

class PostRequestResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
}

