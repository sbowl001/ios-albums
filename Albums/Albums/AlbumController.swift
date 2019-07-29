//
//  AlbumController.swift
//  Albums
//
//  Created by Stephanie Bowles on 7/29/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import Foundation

func testDecodingExampleAlbum() {
    
}


func testEncodingExampleAlbum()  {
    
}

var albums: [Album] = []
let baseURL = URL(string: "https://albums-e16eb.firebaseio.com/")!

typealias CompletionHandler = (Error?) -> Void

func getAlbums(completion: @escaping CompletionHandler = { _ in}){
    let requestURL = baseURL.appendingPathExtension("json")
    
    URLSession.shared.dataTask(with: requestURL) {(data, _, error) in
        if let error = error {
            NSLog("error performing data task")
            completion(error)
            return
        }
        guard let data = data else {
            NSLog("No data returned")
            completion(NSError())
            return
        }
        
        let decoder  = JSONDecoder()
        
        do {
            let albums = try decoder.decode([String: Album].self, from: data)
            completion(nil)
            return
            
        } catch {
            NSLog("Error decoding \(error)")
            completion( error)
            return
        }
        
    }.resume()
//    It should have a completion handler that takes in an optional Error. This function should perform a URLSessionDataTask that fetches the albums from the baseURL, decodes them, and sets the albums array to the decoded albums. Note: You should decode the JSON data as [String: Album].self here.

}

func put(album: Album, completion: @escaping CompletionHandler = { _ in }) {
    
    do {
        let requestURL = baseURL.appendingPathComponent(album.id).appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        let body = try JSONEncoder().encode(album)
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                NSLog("error saving albu,: \(error)")
            }
            completion(error)
        }.resume()
        
    } catch {
        NSLog("error encoding entry \(error)")
        completion(error)
        return
    }
    
    
   
//    This should use a URLSessionDataTask to PUT the album passed into the function to the API. Add the album's identifier to the base URL so it gets put in a unique location in the API.

}

func createAlbum(artist: String, coverArt: [URL], genres: [String], id: String, name: String, songs: [Songs]) {
    
    let newAlbum = Album(artist: artist, coverArt: coverArt, genres: genres, id: id, name: name, songs: songs)
//    It should take in the necessary properties as parameters in order to initialize a new Album. Create an Album from the method parameters, then append it to the albums array. Then call the put(album: Album) method so the new Album gets saved to the API.
    albums.append(newAlbum)
    put(album: newAlbum)
}

func createSong(songName: String, duration: String, id: String = UUID().uuidString) -> Songs {
    let song = Songs(duration: duration, id: id, songName: songName)
    return song
//    A function called createSong. It should take in the necessary properties as parameters to be able to initialize a Song. The function should return a Song. In the method, simply initialize a new song from the method parameters and return it.
    
}

func update(album: Album, artist: String, coverArt: [URL], genres: [String], id: String, name: String, songs: [Songs]) {
    
    var updatedAlbum = album
    
    updatedAlbum.artist = artist
    updatedAlbum.coverArt = coverArt
    updatedAlbum.genres = genres
    updatedAlbum.id = id
    updatedAlbum.name = name
    updatedAlbum.songs = songs
    
    put(album: updatedAlbum)
//    A function called update. This should take in an Album and a parameter for each of the Album object's properties that can be changed (This should be every property). Update the values of the Album parameter, then send those changes to the API by calling the put(album: Album) method.
}


