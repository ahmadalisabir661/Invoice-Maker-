//
//  BtnView.swift
//  Invoice Maker App
//
//  Created by Dev-Mac on 2026-05-01.
//

import Foundation
import Cocoa

class BtnView : NSView {
    
    var titleText : NSTextField!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        
        titleText = NSTextField(labelWithString: "")
//        titleText.font = .systemFont(ofSize: 16, weight: .regular)
        titleText.textColor = .textBlue
        self.addSubview(titleText)
        
        titleText.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: self.leadingAnchor, paddingLeft: 0, right: self.trailingAnchor, paddingRight: 0, width: 0, height: 0)
        titleText.center(centerX: nil, centerY: self.centerYAnchor)
        
        // ----------------------------------
    }
    
}
