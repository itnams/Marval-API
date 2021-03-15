//
//  WebView.swift
//  Marval API
//
//  Created by namnguyen on 15/03/2021.
//

import SwiftUI
import WebKit
struct WebView: UIViewRepresentable {
    var url:URL
    func makeUIView(context: Context) -> WKWebView {
            let view = WKWebView()
        view.load(URLRequest(url: url))
        return view
    }
    func updateUIView(_ uiView: UIViewType,context : Context){
        
    }
    
}
