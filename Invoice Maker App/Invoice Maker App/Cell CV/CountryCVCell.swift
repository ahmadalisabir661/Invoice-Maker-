//
//  CountryCVCell.swift
//  Invoice Maker App
//
//  Created by Dev-Mac on 2026-05-29.
//

import Foundation
import Cocoa

class CountryCVCell : NSCollectionViewItem {
    
    weak var delegate : InvoiceItemCVCellDelegate?
    static let identifier = NSUserInterfaceItemIdentifier("CountryCVCell")
    
    var titleText: NSTextField!
    var checkMark = NSImageView()

    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.clear.cgColor
        self.view.layer?.cornerRadius = 8
        
        // ----------------------------------
       
        titleText = NSTextField(labelWithString: "Pakistan")
        titleText.font = .systemFont(ofSize: 16, weight: .regular)
        titleText.textColor = .white
        self.view.addSubview(titleText)
        
        titleText.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: self.view.leadingAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 0)
        titleText.center(centerX: nil, centerY: self.view.centerYAnchor)
        
        // ----------------------------------
        
//        let image = NSImage(systemSymbolName: "checkmark", accessibilityDescription: nil)
        
        checkMark.image = .checkmark
        checkMark.image?.isTemplate = true
        checkMark.contentTintColor = .white
        checkMark.isHidden = true
        checkMark.imageScaling = .scaleAxesIndependently
        self.view.addSubview(checkMark)
        
        checkMark.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: self.view.trailingAnchor, paddingRight: 10, width: 15, height: 15)
        checkMark.center(centerX: nil, centerY: self.view.centerYAnchor)

        // ----------------------------------
    }
    
    override var isSelected: Bool {
        didSet {
            self.view.layer?.backgroundColor = isSelected ? NSColor.blueBorder.cgColor : NSColor.clear.cgColor
            self.checkMark.isHidden = isSelected ? false : true
        }
    }
    
}
