//
//  Tile.swift
//  Payback_assignment
//
//  Created by Anzer Arkin on 26.07.22.
//

import Foundation

struct Tile: Codable, Hashable {    
    let name: TileStyle
    let headline: String
    let subline: String?
    let data: String?
    let score: Int
}

enum TileStyle: String, Codable {
    case image = "image"
    case video = "video"
    case website = "website"
    case shopping_list = "shopping_list"
}
