//
//  SongsTableViewCell.swift
//  DeezerView
//
//  Created by Damnjan Markovic on 30/06/2020.
//  Copyright © 2020 Damnjan Markovic. All rights reserved.
//

import UIKit
import AVFoundation

class SongsTableViewCell: UITableViewCell {
var audioPlayer : AVAudioPlayer!
    @IBOutlet weak var lblTrackNumber: UILabel!
    
    @IBOutlet weak var lblTrackLength: UILabel!
    @IBOutlet weak var lblArtistName: UILabel!
    @IBOutlet weak var lblSongName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    
    
}
