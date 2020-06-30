//
//  ImageManager.swift
//  DeezerView
//
//  Created by Damnjan Markovic on 30/06/2020.
//  Copyright © 2020 Damnjan Markovic. All rights reserved.
//

import Foundation

struct ImageManager: Decodable {

    let artistURL = Constants.deezerURL
    let id_image: Int
    let imageLocation: String
    let imagename: String


    static func getImage(_ urlImage: String, completed: @escaping (Result<Data, Error>) -> ()) -> () {

      let url = URL (string: urlImage)
      var request = URLRequest(url: url!)
      request.httpMethod = "GET"
      let session = URLSession.shared
      session.dataTask(with: request) { (data, response, error) in
          if error == nil {
              completed(.success(data!))
          }
      }.resume()
       
    }
    
    
}

