//
//  SongViewController.swift
//  DeezerView
//
//  Created by Damnjan Markovic on 30/06/2020.
//  Copyright © 2020 Damnjan Markovic. All rights reserved.
//

import UIKit

class SongViewController: UIViewController {

    @IBOutlet weak var tableViewSongs: UITableView!
    @IBOutlet weak var lblAlbumName: UILabel!
    var album: Album!
    var songsList = [Song]()
    var specificAlbums: SpecificAlbum!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblAlbumName.text = album.title
        tableViewSongs.delegate = self
        tableViewSongs.dataSource = self
        tableViewSongs.register(UINib(nibName: Constants.cellTableSongs, bundle: nil), forCellReuseIdentifier: Constants.reusableCellSongs)
        downloadSongs {
            self.tableViewSongs.reloadData()
        }
        
    }
    
    func downloadSongs(completed: @escaping () -> ()) {
        
        let artistURL = Constants.deezerURL
        let urlString = "\(artistURL)album/\(album.id)"
        let url = URL (string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let _: Void = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                do {
                    let specificAlbum = try JSONDecoder().decode(SpecificAlbum.self, from: data!)
                    DispatchQueue.main.async {
                        self.songsList = specificAlbum.tracks.data
                        completed()
                    }
                }catch{
                    print("Json error")
                }
            }
        }.resume()
    }
    

}
extension SongViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reusableCellSongs, for: indexPath) as! SongsTableViewCell
        cell.lblSongTitle.text = songsList[indexPath.row].title
        
        return cell
    }

    
    
}
