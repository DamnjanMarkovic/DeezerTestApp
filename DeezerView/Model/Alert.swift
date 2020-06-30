//
//  Alert.swift
//  DeezerView
//
//  Created by Damnjan Markovic on 30/06/2020.
//  Copyright © 2020 Damnjan Markovic. All rights reserved.
//

import UIKit

class Alert {
    
    func alert(message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: Constants.alertTitle, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.alertDismiss, style: .cancel, handler: nil)
        alert.addAction(action)
        return alert
    }
}
