//
//  InfoView.swift
//  SaurabhCard
//
//  Created by Saurabh Kumar Verma on 20/07/2023.
//

import SwiftUI

struct InfoView: View {
    let text: String
    let imageName: String
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.white)
            .frame(maxHeight: 50)
            .overlay {
                HStack {
                    Image(systemName: imageName)
                        .foregroundColor(.green)
                    Text(text)
                        .bold()
                }
            }
            .padding(.all)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(text: "+91 700 603 5184", imageName: "phone.fill")
            .previewLayout(.sizeThatFits)
    }
}
