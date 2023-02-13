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
