//
//  ContentView.swift
//  SaurabhCard
//
//  Created by Saurabh Kumar Verma on 20/07/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(UIColor(red: 0.09, green: 0.63, blue: 0.52, alpha: 1.00))
                .edgesIgnoringSafeArea(.all)

            
            VStack {
                Image("saurabh")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(Color.white, lineWidth: 5)
                    }
                    
                
                Text("Saurabh Verma")
                    .font(Font.custom("Pacifico-Regular", size: 40))
                    .bold()
                    .foregroundColor(.white)
                
                
                Text("iOS Developer")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                
                Divider()
                InfoView(text: "+91 700 603 5184", imageName: "phone.fill")
                InfoView(text: "saurabht530009@gmail.com", imageName: "envelope.fill")
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


