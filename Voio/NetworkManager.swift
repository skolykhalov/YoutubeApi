//
//  NetworkManager.swift
//  Voio
//
//  Created by Stas on 05.10.2022.
//

import Foundation
import Alamofire

struct NetworkManager {
    
    func parceYoutubeData<T: Decodable> (url: String, completion: @escaping(T) -> () ) {
        
        AF.request(url).responseJSON { responce in
            
            let decoder = JSONDecoder()

            do {
                if let safeData = responce.data {
                    let responceData = try! decoder.decode(T.self, from: safeData)
                    completion(responceData)
                }
            }
        }
    }
    
    
}
