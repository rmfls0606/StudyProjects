//
//  SearchResponse.swift
//  study4
//
//  Created by 이상민 on 2/10/25.
//

import Foundation

struct SearchResponse: Decodable{
    let total_pages: Int
    let results: [SearchResult]
}

struct SearchResult: Decodable{
    let id: String
    let width: Int
    let height: Int
    let urls: SearchURLS
    let likes: Int
}

struct SearchURLS: Decodable{
    let thumb: String
    let small: String
}
