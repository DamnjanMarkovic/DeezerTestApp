//
//  Constants.swift
//  DeezerView
//
//  Created by Damnjan Markovic on 30/06/2020.
//  Copyright © 2020 Damnjan Markovic. All rights reserved.
//

import Foundation

struct Constants {
    
    static let appName = "DeezerView"
    
    static let deezerURL = "https://api.deezer.com/"       //  + search/artist?q= + artistName
//    static let deezerURLAlbums = "https://api.deezer.com/artist/"                //  + idArtist + /albums
//    static let deezerURLSongs = "https://api.deezer.com/album/"                  //  + idAlbum
//    static let deezerURLArtistPicture = "http://api.deezer.com/artist/"         //  + idArtist + /image
    
    static let segueToAlbumsCollecitons = "segueToAlbumsColections"
    static let segueToAlbums = "segueToAlbums"
    static let segueToSongs = "segueToSongs"
    

    static let reusableCellArtist = "ReusableCellArtist"
    static let cellTableArtist = "cellTableArtist"
    static let reusableCellAlbums = "ReusableCellAlbums"
    static let cellTableAlbums = "AlbumTableViewCell"
    static let reusableCellSongs = "ReusableCellSongs"
    static let cellTableSongs = "SongsTableViewCell"
    static let alertTitle = "ALERT"
    static let alertDismiss = "Dismiss"
    
}
