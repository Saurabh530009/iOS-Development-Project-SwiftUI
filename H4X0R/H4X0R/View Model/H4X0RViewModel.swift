//
//  NetworkViewModel.swift
//  H4X0R
//
//  Created by Saurabh Kumar Verma on 20/07/2023.
//

import Foundation
import SwiftUI


//MARK: - H4X0RViewModel
class H4X0RViewModel: ObservableObject {
    @Published var postData: [Post] = []

    let urlString = "https://hn.algolia.com/api/v1/search?tags=front_page#"
    
    func fetchData(){
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { [weak self] (data, response, error) in
            if (error != nil) {
                print("Error Occured\n")
            }
            
            if let safeData = data {
                print(safeData)
                if let parsedData = self?.parseJSON(safeData){
                    DispatchQueue.main.async {
//                        print(parsedData)
                        self?.postData = parsedData.hits
                    }
                    
                }
                
            }
        }.resume()
    }
    
    // MARK: - parseJSON
    func parseJSON(_ data: Data) -> PostData? {
        
        //Create a JSONDecoder
        let decoder = JSONDecoder()
        do {
            //try to decode the data using the CoinData structure
            let decodedData = try decoder.decode(PostData.self, from: data)
            
            return decodedData
            
        } catch {
            
            //Catch and print any errors.
            print(error)
            return nil
        }
    }
}
