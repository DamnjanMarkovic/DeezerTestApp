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
        
        cell.lblAlbumArtist.text = artist.name.capitalized
        cell.lblAlbumTitile.text = albumList[indexPath.row].title.capitalized
        ImageManager.getImage( albumList[indexPath.row].cover){(result) in switch result {
                case.success(let data):
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.imageArtist.image = image
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadAlbums {
            self.collectionView.reloadData()
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SongViewController {
            destination.album = album
        }
    }

}

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */


