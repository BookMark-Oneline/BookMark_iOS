//
//  DataClassTintin.swift
//  BookMark
//
//  Created by BoMin on 2023/02/13.
//

import Foundation

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

