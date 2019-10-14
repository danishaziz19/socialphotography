//
//  MapViewController.swift
//  SocialPhotography
//
//  Created by Danish Aziz on 12/10/19.
//  Copyright © 2019 Danish Aziz. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    let mapLogicController: MapLogicController = MapLogicController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // setup mapview
    func setup() {
        self.mapLogicController.setupMap(mapView: self.mapView, navigation: self.navigationController)
        self.mapLogicController.storyBoard = self.storyboard
    }
    
    @IBAction func currentLocaionPress(_ sender: UIButton) {
        self.mapLogicController.setCurrentLocaion()
    }
    
    @IBAction func addLocationPress(_ sender: UIButton) {
        self.addLocation()
    }
    
    // Add new location
    func addLocation() {
        let alert = UIAlertController(title: "Add Location", message: nil, preferredStyle: UIAlertController.Style.alert )

        let save = UIAlertAction(title: "Save", style: .default) { (alertAction) in
            let textFieldName = alert.textFields![0] as UITextField
            let textFieldNote = alert.textFields![1] as UITextField
            if let name = textFieldName.text, let note = textFieldNote.text, !name.isEmpty {
                self.mapLogicController.addLocation(name: name, message: note)
            }
        }

        alert.addTextField { (textField) in
            textField.placeholder = "name..."
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "note..."
        }

        alert.addAction(save)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default) { (alertAction) in })

        self.present(alert, animated:true, completion: nil)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchNoteViewController" {
            let searchNoteViewController: SearchNoteViewController = segue.destination as! SearchNoteViewController
            let location = CLLocation(latitude: self.mapLogicController.lastKnonwLocation.latitude, longitude: self.mapLogicController.lastKnonwLocation.longitude)
            let notes: Notes = self.mapLogicController.notes.sorted(by: { $0.distance(to: location) < $1.distance(to: location) })
            searchNoteViewController.searchLogicController.notes = notes
        }
    }
}
