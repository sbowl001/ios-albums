//
//  Album.swift
//  Albums
//
//  Created by Stephanie Bowles on 7/29/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import Foundation


struct Album: Decodable {
    let artist: String
    let coverArt: String
    let name: String
    let url: String
}


struct Song: Decodable {
    let name: String
    let title: String
    let duration: String 
}
