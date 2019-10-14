//
//  SearchNoteViewController.swift
//  SocialPhotography
//
//  Created by Danish Aziz on 12/10/19.
//  Copyright © 2019 Danish Aziz. All rights reserved.
//

import UIKit

class SearchNoteViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var textFieldView: UIView!
    
    let searchLogicController: SearchLogicController = SearchLogicController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setup()
    }
    
    // set tableview and SearchField Delegate
    func setup() {
        self.textFieldView.layer.borderWidth = 1.0
        self.textFieldView.layer.borderColor = UIColor.gray.cgColor
        self.txtSearch.delegate = self
        self.title = "Locations"
        self.searchLogicController.setupTableView(tableView: self.tableView)
        self.searchLogicController.navigation = self.navigationController
        self.searchLogicController.storyBoard = self.storyboard
        self.txtSearch.addTarget(self.searchLogicController, action: #selector(self.searchLogicController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    // text field delegate when press return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
