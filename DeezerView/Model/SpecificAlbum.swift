//
//  SpecificAlbum.swift
//  DeezerView
//
//  Created by Damnjan Markovic on 30/06/2020.
//  Copyright © 2020 Damnjan Markovic. All rights reserved.
//

import Foundation

class SpecificAlbum: Decodable {
    let id: Int
    let title: String
    let link: String
    let cover: String
    let tracks: DataTracks
}
