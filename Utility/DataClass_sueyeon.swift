//
//  DataClass_sueyeon.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/02/13.
//

import Foundation

// MARK: 게시물 제목 data class
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
    let writer_id: Int
    let user_name: String
    let comment_content_text: String
}

