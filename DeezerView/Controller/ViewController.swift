//
//  ViewController.swift
//  DeezerView
//
//  Created by Damnjan Markovic on 30/06/2020.
//  Copyright © 2020 Damnjan Markovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var imageTitle: UIImageView!
    @IBOutlet weak var tfArtist: UITextField!
    @IBOutlet weak var tableViewArtists: UITableView!
    var artistManager = ArtistManager()
    var artistList = [Artist]()
    var artistsNamesList = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tfArtist.addTarget(self, action: #selector(searchRecords(_ :)), for: .editingChanged)
        artistManager.delegate = self
        tableViewArtists.dataSource = self
        tableViewArtists.delegate = self
        tableViewArtists.register(UINib(nibName: Constants.cellTableArtist, bundle: nil), forCellReuseIdentifier: Constants.reusableCellArtist)
    }
    

  
    @objc func searchRecords(_ textField: UITextField) {
    self.artistList.removeAll()
        if let artist = tfArtist.text {
            artistManager.getArtists(artistName: artist)
            tableViewArtists.reloadData()
        }
   }
    
    
    @IBAction func btnFetchArtist(_ sender: UIButton) {
        if let artist = tfArtist.text {
            artistManager.getArtists(artistName: artist)
            
            tableViewArtists.reloadData()
        }
    }
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.artistList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reusableCellArtist, for: indexPath) as! cellTableArtist
        cell.lblArtistCell.text = artistList[indexPath.row].name
        ImageManager.getImage( artistList[indexPath.row].picture){(result) in switch result {
                case.success(let data):
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.imageArtistCell.image = image
                     }
                case.failure( _):
                    print("nije stigla slika")
                }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.segueToAlbums, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AlbumViewController {
            destination.artist = artistList[(tableViewArtists.indexPathForSelectedRow?.row)!]
            
        }
        
    }

    
}

extension ViewController: ArtistManagerDelegate {
    func didUpdateArtists(_ artistManager: ArtistManager, artists artist: [Artist]) {
       
        DispatchQueue.main.async {
            self.artistList.removeAll()
            for art in artist {
                self.artistList.append(art)
            }
            self.tableViewArtists.reloadData()
        }
        
    }
    
    
    func didFailWithError(error: Error) {
        print(error)
    }
}





