//
//  SearchLogicController.swift
//  SocialPhotography
//
//  Created by Danish Aziz on 13/10/19.
//  Copyright © 2019 Danish Aziz. All rights reserved.
//

import UIKit

enum NoteCellType: String {
    case noteCell = "noteCell"
}

class SearchLogicController: NSObject {
    
    var tableView: UITableView!
    var notes: [Note] = []
    var searchNotes: [Note] = []
    var navigation: UINavigationController?
    var storyBoard: UIStoryboard?
    let viewModel: LocationViewModel = LocationViewModel()
    
    // setup tableview and set tableview delegate
    func setupTableView(tableView: UITableView) {
        self.searchNotes = notes
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.registerCells()
        self.reload()
        NotificationCenter.default.addObserver(self, selector: #selector(updateNotes(notification:)), name: .updateNote, object: nil)
    }
    
    @objc
    private func updateNotes(notification: NSNotification) {
        self.notes = viewModel.getLocations()
        self.searchNotes = self.notes
        self.reload()
    }
    
    // register cell for tableview
    func registerCells() {
        self.tableView.register(UINib (nibName: "NoteTableViewCell", bundle: nil), forCellReuseIdentifier: NoteCellType.noteCell.rawValue)
    }
    
    // reload tableview
    func reload() {
        self.tableView.reloadData()
    }
    
    // textField delegate text change
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text?.lowercased(), !text.isEmpty {
            self.searchNotes = self.notes.filter( { $0.message.lowercased().contains(text) || $0.name.lowercased().contains(text) })
        } else {
            self.searchNotes = self.notes
        }
        self.reload()
    }
}

// Marks :- Search Tableview delegate and DataSource

extension SearchLogicController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = self.searchNotes[indexPath.row]
        guard let cell: NoteTableViewCell = tableView.dequeueReusableCell(withIdentifier: NoteCellType.noteCell.rawValue) as? NoteTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.setCell(note: note)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = self.searchNotes[indexPath.row]
        let locationDetailsViewController : LocationDetailsViewController = storyBoard?.instantiateViewController(withIdentifier: "LocationDetailsViewController") as! LocationDetailsViewController
        locationDetailsViewController.locationDetailsLogicController.note = note
        self.navigation?.pushViewController(locationDetailsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
