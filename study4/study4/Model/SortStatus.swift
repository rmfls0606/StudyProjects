//
//  SortStatus.swift
//  study4
//
//  Created by 이상민 on 2/10/25.
//

import Foundation

enum SortStatus: String{
    case sortByRelevance = "relevant"
    case sortByLatest = "latest"
    
    mutating func toggle(){
        switch self{
        case .sortByRelevance:
            self = .sortByLatest
        case .sortByLatest:
            self = .sortByRelevance
        }
    }
}
