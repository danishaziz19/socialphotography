//
//  LocationDetailsViewController.swift
//  SocialPhotography
//
//  Created by Danish Aziz on 13/10/19.
//  Copyright © 2019 Danish Aziz. All rights reserved.
//

import UIKit

class LocationDetailsViewController: UIViewController {

    @IBOutlet weak var txtNote: UITextView!
    @IBOutlet weak var lblName: UILabel!
    
    let locationDetailsLogicController: LocationDetailsLogicController = LocationDetailsLogicController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setup()
    }
    
    func setup() {
       self.title = "Location Details"
       self.locationDetailsLogicController.setup(txtNote: txtNote, lblName: lblName)
        self.locationDetailsLogicController.navigation = self.navigationController
    }
    
    @IBAction func SavePress(_ sender: UIButton) {
        self.locationDetailsLogicController.updateNote()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
