//
//  DataClass_sueyeon.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/02/13.
//

import Foundation

// MARK: - 게시물 제목 data class
class CommunityPost: Decodable {
    let club_post_id: Int
    let club_post_title: String
    
    let img_status: String
    let img_url: String?
    let post_content_text: String
    
    let user_id: Int
    let user_name: String
    let like_num: Int
    
    let comment_num: Int
    let CommentData: [CommunityPostComment]
}

class CommunityPostComment: Decodable {
    let club_comment_id: Int
    let writer_id: Int
    let user_name: String
    let comment_content_text: String
}

// MARK: - 책 모임 설정 data class
class CommunitySetting: Decodable {
    let clubData: [CommunityData]
}

class CommunityData: Decodable {
    let club_name: String
    let club_img_url: String
    let club_invite_option: Int
    let max_people_num: Int
}

// MARK: - 책 모임 멤버 data class
class CommunityUserList: Decodable {
    let user_id: Int
    let now_reading: Int
    let introduce_message: String
}

// MARK: - 책 모임 가입 요청 data class
class CommunityJoinRequest: Decodable {
    let club_id: [ClubID]
    let membersRequesting: [RequestList]
}

class ClubID: Decodable {
    let club_id: Int
}

class RequestList: Decodable {
    let user_id: Int
    let introduce_message: String
    let user_name: String
    let img_url: String
}
