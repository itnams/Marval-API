//
//  Home.swift
//  Marval API
//
//  Created by namnguyen on 15/03/2021.
//

import SwiftUI

struct Home: View {
    @StateObject var homeData = HomeViewModel()
    var body: some View {
        TabView{
            CharactersView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Chracters")
                }.environmentObject(homeData)
            
            Text("Comics").tabItem {
                Image(systemName: "books.vertical.fill")
                Text("Comics")
            }
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
