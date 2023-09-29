//
//  ContentView.swift
//  H4X0R
//
//  Created by Saurabh Kumar Verma on 20/07/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var delegateManager = H4X0RViewModel()
    var body: some View {
        NavigationView {
            let data = delegateManager.postData
            List(data) { post in
                NavigationLink(destination: DetailView(url: post.url)) {
                    HStack {
                        Text("\(post.points) ")
                        Text(post.title)
                    }
                }
            }
            .navigationTitle("H4X0R NEWS")
        }
        .onAppear {
            self.delegateManager.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
