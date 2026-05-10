//
//  CustomPlusView.swift
//  Invoice Maker App
//
//  Created by Dev-Mac on 2026-05-10.
//

import Foundation
import Cocoa

class CustomPlusView : NSView {
    
    var imageView = NSImageView()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        
        imageView.image = NSImage(systemSymbolName: "plus", accessibilityDescription: nil)
        imageView.imageScaling = .scaleProportionallyUpOrDown
        imageView.contentTintColor = .primaryNavy
        self.addSubview(imageView)
        
        imageView.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 12, height: 12)
        imageView.center(centerX: self.centerXAnchor, centerY: self.centerYAnchor)
    }
    
}
