//
//  Episode.swift
//  Cinemax
//
//  Created by Humberto Rodrigues on 10/01/23.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let name: String?
    let season: Int?
    let number: Int?
    let image: Image?
    let summary: String?
}

struct Season: Codable { // Array de episódio formando uma season.
    let number: Int? // season 1
    let episodes: [Episode]? // episodios x..
    
}

