//
//  cellTableArtist.swift
//  DeezerView
//
//  Created by Damnjan Markovic on 30/06/2020.
//  Copyright © 2020 Damnjan Markovic. All rights reserved.
//

import UIKit

class CellTableArtist: UITableViewCell {

    @IBOutlet weak var lblArtistCell: UILabel!
    @IBOutlet weak var imageArtistCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .darkText
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
