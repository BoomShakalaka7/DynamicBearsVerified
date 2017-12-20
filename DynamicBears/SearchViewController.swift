//
//  SearchViewController.swift
//  DynamicBears
//
//  Created by Davide Maimone on 14/12/17.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredArray: [Card] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.scopeButtonTitles = ["All", "Students", "Mentors"]
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String) {
        if scope == "All" {
            print("Scope == All")
            filteredArray = Singleton.shared.cardsList.filter({ (card) -> Bool in
                let testo = (card.name + " " + card.surname).lowercased()
                let testo2 = (card.surname + " " + card.name).lowercased()
                return testo.contains(searchText.lowercased()) || testo2.contains(searchText.lowercased())
            })
        }
        if scope == "Students" {
            print("Scope == Students")
            if searchBarIsEmpty() {
                filteredArray = Singleton.shared.studentsList
            }
            else {
                filteredArray = Singleton.shared.studentsList.filter({ (card) -> Bool in
                    let testo = (card.name + " " + card.surname).lowercased()
                    let testo2 = (card.surname + " " + card.name).lowercased()
                    print(testo)
                    return testo.contains(searchText.lowercased()) || testo2.contains(searchText.lowercased())

                })
            }
        }
        if scope == "Mentors" {
            print("Scope == Mentors")
            if searchBarIsEmpty() {
                filteredArray = Singleton.shared.mentorsList
            }
            else {
                filteredArray = Singleton.shared.mentorsList.filter({ (card) -> Bool in
                    let testo = (card.name + " " + card.surname).lowercased()
                    let testo2 = (card.surname + " " + card.name).lowercased()
                    return testo.contains(searchText.lowercased()) || testo2.contains(searchText.lowercased())
                })
            }
        }
        table.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            print(filteredArray.count)
            return filteredArray.count
        }
        return Singleton.shared.cardsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let card: Card
        if isFiltering() {
            card = filteredArray[indexPath.row]
        } else {
            card = Singleton.shared.cardsList[indexPath.row]
        }
        cell.textLabel!.text = card.name
        cell.detailTextLabel!.text = card.surname
        cell.imageView?.image = card.photo
//        cell.imageView?.layer.cornerRadius = 10
//        cell.imageView?.layer.masksToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        //filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
        updateSearchResults(for: searchController)
    }

    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailVC" {
            if let indexPath = table.indexPathForSelectedRow {
                let controller = segue.destination as! DetailViewController
                if isFiltering() {
                    let card = filteredArray[indexPath.row]
                    controller.detailCard = card
                } else {
                    let card = Singleton.shared.cardsList[indexPath.row]
                    controller.detailCard = card
                }
//                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
//                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailVC", sender: self)
    }
}

