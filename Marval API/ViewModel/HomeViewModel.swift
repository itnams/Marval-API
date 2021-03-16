//
//  HomeViewModel.swift
//  Marval API
//
//  Created by namnguyen on 15/03/2021.
//

import SwiftUI
import Combine
import CryptoKit
class HomeViewModel: ObservableObject {
    @Published var searchQuery = ""
    var searchCancellable:AnyCancellable? = nil
    @Published var fectchedCharacters: [Character]? = nil
    @Published var fectchedComics: [Comic] = []
    @Published var offset: Int = 0
    init() {
        searchCancellable = $searchQuery
            .removeDuplicates()
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str == "" {
                    self.fectchedCharacters = nil
                }
                else {
                    self.searchCharacter()
                }})
    }
    func searchCharacter() {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
        let originalQuery = searchQuery.replacingOccurrences(of: " ", with: "%20")
        let url = "https://gateway.marvel.com:443/v1/public/characters?nameStartsWith=\(originalQuery)&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            if let error = err{
                print(err?.localizedDescription)
                return
            }
            guard let APIData = data else{
                print("no data found")
                return
            }
            do{
                let characters = try JSONDecoder().decode(APIResult.self, from: APIData)
                DispatchQueue.main.sync {
                    if self.fectchedCharacters == nil{
                        self.fectchedCharacters =  characters.data.results
                    }
                }
            }
            catch
            {
                print(error.localizedDescription)
            }
        }.resume()
    }
    func MD5(data:String) -> String{
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        return hash.map{
            String(format: "%02hhx", $0)
        }.joined()
    }
    func fetchComics() {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
        let url = "https://gateway.marvel.com:443/v1/public/comics?limit=20&offset=\(offset)&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            if let error = err{
                print(err?.localizedDescription)
                return
            }
            guard let APIData = data else{
                print("no data found")
                return
            }
            do{
                let characters = try JSONDecoder().decode(APIComicResult.self, from: APIData)
                DispatchQueue.main.sync {
                              }
            }
            catch
            {
                print(error.localizedDescription)
            }
        }.resume()
    }
}


