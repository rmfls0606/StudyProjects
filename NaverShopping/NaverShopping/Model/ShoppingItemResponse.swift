//
//  ShoppingItemResponse.swift
//  NaverShopping
//
//  Created by 이상민 on 2/26/25.
//

import Foundation

struct ItemResponse: Decodable{
    let total: Int
    let items: [Item]
}

struct Item: Decodable{
    let productId: String
    
    let image: String
    let mallName: String
    let title: String
    let lprice: String
}
