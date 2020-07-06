//
//  ViewController.swift
//  DeezerView
//
//  Created by Damnjan Markovic on 30/06/2020.
//  Copyright © 2020 Damnjan Markovic. All rights reserved.
//

import UIKit

class ArtistViewController: UIViewController {


    @IBOutlet weak var lblSelectedSearch: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageTitle: UIImageView!
//    @IBOutlet weak var tfArtist: UITextField!
    @IBOutlet weak var tableViewArtists: UITableView!
    var artistManager = ArtistManager()
    var artistList = [Artist]()
    var artistsNamesList = [String]()
    var typedIn = String()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkText
        
        artistManager.delegate = self
        self.searchBar.delegate = self
        tableViewArtists.dataSource = self
        tableViewArtists.delegate = self
        tableViewArtists.register(UINib(nibName: Constants.cellTableArtist, bundle: nil), forCellReuseIdentifier: Constants.reusableCellArtist)
        setLabelSearchSearchBar()
//        self.searchBar.endEditing(true)

    }
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .black
    }

    func setLabelSearchSearchBar(){
        lblSelectedSearch.text = "     🎤     ARTISTS"
        lblSelectedSearch.textColor = .white
        self.searchBar.barTintColor = .white
    
    }
    


}

extension ArtistViewController: UISearchBarDelegate, UISearchDisplayDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
          self.searchBar.endEditing(true)
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchBar.text!)
        if let artist = searchBar.text {
            artistManager.getArtists(artistName: artist)

        }
    }
    

    

    
    
}

extension ArtistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.artistList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reusableCellArtist, for: indexPath) as! CellTableArtist

        cell.lblArtistCell.text = "  \(artistList[indexPath.row].name.capitalized)"
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
        performSegue(withIdentifier: Constants.segueToAlbumsCollecitons, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AlbumsCollectionViewController {
            destination.artist = artistList[(tableViewArtists.indexPathForSelectedRow?.row)!]
            
        }
        
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: Constants.segueToAlbums, sender: self)
//    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? AlbumViewController {
//            destination.artist = artistList[(tableViewArtists.indexPathForSelectedRow?.row)!]
//
//        }
//
//    }

    
}

extension ArtistViewController: ArtistManagerDelegate {
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





