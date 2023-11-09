//
//  Movie.swift
//  Loodos-Case
//
//  Created by Osman Yıldız on 7.11.2023.
//

/*
 Aslında tanımı şu şekilde: typealias Codable = Decodable & Encodable
 Encodable: JSON formatına çevirir.
 Decodable: JSON verilerini çözümler.
 */

struct Movie: Codable {
    var search: [MovieBean]? = []
    var totalResults: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case search       = "Search"
        case totalResults = "totalResults"
    }
}

struct MovieBean:Codable {
    var title:String? = nil
    var year: String? = nil
    var imdbId:String? = nil
    var type:String? = nil
    var poster:String? = nil
    
    enum CodingKeys: String, CodingKey {
        case title  = "Title"
        case year   = "Year"
        case imdbId = "imdbID"
        case type   = "Type"
        case poster = "Poster"
    }
}
