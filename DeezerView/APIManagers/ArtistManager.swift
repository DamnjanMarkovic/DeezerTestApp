//
//  ArtistManager.swift
//  DeezerView
//
//  Created by Damnjan Markovic on 30/06/2020.
//  Copyright © 2020 Damnjan Markovic. All rights reserved.
//

import Foundation

protocol ArtistManagerDelegate {
    func didUpdateArtists(_ artistManager: ArtistManager, artists: [Artist])
    func didFailWithError(error: Error)
}

struct ArtistManager {
    let artistURL = Constants.deezerURL
    var delegate: ArtistManagerDelegate?
    func getArtists(artistName: String) {
        let urlString = "\(artistURL)search/artist?&q=\(artistName)"
        performRequest(with: urlString)
    }
      
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let dataReceived = self.parseJSON(safeData){
                        DispatchQueue.main.async {
                            self.delegate?.didUpdateArtists(self, artists: dataReceived)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ artistData: Data) -> [Artist]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(DataReceived.self, from: artistData)
            return decodedData.data
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
}
