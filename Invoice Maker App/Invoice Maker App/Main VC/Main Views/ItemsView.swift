//
//  ItemsView.swift
//  Invoice Maker App
//
//  Created by Dev-Mac on 2026-05-05.
//

import Foundation
import Cocoa
 
class ItemsView : NSView {
    
    var titleText : NSTextField!
    var itemAddingView = NSView()
    
    var itemNameLabel : NSTextField!
    var itemNameLabelField = NSTextField()
    var itemCodeLabel : NSTextField!
    var itemCodeLabelField = NSTextField()
    var itemQuantityLabel : NSTextField!
    var itemQuantityLabelField = NSTextField()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.mainBG.cgColor
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        
        titleText = NSTextField(labelWithString: "Add Item")
        titleText.font = .systemFont(ofSize: 30, weight: .medium)
        titleText.textColor = .white
        self.addSubview(titleText)
        
        titleText.anchor(top: self.topAnchor, paddingTop: 30, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        titleText.center(centerX: self.centerXAnchor, centerY: nil)
        
        // ----------------------------------
        
        itemAddingView.wantsLayer = true
        itemAddingView.layer?.borderColor = NSColor.white.withAlphaComponent(0.5).cgColor
        itemAddingView.layer?.borderWidth = 1
        itemAddingView.layer?.cornerRadius = 20
        itemAddingView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(itemAddingView)
        
        NSLayoutConstraint.activate([
            itemAddingView.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 20),
            itemAddingView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            itemAddingView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            itemAddingView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6)
        ])
        
        // ----------------------------------
        
        itemNameLabel = NSTextField(labelWithString: "Item Name")
        itemNameLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        itemNameLabel.textColor = .white
        itemAddingView.addSubview(itemNameLabel)
        
        itemNameLabel.anchor(top: itemAddingView.topAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: itemAddingView.leadingAnchor, paddingLeft: 20, right: nil, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        itemNameLabelField.placeholderString = "Enter item name"
        itemNameLabelField.font = .systemFont(ofSize: 16, weight: .medium)
        itemNameLabelField.textColor = .white
        itemNameLabelField.backgroundColor = .clear
        itemNameLabelField.isBezeled = false
        itemNameLabelField.lineBreakMode = .byTruncatingTail
        itemNameLabelField.layer?.borderWidth = 1
        itemNameLabelField.layer?.borderColor = NSColor.white.withAlphaComponent(0.5).cgColor
        itemAddingView.addSubview(itemNameLabelField)
        
        itemNameLabelField.anchor(top: itemNameLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: itemNameLabel.leadingAnchor, paddingLeft: 0, right: itemAddingView.centerXAnchor, paddingRight: 10, width: 0, height: 25)
        
        // ----------------------------------
        
        itemCodeLabel = NSTextField(labelWithString: "Item Code")
        itemCodeLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        itemCodeLabel.textColor = .white
        itemAddingView.addSubview(itemCodeLabel)
        
        itemCodeLabel.anchor(top: itemNameLabel.topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: itemAddingView.centerXAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        itemCodeLabelField.placeholderString = "Enter item code"
        itemCodeLabelField.font = .systemFont(ofSize: 16, weight: .medium)
        itemCodeLabelField.textColor = .white
        itemCodeLabelField.backgroundColor = .clear
        itemCodeLabelField.isBezeled = false
        itemCodeLabelField.lineBreakMode = .byTruncatingTail
        itemCodeLabelField.layer?.borderWidth = 1
        itemCodeLabelField.layer?.borderColor = NSColor.white.withAlphaComponent(0.5).cgColor
        itemAddingView.addSubview(itemCodeLabelField)
        
        itemCodeLabelField.anchor(top: itemCodeLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: itemCodeLabel.leadingAnchor, paddingLeft: 0, right: itemAddingView.trailingAnchor, paddingRight: 20, width: 0, height: 25)
        
        // ----------------------------------
        
        itemQuantityLabel = NSTextField(labelWithString: "Item Quantity")
        itemQuantityLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        itemQuantityLabel.textColor = .white
        itemAddingView.addSubview(itemQuantityLabel)
        
        itemQuantityLabel.anchor(top: itemCodeLabelField.bottomAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: itemAddingView.leadingAnchor, paddingLeft: 20, right: nil, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        itemQuantityLabelField.placeholderString = "Enter item quantity"
        itemQuantityLabelField.font = .systemFont(ofSize: 16, weight: .medium)
        itemQuantityLabelField.textColor = .white
        itemQuantityLabelField.backgroundColor = .clear
        itemQuantityLabelField.isBezeled = false
        itemQuantityLabelField.lineBreakMode = .byTruncatingTail
        itemQuantityLabelField.layer?.borderWidth = 1
        itemQuantityLabelField.layer?.borderColor = NSColor.white.withAlphaComponent(0.5).cgColor
        itemAddingView.addSubview(itemQuantityLabelField)
        
        itemQuantityLabelField.anchor(top: itemQuantityLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: itemQuantityLabel.leadingAnchor, paddingLeft: 0, right: itemAddingView.centerXAnchor, paddingRight: 10, width: 0, height: 25)
        
        // ----------------------------------
        
    }
        
}

extension ItemsView {
   
}

extension ItemsView: NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: NSCollectionView,
                        itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let cell = collectionView.makeItem(withIdentifier: InvoiceItemCVCell.identifier,for: indexPath) as! InvoiceItemCVCell
        return cell
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        
        return NSSize(width: collectionView.frame.size.width, height: 50)
    }
    
}
