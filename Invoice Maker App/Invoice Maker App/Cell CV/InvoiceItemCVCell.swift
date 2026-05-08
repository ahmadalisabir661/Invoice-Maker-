//
//  InvoiceItemCVCell.swift
//  Invoice Maker App
//
//  Created by Dev-Mac on 2026-05-01.
//

import Foundation
import Cocoa

class InvoiceItemCVCell : NSCollectionViewItem {
    
    static let identifier = NSUserInterfaceItemIdentifier("InvoiceItemCVCell")
    
    var descView = NSView()
    var descLabel : NSTextField!
    var descCoLabel : NSTextField!
    var qtyLabel = BtnView()
    var rateLabel = BtnView()
    var amountLabel = BtnView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        
        descView.wantsLayer = true
//        descView.layer?.backgroundColor = NSColor.red.withAlphaComponent(0.3).cgColor
        descView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(descView)
        
        NSLayoutConstraint.activate([
            descView.topAnchor.constraint(equalTo: self.view.topAnchor),
            descView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            descView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            descView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.36),
        ])
        
        // ----------------------------------
        
        descLabel = NSTextField(labelWithString: "UI/UX Prototyping")
        descLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descLabel.alignment = .left
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descView.addSubview(descLabel)
        
        NSLayoutConstraint.activate([
            descLabel.topAnchor.constraint(equalTo: descView.topAnchor),
            descLabel.leadingAnchor.constraint(equalTo: descView.leadingAnchor),
            descLabel.trailingAnchor.constraint(equalTo: descView.trailingAnchor),
        ])
        
        // ----------------------------------
        
        descCoLabel = NSTextField(labelWithString: "Figma Interactive prototype - Milestone 1")
        descCoLabel.font = .systemFont(ofSize: 12, weight: .regular)
        descCoLabel.alignment = .left
        descCoLabel.maximumNumberOfLines = 0
        descCoLabel.lineBreakMode = .byWordWrapping
        descCoLabel.translatesAutoresizingMaskIntoConstraints = false
        descView.addSubview(descCoLabel)
        
        NSLayoutConstraint.activate([
            descCoLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 3),
            descCoLabel.leadingAnchor.constraint(equalTo: descView.leadingAnchor),
            descCoLabel.trailingAnchor.constraint(equalTo: descView.trailingAnchor),
        ])
        
        // ----------------------------------
        
        qtyLabel.titleText.stringValue = "40"
        qtyLabel.titleText.font = .systemFont(ofSize: 14, weight: .regular)
        qtyLabel.titleText.alignment = .center
        qtyLabel.wantsLayer = true
//        qtyLabel.layer?.backgroundColor = NSColor.yellow.withAlphaComponent(0.3).cgColor
        qtyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(qtyLabel)
        
        NSLayoutConstraint.activate([
            qtyLabel.topAnchor.constraint(equalTo: self.view.topAnchor),
            qtyLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            qtyLabel.leadingAnchor.constraint(equalTo: descView.trailingAnchor),
            qtyLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.18),
        ])
        
        // ----------------------------------
        
        rateLabel.titleText.stringValue = "$120.232"
        rateLabel.titleText.font = .systemFont(ofSize: 14, weight: .regular)
        rateLabel.titleText.alignment = .right
        rateLabel.wantsLayer = true
//        rateLabel.layer?.backgroundColor = NSColor.red.withAlphaComponent(0.3).cgColor
        rateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(rateLabel)
        
        NSLayoutConstraint.activate([
            rateLabel.topAnchor.constraint(equalTo: self.view.topAnchor),
            rateLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            rateLabel.leadingAnchor.constraint(equalTo: qtyLabel.trailingAnchor),
            rateLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.23),
        ])
        
        // ----------------------------------
        
        amountLabel.titleText.stringValue = "$12,500"
        amountLabel.titleText.font = .systemFont(ofSize: 14, weight: .regular)
        amountLabel.titleText.alignment = .right
        amountLabel.wantsLayer = true
//        amountLabel.layer?.backgroundColor = NSColor.yellow.withAlphaComponent(0.3).cgColor
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(amountLabel)
        
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: self.view.topAnchor),
            amountLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            amountLabel.leadingAnchor.constraint(equalTo: rateLabel.trailingAnchor),
            amountLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.23),
        ])
        
        
    }
    
}
