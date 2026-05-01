//
//  Invoice View.swift
//  Invoice Maker App
//
//  Created by Dev-Mac on 2026-04-30.
//

import Foundation
import Cocoa
 
class InvoiceView : NSView {
    
    var mainView = NSView()
    
    var titleText : NSTextField!
    
    var invoiceNumber : NSTextField!
    var invoiceLabel : NSTextField!
    var issueDateLabel : NSTextField!
    var issueDate : NSTextField!
    var dueDateLabel : NSTextField!
    var dueDate : NSTextField!
    
    var partition_1 = NSView()
    
    var billToLabel : NSTextField!
    var billToView = NSView()
    var shipToLabel : NSTextField!
    var shipToView = NSView()
    
    let itemsContainer = NSView()
    var descLabel = BtnView()
    var qtyLabel = BtnView()
    var rateLabel = BtnView()
    var amountLabel = BtnView()
    
    var partition_2 = NSView()

    var invoiceItemCV = NSCollectionView()
    
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
        
        mainView.wantsLayer = true
        mainView.layer?.borderColor = NSColor.white.withAlphaComponent(0.5).cgColor
        mainView.layer?.borderWidth = 1
        mainView.layer?.cornerRadius = 20
        mainView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mainView)
        
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            mainView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
        ])
        
        // ----------------------------------
        
        titleText = NSTextField(labelWithString: "Invoice")
        titleText.font = .systemFont(ofSize: 30, weight: .medium)
        titleText.textColor = .textBlue
        self.addSubview(titleText)
        
        titleText.anchor(top: mainView.topAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: mainView.trailingAnchor, paddingRight: 20, width: 0, height: 0)
        
        // ----------------------------------
        
        invoiceNumber = NSTextField(labelWithString: "INV-2024-001")
        invoiceNumber.font = .systemFont(ofSize: 18, weight: .regular)
        invoiceNumber.textColor = .textBlue
        self.addSubview(invoiceNumber)
        
        invoiceNumber.anchor(top: titleText.bottomAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: titleText.trailingAnchor, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        invoiceLabel = NSTextField(labelWithString: "INVOICE NO.")
        invoiceLabel.font = .systemFont(ofSize: 18, weight: .regular)
        invoiceLabel.textColor = .textBlue
        self.addSubview(invoiceLabel)
        
        invoiceLabel.anchor(top: nil, paddingTop: 0, bottom: invoiceNumber.bottomAnchor, paddingBottom: 0, left: nil, paddingLeft: 0, right: invoiceNumber.leadingAnchor, paddingRight: 10, width: 0, height: 0)
        
        // ----------------------------------
        
        issueDate = NSTextField(labelWithString: "INV-2024-001")
        issueDate.font = .systemFont(ofSize: 18, weight: .regular)
        issueDate.textColor = .textBlue
        self.addSubview(issueDate)
        
        issueDate.anchor(top: invoiceNumber.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: titleText.trailingAnchor, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        issueDateLabel = NSTextField(labelWithString: "INVOICE NO.")
        issueDateLabel.font = .systemFont(ofSize: 18, weight: .regular)
        issueDateLabel.textColor = .textBlue
        self.addSubview(issueDateLabel)
        
        issueDateLabel.anchor(top: nil, paddingTop: 0, bottom: issueDate.bottomAnchor, paddingBottom: 0, left: nil, paddingLeft: 0, right: issueDate.leadingAnchor, paddingRight: 10, width: 0, height: 0)
        
        // ----------------------------------
        
        partition_1.wantsLayer = true
        partition_1.layer?.backgroundColor = NSColor.lightGray.cgColor
        self.addSubview(partition_1)
        
        partition_1.anchor(top: issueDateLabel.bottomAnchor, paddingTop: 30, bottom: nil, paddingBottom: 0, left: mainView.leadingAnchor, paddingLeft: 20, right: mainView.trailingAnchor, paddingRight: 20, width: 0, height: 0.5)
        
        // ----------------------------------
        
        billToLabel = NSTextField(labelWithString: "BILL TO")
        billToLabel.font = .systemFont(ofSize: 18, weight: .regular)
        billToLabel.textColor = .textBlue
        self.addSubview(billToLabel)
        
        billToLabel.anchor(top: partition_1.bottomAnchor, paddingTop: 40, bottom: nil, paddingBottom: 0, left: mainView.leadingAnchor, paddingLeft: 20, right: nil, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        billToView.wantsLayer = true
        billToView.layer?.backgroundColor = NSColor.lightGray.withAlphaComponent(0.3).cgColor
        billToView.layer?.cornerRadius = 8
        self.addSubview(billToView)
        
        billToView.anchor(top: billToLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: mainView.leadingAnchor, paddingLeft: 20, right: mainView.centerXAnchor, paddingRight: 10, width: 0, height: 150)
        
        // ----------------------------------
        
        shipToLabel = NSTextField(labelWithString: "SHIP TO")
        shipToLabel.font = .systemFont(ofSize: 18, weight: .regular)
        shipToLabel.textColor = .textBlue
        self.addSubview(shipToLabel)
        
        shipToLabel.anchor(top: billToLabel.topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: mainView.centerXAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        shipToView.wantsLayer = true
        shipToView.layer?.backgroundColor = NSColor.lightGray.withAlphaComponent(0.3).cgColor
        shipToView.layer?.cornerRadius = 8
        self.addSubview(shipToView)
        
        shipToView.anchor(top: billToLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: mainView.centerXAnchor, paddingLeft: 10, right: mainView.trailingAnchor, paddingRight: 20, width: 0, height: 150)
        
        // ----------------------------------
        
        itemsContainer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(itemsContainer)
        
        NSLayoutConstraint.activate([
            itemsContainer.topAnchor.constraint(equalTo: billToView.bottomAnchor, constant: 30),
            itemsContainer.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            itemsContainer.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            itemsContainer.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // ----------------------------------
        
        descLabel.titleText.stringValue = "DESCRIPTION"
        descLabel.titleText.font = .systemFont(ofSize: 16, weight: .regular)
        descLabel.wantsLayer = true
//        descLabel.layer?.backgroundColor = NSColor.red.withAlphaComponent(0.3).cgColor
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        itemsContainer.addSubview(descLabel)
        
        NSLayoutConstraint.activate([
            descLabel.topAnchor.constraint(equalTo: itemsContainer.topAnchor),
            descLabel.leadingAnchor.constraint(equalTo: itemsContainer.leadingAnchor),
            descLabel.widthAnchor.constraint(equalTo: itemsContainer.widthAnchor, multiplier: 0.36),
            descLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // ----------------------------------
        
        qtyLabel.titleText.stringValue = "QTY"
        qtyLabel.titleText.font = .systemFont(ofSize: 16, weight: .regular)
        qtyLabel.titleText.alignment = .center
        qtyLabel.wantsLayer = true
//        qtyLabel.layer?.backgroundColor = NSColor.yellow.withAlphaComponent(0.3).cgColor
        qtyLabel.translatesAutoresizingMaskIntoConstraints = false
        itemsContainer.addSubview(qtyLabel)
        
        NSLayoutConstraint.activate([
            qtyLabel.topAnchor.constraint(equalTo: itemsContainer.topAnchor),
            qtyLabel.leadingAnchor.constraint(equalTo: descLabel.trailingAnchor),
            qtyLabel.widthAnchor.constraint(equalTo: itemsContainer.widthAnchor, multiplier: 0.18),
            qtyLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // ----------------------------------
        
        rateLabel.titleText.stringValue = "RATE"
        rateLabel.titleText.font = .systemFont(ofSize: 16, weight: .regular)
        rateLabel.titleText.alignment = .right
        rateLabel.wantsLayer = true
//        rateLabel.layer?.backgroundColor = NSColor.red.withAlphaComponent(0.3).cgColor
        rateLabel.translatesAutoresizingMaskIntoConstraints = false
        itemsContainer.addSubview(rateLabel)
        
        NSLayoutConstraint.activate([
            rateLabel.topAnchor.constraint(equalTo: itemsContainer.topAnchor),
            rateLabel.leadingAnchor.constraint(equalTo: qtyLabel.trailingAnchor),
            rateLabel.widthAnchor.constraint(equalTo: itemsContainer.widthAnchor, multiplier: 0.23),
            rateLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // ----------------------------------
        
        amountLabel.titleText.stringValue = "AMOUNT"
        amountLabel.titleText.font = .systemFont(ofSize: 16, weight: .regular)
        amountLabel.titleText.alignment = .right
        amountLabel.wantsLayer = true
//        amountLabel.layer?.backgroundColor = NSColor.yellow.withAlphaComponent(0.3).cgColor
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        itemsContainer.addSubview(amountLabel)
        
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: itemsContainer.topAnchor),
            amountLabel.leadingAnchor.constraint(equalTo: rateLabel.trailingAnchor),
            amountLabel.widthAnchor.constraint(equalTo: itemsContainer.widthAnchor, multiplier: 0.23),
            amountLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // ----------------------------------
        
        partition_2.wantsLayer = true
        partition_2.layer?.backgroundColor = NSColor.lightGray.cgColor
        self.addSubview(partition_2)
        
        partition_2.anchor(top: itemsContainer.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: itemsContainer.leadingAnchor, paddingLeft: 0, right: itemsContainer.trailingAnchor, paddingRight: 0, width: 0, height: 0.5)
        
        // ----------------------------------
        
        
        let layout = NSCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        invoiceItemCV.collectionViewLayout = layout
        invoiceItemCV.dataSource = self
        invoiceItemCV.delegate = self
        invoiceItemCV.isSelectable = true
        invoiceItemCV.allowsEmptySelection = false
        invoiceItemCV.register(InvoiceItemCVCell.self, forItemWithIdentifier: InvoiceItemCVCell.identifier)
        invoiceItemCV.backgroundColors = [.clear]
        
        let scrollView = NSScrollView()
        scrollView.documentView = invoiceItemCV
        scrollView.hasVerticalScroller = true
        scrollView.drawsBackground = false
        
        addSubview(scrollView)
        
        scrollView.anchor(top: partition_2.bottomAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: itemsContainer.leadingAnchor, paddingLeft: 0, right: itemsContainer.trailingAnchor, paddingRight: 0, width: 0, height: 200)
        
        // ----------------------------------
        
    }
    
}

extension InvoiceView: NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout {
    
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
