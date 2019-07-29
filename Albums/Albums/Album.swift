//
//  Album.swift
//  Albums
//
//  Created by Stephanie Bowles on 7/29/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import Foundation


struct Album: Codable {
    
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
    
    var coverArt: [String]
    var artist: String
    var genres: [String]
    var id: String
    var songs: [Songs]
    
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
    
    func encode(with encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(self.artist, forKey: .artist)
        try container.encode(genres, forKey: .genres)
        try container.encode(self.id, forKey: .id)
        try container.encode(songs, forKey: .songs)
        
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        for coverArtList in coverArt{
            var urlContainer = coverArtContainer.nestedContainer(keyedBy: Keys.CoverArtCodingKeys.self)
            try urlContainer.encode(coverArtList, forKey: .url)
        }
        
    }
}


struct Songs: Codable {
    
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
    
    var id: String
    var duration: String
    var songName: String
    
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
    
    func encode(encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.id, forKey: .id)
        
        var songNameContainer = container.nestedContainer(keyedBy: CodingKeys.SongTitleCodingKeys.self, forKey: .songName)
        try songNameContainer.encode(songName, forKey: .title)
        
        var durationContainer = container.nestedContainer(keyedBy: CodingKeys.DurationCodingKeys.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
        
    }
 
}
