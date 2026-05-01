//
//  SideBarItemsCVCell.swift
//  Invoice Maker App
//
//  Created by Dev-Mac on 2026-04-29.
//

import Foundation
import Cocoa

class SideBarItemsCVCell: NSCollectionViewItem {

    static let identifier = NSUserInterfaceItemIdentifier("SideBarItemsCVCell")
    
    var titleText : NSTextField!
    var titleImage = NSImageView()
    var sideView = NSView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.clear.cgColor

        setupUI()
    }

    private func setupUI() {
        
        titleImage.image = .dashboardIcon
        titleImage.imageScaling = .scaleProportionallyDown
        titleImage.image?.isTemplate = true
        self.view.addSubview(titleImage)
        
        titleImage.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: self.view.leadingAnchor, paddingLeft: 20, right: nil, paddingRight: 0, width: 20, height: 20)
        titleImage.center(centerX: nil, centerY: self.view.centerYAnchor)
        
        // ----------------------------------
        
        titleText = NSTextField(labelWithString: "Dashboard")
        titleText.font = .systemFont(ofSize: 16, weight: .semibold)
        titleText.textColor = .textGray
        self.view.addSubview(titleText)
        
        titleText.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: titleImage.trailingAnchor, paddingLeft: 20, right: nil, paddingRight: 0, width: 0, height: 0)
        titleText.center(centerX: nil, centerY: self.view.centerYAnchor)
        
        // ----------------------------------
        
        sideView.wantsLayer = true
        sideView.isHidden = true
        sideView.layer?.backgroundColor = NSColor.textBlue.cgColor
        self.view.addSubview(sideView)
        
        sideView.anchor(top: self.view.topAnchor, paddingTop: 0, bottom: self.view.bottomAnchor, paddingBottom: 0, left: nil, paddingLeft: 0, right: self.view.trailingAnchor, paddingRight: 0, width: 5, height: 0)
        
    }
    
    override var isSelected: Bool {
        didSet {
            self.titleText.textColor = isSelected ? .textBlue : .textGray
            self.titleImage.contentTintColor = isSelected ? .textBlue : .textGray
            self.view.wantsLayer = true
            self.view.layer?.backgroundColor = isSelected ? NSColor.textBlue.withAlphaComponent(0.2).cgColor : NSColor.clear.cgColor
            self.sideView.isHidden = !isSelected
        }
    }

}
