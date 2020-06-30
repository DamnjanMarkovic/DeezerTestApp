//
//  AlbumViewController.swift
//  DeezerView
//
//  Created by Damnjan Markovic on 30/06/2020.
//  Copyright © 2020 Damnjan Markovic. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {

    @IBOutlet weak var lblAlbumName: UILabel!
    @IBOutlet weak var imageAlbum: UIImageView!
    var artist: Artist!
    var albumList = [Album]()
    
    
    
    @IBOutlet weak var tableViewAlbum: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewAlbum.delegate = self
        tableViewAlbum.dataSource = self
        tableViewAlbum.register(UINib(nibName: Constants.cellTableAlbums, bundle: nil), forCellReuseIdentifier: Constants.reusableCellAlbums)
        setAlbumNameAndImage()
        downloadAlbums {
            self.tableViewAlbum.reloadData()
        }

    }
    
    func setAlbumNameAndImage() {
        lblAlbumName.text = artist.name.capitalized

    }
    
    
    func downloadAlbums(completed: @escaping () -> ()) {
        
        let artistURL = Constants.deezerURL
        let url = URL (string: "\(artistURL)artist/\(artist.id)/albums")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let _: Void = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                do {
                    let dataAlbumList = try JSONDecoder().decode(DataAlbum.self, from: data!)

                    DispatchQueue.main.async {
                        for album in dataAlbumList.data {
                            self.albumList.append(album)
                        }
                        completed()
                    }
                }catch{
                    print("Json error")
                }
            }
        }.resume()
    }


}

extension AlbumViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reusableCellAlbums, for: indexPath) as! AlbumTableViewCell
        cell.lblAlbumCell.text = albumList[indexPath.row].title
        ImageManager.getImage( albumList[indexPath.row].cover){(result) in switch result {
                case.success(let data):
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.imageAlbum.image = image
                     }
                case.failure( _):
                    print("nije stigla slika")
                }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.segueToSongs, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SongViewController {
            destination.album = albumList[(tableViewAlbum.indexPathForSelectedRow?.row)!]

        }
        
    }
    
    
}
