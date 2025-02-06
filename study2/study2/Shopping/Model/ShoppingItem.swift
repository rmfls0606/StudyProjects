//
//  ShoppingItem.swift
//  UpDownGame
//
//  Created by 이상민 on 1/16/25.
//

struct ItemList: Decodable{
    let total: Int
    let items: [Item]
}

struct Item: Decodable{
    let image: String
    let mallName: String
    let title: String
    let lprice: String
}
