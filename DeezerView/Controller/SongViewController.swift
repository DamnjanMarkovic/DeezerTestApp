//
//  SongViewController.swift
//  DeezerView
//
//  Created by Damnjan Markovic on 30/06/2020.
//  Copyright © 2020 Damnjan Markovic. All rights reserved.
//

import UIKit
import AVFoundation

class SongViewController: UIViewController {

    @IBOutlet weak var imageAlbum: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewSongs: UITableView!
    @IBOutlet weak var lblAlbumName: UILabel!
    var album: Album!
    var artist: Artist!
    var songsList = [Song]()
    var specificAlbums: SpecificAlbum!
    var specificSongPreview: String!
//    var audioVideoPlayer = AVAudioPlayer()
    var audioPlayer = AVPlayer()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        
        lblAlbumName.text = "\(album.title)\n\(artist.name)"
        
            ImageManager.getImage(album.cover){(result) in switch result {
        case.success(let data):
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.imageAlbum.image = image
            }
        case.failure( _):
            print("nije stigla slika")
            }
        }
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
        print("url za sliku je: \(url)")
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
    
    
    func returnTimings(with totalSeconds: Int) -> (Int, Int){
        var firstNumber: Int = 12
        var secondNumber: Int = 4
        firstNumber = totalSeconds/60
        secondNumber = totalSeconds % 60
        return (firstNumber, secondNumber)
    }


    
}
extension SongViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reusableCellSongs, for: indexPath) as! SongsTableViewCell
        cell.accessoryType = .detailDisclosureButton
        cell.backgroundColor = .black
        cell.lblSongName.text = songsList[indexPath.row].title
        cell.lblTrackNumber.text = "\(indexPath.row + 1)."
        cell.lblArtistName.text = artist.name
        var minuteDuration: Int = 0
        var minuteDurationString: String
        var secondsDuration: Int = 0
        var secondsDurationString: String
        (minuteDuration, secondsDuration) = returnTimings(with: songsList[indexPath.row].duration)
        if minuteDuration < 10 {
            minuteDurationString = "0\(minuteDuration)"
        } else {
            minuteDurationString = "\(minuteDuration)"
        }
        if secondsDuration < 10 {
            secondsDurationString = "0\(secondsDuration)"
        } else {
            secondsDurationString = "\(secondsDuration)"
        }
        cell.lblTrackLength.text = "\(minuteDurationString):\(secondsDurationString)"
        
  
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {

        let urlString1 = "\(songsList[indexPath.row].preview)"
        let url1 = URL (string: urlString1)
            audioPlayer = try AVPlayer(url: url1!)
            
            audioPlayer.play()

        }

        
        
        
        
        
        
        
//        getSound(songsList[indexPath.row].preview) {(result) in switch result {
//                    case.success(let data):
//                    print("stiglo je \(data)")
//                    DispatchQueue.main.async {
//                            print("u dispatch je \(data)")
//
//                    }
//                case.failure( _):
//                    print("nije stigao zvuk")
//            }
//        }
//
//        print(indexPath.row)
    
    
         func getSound(_ urlSound: String, completed: @escaping (Result<Data, Error>) -> ()) -> () {
    
          let url = URL (string: urlSound)
          var request = URLRequest(url: url!)
          request.httpMethod = "GET"
          let session = URLSession.shared
          session.dataTask(with: request) { (data, response, error) in
              if error == nil {
                DispatchQueue.main.async {
                    completed(.success(data!))
                }
    
              }
          }.resume()
    
        }
    
    
    
    
//               audioPlayer = try AVAudioPlayer(contentsOf: sender as! URL)
//    //            } catch {
    //                print(error)
    //            }
    //            audioPlayer.play()
    
    
//    @IBAction func playSound(sender: UIButton){
//
//        let usernameLabel = self.objectAtIndex(sender.tag) as! String
//
//        var following = PFObject(className: "Followers")
//        following["following"] = usernameLabel.text
//        following["follower"] = PFUser.currentUser().username //Currently logged in user
//
//        following.saveInBackground()
//    }
//    
//    
//    
//
//    @IBAction func playSong(_ sender: Any) {
//        
//        print("sender je \(sender)")
////        getSound(sender as! String){(result) in switch result {
////
////
////            case.success(let data):
////                print("stiglo je \(data)")
////                DispatchQueue.main.async {
////                        print("u dispatch je \(data)")
////
////                }
////            case.failure( _):
////                print("nije stigao zvuk")
////            }
//        }
//    }
//    
//    
//    
//    
//    
////@IBAction func btnDeleteOrder(_ sender: UIButton) {
////    let point = sender.convert(CGPoint.zero, to: tblViewIngredients)
////    guard let indexpath = tblViewIngredients.indexPathForRow(at: point)
////        else {return}
////    ingredientsOfferSelected.remove(at: indexpath.row)
////    tblViewIngredients.beginUpdates()
////    tblViewIngredients.deleteRows(at: [IndexPath(row: indexpath.row, section: 0)], with: .left)
////    tblViewIngredients.endUpdates()
////}
    
}
