//
//  BaseViewModel.swift
//  study4
//
//  Created by 이상민 on 2/10/25.
//

import Foundation

protocol BaseViewModel{
    associatedtype Input
    associatedtype Output
    
    func transform()
}
