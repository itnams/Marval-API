//
//  CharactersView.swift
//  Marval API
//
//  Created by namnguyen on 15/03/2021.
//

import SwiftUI
import SDWebImageSwiftUI
struct CharactersView: View {
    @EnvironmentObject var homeData: HomeViewModel
    var body: some View {
        NavigationView{
            ScrollView(.vertical,showsIndicators: false,content:{
                VStack(spacing:15 )
                {
                    HStack(spacing:10)
                    {
                        Image(systemName: "magnifyingglass").foregroundColor(.gray)
                        TextField("Search Character", text: $homeData.searchQuery).autocapitalization(.none).disableAutocorrection(true)
                    }.padding(.vertical,10)
                    .padding(.horizontal)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)
                }.padding()
                if let characters = homeData.fectchedCharacters{
                    if characters.isEmpty{
                        Text("No Results Found").padding(.top,20)
                    }
                    else
                    {
                        ForEach(characters)
                        {
                            data in
                            CharacterRowView(character: data)
                        }
                    }
                }
                else
                {
                    if homeData.searchQuery != ""{
                        ProgressView().padding(.top,20)
                    }
                }
            }).navigationTitle("Marvel")
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct CharacterRowView: View {
    var character : Character
    var body: some View
    {
        HStack (alignment: .top, spacing: 15){
            WebImage(url: extractImage(data:character.thumbnail)).resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/).frame(width:150, height: 150)
                .cornerRadius(8)
            VStack(alignment: .leading, spacing: 8, content: {
                Text(character.name).font(.title3).fontWeight(.bold)
                Text(character.description).font(.caption).foregroundColor(.gray).lineLimit(4).multilineTextAlignment(.leading)
                HStack(spacing:10){
                    ForEach(character.urls,id: \.self){
                        data in
                        NavigationLink(
                            destination: WebView(url: extractURL(data: data)),
                            label: {
                                Text(extractURLType(data: data))
                            })
                    }
                }
            })
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
        }.padding(.horizontal)
    }
    func extractImage(data: [String:String]) ->URL {
        let path = data["path"] ?? ""
        let ext = data["extension"] ?? ""
        return URL(string: "\(path).\(ext)")!
    }
    func extractURL(data:[String:String]) -> URL{
        let  url = data["url"] ?? ""
        return URL(string: url)!
    }
    func extractURLType(data:[String:String]) -> String {
        let type = data["type"] ?? ""
        return type.capitalized
    }
}
