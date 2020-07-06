//
//  AlbumsCollectionViewController.swift
//  DeezerView
//
//  Created by Damnjan Markovic on 02/07/2020.
//  Copyright © 2020 Damnjan Markovic. All rights reserved.
//

import UIKit

extension AlbumsCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return albumList.count
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCollectionCell", for: indexPath)
            as! AlbumsCollectionViewCell
            cell.lblAlbumArtist.text = self.artist.name.capitalized
            cell.lblAlbumTitile.text = self.albumList[indexPath.row].title.capitalized

            ImageManager.getImage(albumList[indexPath.row].cover){(result) in switch result {
            
            
            case.success(let data):
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    cell.imageArtist.image = image
//                    cell.imageArtist.clipsToBounds = true
//                    cell.imageArtist.layer.cornerRadius = cell.imageArtist.frame.height/2
//                    cell.imageArtist.contentMode = .scaleAspectFill

                }
            case.failure( _):
                print("nije stigla slika")
                }
            }
        return cell
    
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        album = albumList[indexPath.row]
        performSegue(withIdentifier: Constants.segueToSongs, sender: self)
    
    }
    
}

class AlbumsCollectionViewController: UIViewController {

    
    
    
    @IBOutlet var collectionView: UICollectionView!
    var artist: Artist!
    var albumList = [Album]()
    var album: Album!
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        downloadAlbums()
    }
    
    func downloadAlbums() {
        
        let artistURL = Constants.deezerURL
        let url = URL (string: "\(artistURL)artist/\(artist.id)/albums")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let _: Void = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                do {
                    let dataAlbumList = try JSONDecoder().decode(DataAlbum.self, from: data!)
                    self.albumList = dataAlbumList.data
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                }catch{
                    print("Json error")
                }
            }
        }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SongViewController {
            destination.album = album
            destination.artist = artist
        }
    }

}

