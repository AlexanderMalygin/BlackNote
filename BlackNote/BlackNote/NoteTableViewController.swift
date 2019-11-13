//
//  NoteTableViewController.swift
//  BlackNote
//
//  Created by Alexader Malygin on 16.10.2019.
//  Copyright © 2019 Alexader Malygin. All rights reserved.
//

import UIKit
import CoreData

class NoteTableViewController: UITableViewController {
    
    
    private var filteredNotes = [Notes]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    private var isFiltered: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the SearchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    
    // MARK: - Create new note
    
    var selectedNote: Notes?
    @IBAction func addNoteButton(_ sender: Any) {
        
       selectedNote = Notes.newNote(title: "")
        performSegue(withIdentifier: "goToNote", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToNote" {
            
            
            (segue.destination as! ViewController).note = selectedNote
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered {
            return filteredNotes.count
        }
        return notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        var note: Notes
        
        if isFiltered{
            note = filteredNotes[indexPath.row]
        } else {
            note = notes[indexPath.row]
        }
        
        
//        let noteInCell = notes[indexPath.row]
        
        cell.textLabel?.text = note.title
        cell.detailTextLabel?.text = note.note

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteInCell = isFiltered ? filteredNotes[indexPath.row] : notes[indexPath.row]
        selectedNote = noteInCell
        
        performSegue(withIdentifier: "goToNote", sender: self)
    }
    
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
           let noteInCell = notes[indexPath.row]
            
           CoreDataManager.sharedInstance.managedObjectContext.delete(noteInCell)
           CoreDataManager.sharedInstance.saveContext()

            self.tableView.deleteRows(at: [indexPath], with: .left)
           
        
    }


}
}

extension NoteTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    private func filterContentForSearchText(_ searchText: String) {
        filteredNotes = notes.filter({ (note: Notes) -> Bool in
            return (note.title?.lowercased().contains(searchText.lowercased()))!
        })
        tableView.reloadData()
    }
    
    
}
