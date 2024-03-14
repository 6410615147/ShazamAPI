//
//  ResponseManager.swift
//  ShazamAPI
//
//  Created by Babypowder on 13/3/2567 BE.
//

import Foundation

struct ResponseManager: Codable {
    let track: Track?
}

struct Track: Codable {
    var title: String = ""
    var subtitle: String = ""
    let images: Images
    let url: String
}

struct Images: Codable {
    let coverart: String
}

