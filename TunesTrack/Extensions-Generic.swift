//
//  Extensions-Generic.swift
//  TunesTrack
//
//  Created by Cruz, Adrian (Contractor) on 10/4/17.
//  Copyright © 2017 :]. All rights reserved.
//

import UIKit

private enum ViewIdentifiers: Int {
    case spinner
    case bgSpinner
    
    func index() -> Int {
        let base = 1234567890
        return base + self.hashValue
    }
}

extension UIViewController {
    
    func addSpinner() {
        let bgSpinner = UIView(frame: self.view.bounds)
        bgSpinner.tag = ViewIdentifiers.bgSpinner.index()
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        spinner.tag = ViewIdentifiers.spinner.index()
        view.addSubview(spinner)
        view.addSubview(bgSpinner)
        
        bgSpinner.backgroundColor = UIColor.gray.withAlphaComponent(0.50)
        
        spinner.frame = self.view.bounds
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        spinner.startAnimating()
    }
    
    func removeSpinner() {
        let spinner = self.view.viewWithTag(ViewIdentifiers.spinner.index())
        spinner?.removeFromSuperview()
        
        let bgSpinner = self.view.viewWithTag(ViewIdentifiers.bgSpinner.index())
        bgSpinner?.removeFromSuperview()
    }
}
