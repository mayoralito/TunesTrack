//
//  TrackModel.swift
//  TunesTrack
//
//  Created by Cruz, Adrian (Contractor) on 10/3/17.
//  Copyright © 2017 :]. All rights reserved.
//

import UIKit

typealias OnCompletion = (_ response: [Track]?) -> Void
typealias OnCompletionWithGroups = (_ response: [TrackGroups]?) -> Void

class TrackModel {
    
    init() {
        
    }
    
    deinit {
        
    }
    
    func getTrackByArtist(name field: String, onCompletion: @escaping OnCompletion ) {
        
        NetworkHandler.shared.getTrack(field) { [weak self] (response: [String : Any]?) in
            
            guard let items = self?.parseDataFromTracks(response) else {
                onCompletion(nil)
                return
            }
            
            onCompletion(items)
        }
        
    }
    
    func parseImage(string stringUrl: String, onCompletion: @escaping (_ image: UIImage?) -> Void ) {
        // Sending this to background
        
        DispatchQueue.global(qos: .background).async {
            let dataImage = try! Data(contentsOf: URL(string: stringUrl)!)
            onCompletion(UIImage(data: dataImage))
        }
        
        
    }
    
    func getTrackBy(artist field: String, onCompletion: @escaping OnCompletionWithGroups ) {
        
        NetworkHandler.shared.getTrack(field) { [weak self] (response: [String : Any]?) in
            
            guard let items = self?.parseDataFromTracks(response) else {
                onCompletion(nil)
                return
            }
            
            onCompletion(self?.group(tracks: items))
        }
        
    }
    
    private func group(tracks items: [Track]) -> [TrackGroups] {
        var trackGroups     = [TrackGroups]()
        var groupName       = [String]()
        //var items           = items
        
        //MARK:- TODO: Expensive operation
        for (_, value) in items.enumerated() {
            
            //MARK: TODO: this one too....
            let filtered = items.filter { (track: Track) -> Bool in
                return track.collectionName == value.collectionName
            }
            
            // Check collection name if NO record, the just skip it.
            guard let collectionName: String = filtered.first?.collectionName else { continue }
            
            //MARK: TODO: To avoid this, we have to update `items` to avoid search elements that we already filtered.
            if !groupName.contains(collectionName) {
                trackGroups.append(TrackGroups(tracks: filtered, filter: collectionName))
                groupName.append(collectionName)
            } else {
                // print("Duplicate information: \(collectionName)")
            }
        }
        
        return trackGroups
    }
    
    private func parseDataFromTracks(_ response: [String : Any]? ) -> [Track]? {
        
        // Verify contract
        guard let tracks = response?["results"] as? [[String: Any]] else { return nil }
        
        print("tracks found: \(tracks.count)")
        
        var _items = [Track]()
        // Go through each item.
        for (_, value) in tracks.enumerated() {
            
            var track = Track()
            
            // read the data and get the field -trackName
            if let name = value["trackName"] as? String {
                track.trackName = name
            }
            
            if let imageUrl = value["artworkUrl100"] as? String {
                track.artworkUrl = imageUrl
            }
            
            if let colectionName = value["collectionName"] as? String {
                track.collectionName = colectionName
            }
            
            if let previewUrl = value["previewUrl"] as? String {
                track.previewUrl = previewUrl
            }
            
            _items.append(track)
        }
        
        return _items
    }
    
}
