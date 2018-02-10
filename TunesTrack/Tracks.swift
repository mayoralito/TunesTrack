//
//  Tracks.swift
//  TunesTrack
//
//  Created by Cruz, Adrian (Contractor) on 10/3/17.
//  Copyright © 2017 :]. All rights reserved.
//

import Foundation

///
struct Track: Hashable {
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    static func ==(lhs: Track, rhs: Track) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    private var scalarArray: [UInt32] = []
    
    var hashValue: Int {
        return self.scalarArray.reduce(5381) {
            ($0 << 5) &+ $0 &+ Int($1)
        }
    }
    
    // END: Hashable thing
    
    var trackName: String
    var artworkUrl: String
    var collectionName: String
    var previewUrl: String?
    
    init() {
        trackName = ""
        artworkUrl = ""
        collectionName = ""
    }
}

struct TrackGroups: Hashable {
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    static func ==(lhs: TrackGroups, rhs: TrackGroups) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    private var scalarArray: [UInt32] = []
    
    var hashValue: Int {
        return self.scalarArray.reduce(5381) {
            ($0 << 5) &+ $0 &+ Int($1)
        }
    }
    
    // END: Hashable thing
    
    var tracks: [Track]
    var filter: String
    
    init(tracks: [Track], filter: String) {
        self.tracks = tracks
        self.filter = filter
    }
}
