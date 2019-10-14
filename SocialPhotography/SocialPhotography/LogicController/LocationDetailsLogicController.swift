//
//  LocationDetailsLogicController.swift
//  SocialPhotography
//
//  Created by Danish Aziz on 13/10/19.
//  Copyright © 2019 Danish Aziz. All rights reserved.
//

import UIKit

class LocationDetailsLogicController: NSObject {

    var txtNote: UITextView?
    var lblName: UILabel?
    var navigation: UINavigationController?
    var note: Note?
    let viewModel: LocationViewModel = LocationViewModel()
    
    // Setup
    func setup(txtNote: UITextView, lblName: UILabel) {
        self.txtNote = txtNote
        self.lblName = lblName
        self.txtNote?.layer.borderColor = UIColor.black.cgColor
        self.txtNote?.layer.borderWidth = 1.0
        self.lblName?.text = note?.name
        self.txtNote?.text = note?.message
    }
    
    func updateNote() {
        if let note = note, let message = self.txtNote?.text {
            self.viewModel.updateLocations(by: note.id, note: message)
            NotificationCenter.default.post(name: .updateNote, object: nil)
            let alert = UIAlertController(title: nil, message: "Note saved.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK".uppercased(), style: .cancel, handler: nil))
            self.navigation?.popViewController(animated: true)
            self.navigation?.present(alert, animated: true, completion: nil)
        }
    }
}
