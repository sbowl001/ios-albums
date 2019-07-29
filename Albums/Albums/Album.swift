//
//  Album.swift
//  Albums
//
//  Created by Stephanie Bowles on 7/29/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import Foundation


struct Album: Decodable {
    
    enum Keys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
        
        enum CoverArtCodingKeys: String, CodingKey {
            case url
        }
        
    }
    
    let coverArt: [String]
    let artist: String
    let genres: [String]
    let id: String
    let songs: [Songs]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.artist = try container.decode(String.self, forKey: .artist)
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtList: [String] = []
        
        while coverArtContainer.isAtEnd == false {
            let urlContainer = try coverArtContainer.nestedContainer(keyedBy: Keys.CoverArtCodingKeys.self)
            let coverURL = try urlContainer.decode(String.self, forKey: .url)
            coverArtList.append(coverURL)
        }
        self.coverArt = coverArtList
        
        self.genres = try container.decode([String].self, forKey: .genres)
        self.id = try container.decode(String.self, forKey: .id)
        self.songs = try container.decode([Songs].self, forKey: .songs)
    }
}


struct Songs: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case songName = "name"
        case duration
        
        enum DurationCodingKeys: String, CodingKey{
            case duration
        }
        
        enum SongTitleCodingKeys: String, CodingKey{
            case title
        }
    }
    
    let id: String
    let duration: String
    let songName: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        
        
        let songNameContainer = try container.nestedContainer(keyedBy: CodingKeys.SongTitleCodingKeys.self, forKey: .songName)
        let songTitle = try songNameContainer.decode(String.self, forKey: .title)
        self.songName = songTitle
        let durationContainer = try container.nestedContainer(keyedBy: CodingKeys.DurationCodingKeys.self, forKey: .duration)
        let duration = try durationContainer.decode(String.self, forKey: .duration)
        self.duration = duration 
    }
 
}
