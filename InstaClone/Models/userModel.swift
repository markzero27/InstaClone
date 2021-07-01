//
//  userModel.swift
//  InstaClone
//
//  Created by Marcus Daquis on 6/29/21.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let username: String
    let email: String
    let image: String?
    
}
