//
//  Movie.swift
//  Cinemax
//
//  Created by Humberto Rodrigues on 10/01/23.
//

import Foundation

struct SearchShowElement: Codable { //Struct para procurar e mostrar um novo filme, puxa a cadeia de json nas classes.
    let show: Movie
}

struct Movie: Codable {
    let id: Int
    let name: String?
    let genres: [String]?
    let schedule: Schedule?
    let rating: Rating?
    let image: Image?
    let summary: String?
}

struct Rating: Codable {
    let average: Double?
}

struct Schedule: Codable {
    let time: String
    let days: [String]

    func toString () -> String {
        return "\(time) (\(days.joined(separator: ", ")))"
    }
}

struct Image: Codable {
    let medium: String
    let original: String
}
