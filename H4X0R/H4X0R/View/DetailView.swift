//
//  DetailView.swift
//  H4X0R
//
//  Created by Saurabh Kumar Verma on 20/07/2023.
//

import SwiftUI

struct DetailView: View {
    var url: String?
    var body: some View {
        WebView(urlString: url)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://www.google.com")
    }
}


