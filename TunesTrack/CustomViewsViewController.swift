//
//  CustomViewsViewController.swift
//  TunesTrack
//
//  Created by Cruz, Adrian (Contractor) on 10/5/17.
//  Copyright © 2017 :]. All rights reserved.
//

import UIKit

class CustomViewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.orange
        
        let customPopup = PopUpView(frame: .init(origin: .zero, size: CGSize(width: 100, height: 100)))
        self.view.addSubview(customPopup)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
