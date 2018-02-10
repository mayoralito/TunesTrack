//
//  NetworkHandler.swift
//  TunesTrack
//
//  Created by Cruz, Adrian (Contractor) on 10/3/17.
//  Copyright © 2017 :]. All rights reserved.
//

import Foundation

typealias CompletedOperation = (_ response: [String: Any]?) -> Void

class NetworkHandler {
    
    static let shared = NetworkHandler()
    
    private init() {
        
    }
    
    func getTrack(_ term: String, onCompletion: @escaping CompletedOperation) {
        let term = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlString = "https://itunes.apple.com/search?term=\(term!)"
        
        let taks = URLSession.shared.dataTask(with: URL(string: urlString)!) { (data: Data?, response: URLResponse?, error: Error?) in
            
            do {
                let jsonResponse
                    = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any]
                
                onCompletion(jsonResponse)
            }catch (_) {
                onCompletion(nil)
            }
        }
        
        taks.resume()
    }
}
