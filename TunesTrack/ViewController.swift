//
//  ViewController.swift
//  TunesTrack
//
//  Created by Cruz, Adrian (Contractor) on 10/3/17.
//  Copyright © 2017 :]. All rights reserved.
//

import UIKit


enum TableViewCellIdentifiers: String {
    case basic
}

class ViewController: UIViewController {
    
    var search: UISearchBar!
    var tableView: UITableView!
    var trackGroups = [TrackGroups]()
    let delayer = Delayer()
    let trackModel = TrackModel()
    
    var playerVC: PlayerViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        
        createSearchUI()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //search.text = "beyonce"
        //searchContent(search.text!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func createSearchUI() {
        search = UISearchBar(frame: CGRect(
            x: 0,
            y: 0,
            width: self.view.frame.width,
            height: 44)
        )
        search.delegate = self
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(
            x: self.view.frame.origin.x,
            y: self.view.frame.origin.y,
            width: self.view.frame.width,
            height: self.view.frame.size.height
            ),
                                style: .plain
        )
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0
        )
        tableView.tableHeaderView = search
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: TableViewCellIdentifiers.basic.rawValue)
        
        view.addSubview(tableView)
    }
    
    func searchContent(_ searchText: String) {
        
        self.trackModel.getTrackBy(artist: searchText) { (groups: [TrackGroups]?) in
            
            self.trackGroups.removeAll()
            
            guard let groups = groups else {
                // Items not found.
                // Handle errors
                return
            }
            
            self.trackGroups = groups
            
            // reaload table
            DispatchQueue.main.async(execute: {
                self.tableView.reloadData()
                self.removeSpinner()
            })
            
        }
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return trackGroups.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackGroups[section].tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.basic.rawValue, for: indexPath)
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: TableViewCellIdentifiers.basic.rawValue)
        cell.accessoryType = .disclosureIndicator
        
        // -----
        let sectionGroup:[Track]    = trackGroups[indexPath.section].tracks
        let item                    = sectionGroup[indexPath.row]
        
        cell.textLabel?.text        = item.trackName
        cell.detailTextLabel?.text  = item.collectionName
        cell.imageView?.image       = UIImage(named: "this-is-fine")
        cell.imageView?.contentMode = .scaleAspectFit
        
        self.trackModel.parseImage(string: item.artworkUrl) { (image: UIImage?) in
            
            DispatchQueue.main.async(execute: { 
                cell.imageView?.image = image
            })
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return trackGroups[section].filter
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionGroup:[Track]    = trackGroups[indexPath.section].tracks
        let item                    = sectionGroup[indexPath.row]
        
        if playerVC == nil {
            playerVC = PlayerViewController()
        }
        
        playerVC!.track = item
        self.navigationController?.pushViewController(playerVC!, animated: true)
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        delayer.start(delay: 1) { [weak self] (_) -> Void in
            print("Query for: \(searchText)")
            self?.addSpinner()
            self?.searchContent(searchText)
        }
        
    }
    
}
