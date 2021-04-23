//
//  ShowCharacter.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/23/21.
//

import Foundation

/// Represents a character from the Breaking Bad TV Series.
struct ShowCharacter: Codable, Identifiable {
    
    /// A unique identifier for this character.
    let id: Int
    
    /// A character's full name.
    let name: String
    
    /// A character's birthday.
    let birthday: String
    
    /// List of character's known occupation.
    let occupation: [String]
    
    /// The `URL` used for the character image.
    let imageURL: URL
    
    /// The living status of the character.
    let status: String
    
    /// A known nickname they are referred as.
    let nickname: String
    
    /// List of seasons that the character appeared in.
    let seasons: [Int]
    
    /// The real name of the actor / actress that portrayed the character.
    let realName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "char_id"
        case name
        case birthday
        case occupation
        case imageURL = "img"
        case status
        case nickname
        case seasons = "appearance"
        case realName = "portrayed"
    }
}
