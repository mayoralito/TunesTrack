//
//  PopUpView.swift
//  TunesTrack
//
//  Created by Cruz, Adrian (Contractor) on 10/5/17.
//  Copyright © 2017 :]. All rights reserved.
//

import UIKit

class PopUpView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.blue.withAlphaComponent(0.85)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let w = rect.width
        let h = rect.height
        let c = UIColor.green
        
        let dRect = CGRect(x: (w * 0.25), y: (h * 0.25), width: (w * 0.5), height: (h * 0.5))
        let path = UIBezierPath(rect: dRect)
        
        c.set()
        path.stroke()
        
        if let superview = self.superview {
            self.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
            self.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
//            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }
    
    override func layoutSubviews() {
//        if let superview = self.superview {
//            self.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
//            self.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
//        }
    }
 

}

