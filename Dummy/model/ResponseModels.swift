//
//  ResponseModels.swift
//  Dummy
//
//  Created by Chia on 2022/05/30.
//

import Foundation

struct UserResponse: Codable {
    let data: [User]
    let total: Int
}

struct User: Codable {
    let id: String
    let title: String
    let firstName: String
    let lastName: String
    let imgURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case firstName
        case lastName
        case imgURL = "picture"
    }
}
