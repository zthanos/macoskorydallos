//
//  HtmlHelper.swift
//  korydallos
//
//  Created by user172589 on 9/6/20.
//  Copyright © 2020 user172589. All rights reserved.
//
import SwiftUI
import Foundation
import WebKit

struct HTMLLabel: UIViewRepresentable {
    @State var html : String = ""


    func makeUIView(context: UIViewRepresentableContext<Self>) -> UILabel {
        let label = UILabel()
        print(html)
        label.attributedText = html.convertToAttributedFromHTML()
        ///label.attributedText = html.convertHtml()

        return label
    }

    func updateUIView(_ uiView: UILabel, context: UIViewRepresentableContext<Self>) {}

}


struct HtmlView : UIViewRepresentable {
    let htmlString : String
    let encoded : Bool 
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
      func updateUIView(_ uiView: WKWebView, context: Context) {
      
        let htmlbody = encoded ? htmlString.fromBase64() ?? "" : htmlString

        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 100%; } </style>
        </head>
        <body>
        \(htmlbody)
        </body0
        </html>
        """
        uiView.loadHTMLString(html, baseURL: nil)
    }
    
}
