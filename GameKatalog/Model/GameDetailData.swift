//
//  GameDetailData.swift
//  GameKatalog
//
//  Created by Gilang Ramdhani Putra on 20/09/21.
//

import Foundation

struct GameDetail: Decodable {
    let game : GameDetailData?
    
    private enum CodingKeys : String, CodingKey {
        case game
    }
}
struct GameDetailData : Decodable {
    let id : Int
    let name_original : String?
    let description_raw : String?
    let rating : Double?
    let background_image : String?
    let genres : [Genre]
    let parent_platforms : [ParentPlatforms]
    
    private enum CodingKeys: String, CodingKey {
        case id, name_original, description_raw, rating, background_image, genres
        case parent_platforms
    }
}


struct ParentPlatforms : Decodable {
    let platform : Platform?

}

struct Platform : Decodable {
    let id : Int
    let name : String?
    
    private enum CodingKeys: String, CodingKey {
        case id, name
    }
}
