//
//  NoteTableViewCell.swift
//  SocialPhotography
//
//  Created by Danish Aziz on 13/10/19.
//  Copyright © 2019 Danish Aziz. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(note: Note) {
        self.lblName.text = note.name
        self.lblMessage.text = note.message
    }
}
