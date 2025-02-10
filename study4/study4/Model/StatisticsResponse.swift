//
//  StatisticsResponse.swift
//  study4
//
//  Created by 이상민 on 2/10/25.
//

import Foundation

struct StatisticsResponse: Decodable{
    let downloads: StatisticsDownload
    let views: StatisticsView
}

struct StatisticsDownload: Decodable{
    let total: Int
}

struct StatisticsView: Decodable{
    let total: Int
}
