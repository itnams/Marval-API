//
//  Character.swift
//  Marval API
//
//  Created by namnguyen on 15/03/2021.
//

import SwiftUI

struct APIResult: Codable {
    var data:APICharacterData
    
}
struct  APICharacterData: Codable {
    var count:Int
    var results:[Character]
}
struct Character: Identifiable,Codable
{
    var id:Int
    var name: String
    var description: String
    var thumbnail:[String:String]
    var urls: [[String:String]]
}


