//
//  PostRemoteDataSource.swift
//  data
//
//  Created by wito on 22/12/22.
//

import Foundation
import domain


public protocol PostRemoteDataSourceInterface {
    
    init(urlString: String)
    
    func getPosts(handler: @escaping ([PostModel]) -> ())
}


public class PostRemoteDataSource: PostRemoteDataSourceInterface {
    
    let urlString: String
    
    
    required public init(urlString: String) {
        self.urlString = urlString
    }
    
    public func getPosts(handler: @escaping ([PostModel]) -> ()) {
        
        guard let url = URL(string: urlString) else {
            return handler([])
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, urlResponse, error) in
            
            guard let data = data else {
                return handler([])
            }
            
            do {
               //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [ Any] {
                   print("Response: ")
                  print(json)
                    let decodedObject = try JSONDecoder().decode([PostModel].self, from: data)
                    return handler(decodedObject)
               }
            } catch let error {
              print(error.localizedDescription)
            }
           
        }
        task.resume()
        
    }
}
