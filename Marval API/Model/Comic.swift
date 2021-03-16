//
//  Comic.swift
//  Marval API
//
//  Created by namnguyen on 15/03/2021.
//

import Foundation

import SwiftUI

struct APIComicResult: Codable {
    var data:APIComicData
    
}
struct  APIComicData: Codable {
    var count:Int
    var results:[Character]
}
struct Comic: Identifiable,Codable
{
    var id:Int
    var title  : String
    var description: String?
    var thumbnail:[String:String]
    var urls: [[String:String]]
}


