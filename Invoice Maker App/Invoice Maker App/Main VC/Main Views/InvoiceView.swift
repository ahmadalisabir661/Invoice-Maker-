//
//  Invoice View.swift
//  Invoice Maker App
//
//  Created by Dev-Mac on 2026-04-30.
//

import Foundation
import Cocoa
 import UniformTypeIdentifiers

struct AmountModel {
    let qty : String
    let price : String
    let amount : String
}

class InvoiceView : BaseView, NSTextFieldDelegate {
    
    let scrollView = NSScrollView()
    let contentView = NSView()

    var mainView = NSView()
    
    var titleText : NSTextField!
    var brandNameTitle = NSTextField()
    
    var yourNameField = NSTextField()
    var yourAddressField = NSTextField()
    var yourCityStateField = NSTextField()
    var yourCountryLabel : NSTextField!
    
    var billTolabel : NSTextField!
    var clearView = NSView()
    var clearText : NSTextField!
    
    var billNameField = NSTextField()
    var billAddressField = NSTextField()
    var billCityStateField = NSTextField()
    var billCountryLabel : NSTextField!
    
    var invoiceNoLabel : NSTextField!
    var invoiceDateLabel : NSTextField!
    var invoiceDate : NSTextField!
    var dueDateLabel : NSTextField!
    var dueDate : NSTextField!
    var invoiceNumberField = NSTextField()
    
    var partition_1 = NSView()
    
    let itemsContainer = NSView()
    var descLabel = BtnView()
    var qtyLabel = BtnView()
    var rateLabel = BtnView()
    var amountLabel = BtnView()
    
    var partition_2 = NSView()

    var invoiceItemCV = NSCollectionView()
    let itemScrollView = NSScrollView()
    var plusIcon = CustomPlusView()
    var addNewItemlabel : NSTextField!
    var borderCV = NSView()
    
    var subTotalAmout = BtnView()
    var subTotalLabel : NSTextField!
    var taxAmout = NSTextField()
    var taxLabel : NSTextField!
    var totalAmout = BtnView()
    var totalLabel : NSTextField!
    
    var partition_3 = NSView()
    
    var itemScrollViewConstraint : NSLayoutConstraint!
    let notesTextView = NSTextView()

    var invoiceItemCVList : [AmountModel] = [
        AmountModel(qty: "", price: "", amount: "")
    ]
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.mainBG.cgColor
        setupScrollView()
        headerSection()
        collectionViewSection()
        footerSection()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupScrollView()
        headerSection()
        collectionViewSection()
        footerSection()
    }
    
    func setupScrollView() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        scrollView.drawsBackground = false
        self.addSubview(scrollView)

        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.documentView = contentView

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.contentView.widthAnchor),
        ])
       
    }
    
    func headerSection() {
        
        mainView.wantsLayer = true
        mainView.layer?.borderColor = NSColor.white.withAlphaComponent(0.5).cgColor
        mainView.layer?.borderWidth = 1
        mainView.layer?.cornerRadius = 20
        mainView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainView)
        
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            mainView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
        ])
        
        // ----------------------------------
        
        titleText = NSTextField(labelWithString: "INVOICE")
        titleText.font = .systemFont(ofSize: 35, weight: .regular)
        titleText.textColor = .white
        contentView.addSubview(titleText)
        
        titleText.anchor(top: mainView.topAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: mainView.trailingAnchor, paddingRight: 20, width: 0, height: 0)
        
        // ----------------------------------
        
        invoiceNoLabel = NSTextField(labelWithString: "Invoice#")
        invoiceNoLabel.font = .systemFont(ofSize: 16, weight: .regular)
        invoiceNoLabel.textColor = .white
        contentView.addSubview(invoiceNoLabel)
        
        invoiceNoLabel.anchor(top: nil, paddingTop: 15, bottom: nil, paddingBottom: 0, left: mainView.leadingAnchor, paddingLeft: 20, right: nil, paddingRight: 0, width: 0, height: 0)
        invoiceNoLabel.center(centerX: nil, centerY: titleText.centerYAnchor)
                
        // ----------------------------------
        
        invoiceNumberField.placeholderString = "Click to Enter"
        invoiceNumberField.font = .systemFont(ofSize: 16, weight: .regular)
        invoiceNumberField.textColor = .white
        invoiceNumberField.backgroundColor = .clear
        invoiceNumberField.isBezeled = false
        invoiceNumberField.isBordered = false
        invoiceNumberField.focusRingType = .none
        invoiceNumberField.lineBreakMode = .byTruncatingTail
        contentView.addSubview(invoiceNumberField)
        
        invoiceNumberField.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: invoiceNoLabel.trailingAnchor, paddingLeft: 70, right: mainView.centerXAnchor, paddingRight: 10, width: 0, height: 17)
        invoiceNumberField.center(centerX: nil, centerY: invoiceNoLabel.centerYAnchor)
        
        // ----------------------------------
        
        invoiceDateLabel = NSTextField(labelWithString: "Invoice Date")
        invoiceDateLabel.font = .systemFont(ofSize: 16, weight: .regular)
        invoiceDateLabel.textColor = .white
        contentView.addSubview(invoiceDateLabel)
        
        invoiceDateLabel.anchor(top: invoiceNoLabel.bottomAnchor, paddingTop: 15, bottom: nil, paddingBottom: 0, left: invoiceNoLabel.leadingAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        invoiceDate = NSTextField(labelWithString: "02/02/2005")
        invoiceDate.font = .systemFont(ofSize: 16, weight: .regular)
        invoiceDate.textColor = .white
        contentView.addSubview(invoiceDate)
        
        invoiceDate.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: invoiceNumberField.leadingAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        invoiceDate.center(centerX: nil, centerY: invoiceDateLabel.centerYAnchor)
        
        // ----------------------------------
        
        dueDateLabel = NSTextField(labelWithString: "Due Date")
        dueDateLabel.font = .systemFont(ofSize: 16, weight: .regular)
        dueDateLabel.textColor = .white
        contentView.addSubview(dueDateLabel)
        
        dueDateLabel.anchor(top: invoiceDateLabel.bottomAnchor, paddingTop: 15, bottom: nil, paddingBottom: 0, left: invoiceNoLabel.leadingAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        dueDate = NSTextField(labelWithString: "02/02/2005")
        dueDate.font = .systemFont(ofSize: 16, weight: .regular)
        dueDate.textColor = .white
        contentView.addSubview(dueDate)
        
        dueDate.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: invoiceNumberField.leadingAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        dueDate.center(centerX: nil, centerY: dueDateLabel.centerYAnchor)
                
        // ----------------------------------
        
        brandNameTitle.stringValue = "AK Khan"
        brandNameTitle.font = .systemFont(ofSize: 25, weight: .medium)
        brandNameTitle.textColor = .white
        brandNameTitle.backgroundColor = .clear
        brandNameTitle.isBezeled = false
        brandNameTitle.isBordered = false
        brandNameTitle.focusRingType = .none
        brandNameTitle.lineBreakMode = .byTruncatingTail
        contentView.addSubview(brandNameTitle)
        
        brandNameTitle.anchor(top: dueDate.bottomAnchor, paddingTop: 60, bottom: nil, paddingBottom: 0, left: mainView.leadingAnchor, paddingLeft: 20, right: contentView.centerXAnchor, paddingRight: 10, width: 0, height: 26)
                
        // ----------------------------------
        
        yourNameField.placeholderString = "Your Name"
        yourNameField.font = .systemFont(ofSize: 16, weight: .regular)
        yourNameField.textColor = .white
        yourNameField.backgroundColor = .clear
        yourNameField.isBezeled = false
        yourNameField.isBordered = false
        yourNameField.focusRingType = .none
        yourNameField.lineBreakMode = .byTruncatingTail
        contentView.addSubview(yourNameField)
        
        yourNameField.anchor(top: brandNameTitle.bottomAnchor, paddingTop: 15, bottom: nil, paddingBottom: 0, left: mainView.leadingAnchor, paddingLeft: 20, right: contentView.centerXAnchor, paddingRight: 10, width: 0, height: 17)
        
        // ----------------------------------
        
        yourAddressField.placeholderString = "Address"
        yourAddressField.font = .systemFont(ofSize: 16, weight: .regular)
        yourAddressField.textColor = .white
        yourAddressField.backgroundColor = .clear
        yourAddressField.isBezeled = false
        yourAddressField.isBordered = false
        yourAddressField.focusRingType = .none
        yourAddressField.lineBreakMode = .byTruncatingTail
        contentView.addSubview(yourAddressField)
        
        yourAddressField.anchor(top: yourNameField.bottomAnchor, paddingTop: 15, bottom: nil, paddingBottom: 0, left: mainView.leadingAnchor, paddingLeft: 20, right: contentView.centerXAnchor, paddingRight: 10, width: 0, height: 17)
        
        // ----------------------------------
        
        yourCityStateField.placeholderString = "City, State, ZIP/Postal Code"
        yourCityStateField.font = .systemFont(ofSize: 16, weight: .regular)
        yourCityStateField.textColor = .white
        yourCityStateField.backgroundColor = .clear
        yourCityStateField.isBezeled = false
        yourCityStateField.isBordered = false
        yourCityStateField.focusRingType = .none
        yourCityStateField.lineBreakMode = .byTruncatingTail
        contentView.addSubview(yourCityStateField)
        
        yourCityStateField.anchor(top: yourAddressField.bottomAnchor, paddingTop: 15, bottom: nil, paddingBottom: 0, left: mainView.leadingAnchor, paddingLeft: 20, right: contentView.centerXAnchor, paddingRight: 10, width: 0, height: 17)
        
        // ----------------------------------
        
        yourCountryLabel = NSTextField(labelWithString: "Canada")
        yourCountryLabel.font = .systemFont(ofSize: 16, weight: .regular)
        yourCountryLabel.textColor = .white
        contentView.addSubview(yourCountryLabel)
        
        yourCountryLabel.anchor(top: yourCityStateField.bottomAnchor, paddingTop: 15, bottom: nil, paddingBottom: 0, left: yourCityStateField.leadingAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        billTolabel = NSTextField(labelWithString: "Bill To")
        billTolabel.font = .systemFont(ofSize: 25, weight: .medium)
        billTolabel.textColor = .white
        contentView.addSubview(billTolabel)
        
        billTolabel.anchor(top: dueDate.bottomAnchor, paddingTop: 60, bottom: nil, paddingBottom: 0, left: contentView.centerXAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        clearView.wantsLayer = true
        clearView.isHidden = true
        clearView.layer?.backgroundColor = NSColor.systemPink.withAlphaComponent(0.4).cgColor
        clearView.layer?.borderColor = NSColor.systemPink.cgColor
        clearView.layer?.borderWidth = 1
        clearView.layer?.cornerRadius = 5
        contentView.addSubview(clearView)
        
        clearView.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: billTolabel.trailingAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 60, height: 25)
        clearView.center(centerX: nil, centerY: billTolabel.centerYAnchor)
        
        // ----------------------------------
        
        clearText = NSTextField(labelWithString: "Clear")
        clearText.font = .systemFont(ofSize: 14, weight: .regular)
        clearText.textColor = .white
        clearView.addSubview(clearText)
        
        clearText.center(centerX: clearView.centerXAnchor, centerY: clearView.centerYAnchor)
        
        // ----------------------------------
        
        billNameField.placeholderString = "Your Name"
        billNameField.font = .systemFont(ofSize: 16, weight: .regular)
        billNameField.textColor = .white
        billNameField.backgroundColor = .clear
        billNameField.isBezeled = false
        billNameField.isBordered = false
        billNameField.focusRingType = .none
        billNameField.lineBreakMode = .byTruncatingTail
        contentView.addSubview(billNameField)
        
        billNameField.anchor(top: billTolabel.bottomAnchor, paddingTop: 15, bottom: nil, paddingBottom: 0, left: billTolabel.leadingAnchor, paddingLeft: 0, right: titleText.trailingAnchor, paddingRight: 0, width: 0, height: 17)
                
        // ----------------------------------
        
        billAddressField.placeholderString = "Address"
        billAddressField.font = .systemFont(ofSize: 16, weight: .regular)
        billAddressField.textColor = .white
        billAddressField.backgroundColor = .clear
        billAddressField.isBezeled = false
        billAddressField.isBordered = false
        billAddressField.focusRingType = .none
        billAddressField.lineBreakMode = .byTruncatingTail
        contentView.addSubview(billAddressField)
        
        billAddressField.anchor(top: billNameField.bottomAnchor, paddingTop: 15, bottom: nil, paddingBottom: 0, left: billTolabel.leadingAnchor, paddingLeft: 0, right: titleText.trailingAnchor, paddingRight: 0, width: 0, height: 17)
        
        // ----------------------------------
        
        billCityStateField.placeholderString = "City, State, ZIP/Postal Code"
        billCityStateField.font = .systemFont(ofSize: 16, weight: .regular)
        billCityStateField.textColor = .white
        billCityStateField.backgroundColor = .clear
        billCityStateField.isBezeled = false
        billCityStateField.isBordered = false
        billCityStateField.focusRingType = .none
        billCityStateField.lineBreakMode = .byTruncatingTail
        contentView.addSubview(billCityStateField)
        
        billCityStateField.anchor(top: billAddressField.bottomAnchor, paddingTop: 15, bottom: nil, paddingBottom: 0, left: billTolabel.leadingAnchor, paddingLeft: 0, right: titleText.trailingAnchor, paddingRight: 0, width: 0, height: 17)
        
        // ----------------------------------
        
        billCountryLabel = NSTextField(labelWithString: "Canada")
        billCountryLabel.font = .systemFont(ofSize: 16, weight: .regular)
        billCountryLabel.textColor = .white
        contentView.addSubview(billCountryLabel)
        
        billCountryLabel.anchor(top: billCityStateField.bottomAnchor, paddingTop: 15, bottom: nil, paddingBottom: 0, left: billCityStateField.leadingAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
                
        // ----------------------------------
        
        partition_1.wantsLayer = true
        partition_1.layer?.backgroundColor = NSColor.lightGray.cgColor
        contentView.addSubview(partition_1)
        
        partition_1.anchor(top: yourCountryLabel.bottomAnchor, paddingTop: 30, bottom: nil, paddingBottom: 0, left: mainView.leadingAnchor, paddingLeft: 20, right: mainView.trailingAnchor, paddingRight: 20, width: 0, height: 0.5)
        
        // ----------------------------------
    }
    
    func collectionViewSection() {
        
        itemsContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(itemsContainer)
        
        NSLayoutConstraint.activate([
            itemsContainer.topAnchor.constraint(equalTo: partition_1.bottomAnchor, constant: 10),
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
            descLabel.widthAnchor.constraint(equalTo: itemsContainer.widthAnchor, multiplier: 0.46),
            descLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // ----------------------------------
        
        qtyLabel.titleText.stringValue = "QTY"
        qtyLabel.titleText.font = .systemFont(ofSize: 16, weight: .regular)
        qtyLabel.titleText.alignment = .right
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
            rateLabel.widthAnchor.constraint(equalTo: itemsContainer.widthAnchor, multiplier: 0.18),
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
            amountLabel.widthAnchor.constraint(equalTo: itemsContainer.widthAnchor, multiplier: 0.18),
            amountLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // ----------------------------------
        
        partition_2.wantsLayer = true
        partition_2.layer?.backgroundColor = NSColor.lightGray.cgColor
        contentView.addSubview(partition_2)
        
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
        
        itemScrollView.documentView = invoiceItemCV
        itemScrollView.hasVerticalScroller = true
        itemScrollView.drawsBackground = false
        itemScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(itemScrollView)
        
        itemScrollViewConstraint = itemScrollView.heightAnchor.constraint(equalToConstant: 60)
        
        NSLayoutConstraint.activate([
            itemScrollView.topAnchor.constraint(equalTo: partition_2.bottomAnchor, constant: 10),
            itemScrollView.leadingAnchor.constraint(equalTo: itemsContainer.leadingAnchor),
            itemScrollView.trailingAnchor.constraint(equalTo: itemsContainer.trailingAnchor),
//            itemScrollView.heightAnchor.constraint(equalToConstant: 60)
            itemScrollViewConstraint,
        ])
        
        // ----------------------------------
        
        plusIcon.wantsLayer = true
        plusIcon.layer?.backgroundColor = NSColor.lightGray.cgColor
        plusIcon.layer?.cornerRadius = 18 / 2
        contentView.addSubview(plusIcon)
        
        plusIcon.addGestureRecognizer(NSClickGestureRecognizer(target: self, action: #selector(addNewItem)))
        
        plusIcon.anchor(top: itemScrollView.bottomAnchor, paddingTop: 15, bottom: nil, paddingBottom: 0, left: itemScrollView.leadingAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 18, height: 18)
        
        // ----------------------------------
        
        addNewItemlabel = NSTextField(labelWithString: "Add New Item")
        addNewItemlabel.font = .systemFont(ofSize: 16, weight: .regular)
        addNewItemlabel.textColor = .textBlue
        contentView.addSubview(addNewItemlabel)
        
        addNewItemlabel.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: plusIcon.trailingAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 0)
        addNewItemlabel.center(centerX: nil, centerY: plusIcon.centerYAnchor)
        
        // ----------------------------------
        
        borderCV.wantsLayer = true
        borderCV.layer?.backgroundColor = NSColor.lightGray.cgColor
        contentView.addSubview(borderCV)
        
        borderCV.anchor(top: plusIcon.bottomAnchor, paddingTop: 15, bottom: nil, paddingBottom: 0, left: itemsContainer.leadingAnchor, paddingLeft: 0, right: itemsContainer.trailingAnchor, paddingRight: 0, width: 0, height: 0.5)
        
        // ----------------------------------
    }
    
    func footerSection() {
        
        subTotalLabel = NSTextField(labelWithString: "Subtotal")
        subTotalLabel.font = .systemFont(ofSize: 18, weight: .regular)
        subTotalLabel.textColor = .textBlue
        contentView.addSubview(subTotalLabel)
        
//        subTotalLabel.anchor(top: nil, paddingTop: 0, bottom: subTotalAmout.bottomAnchor, paddingBottom: 0, left: nil, paddingLeft: 0, right: subTotalAmout.leadingAnchor, paddingRight: 20, width: 0, height: 0)
        subTotalLabel.anchor(top: borderCV.bottomAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: self.centerXAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        subTotalAmout.titleText.stringValue = "0"
        subTotalAmout.titleText.font = .systemFont(ofSize: 18, weight: .regular)
        subTotalAmout.titleText.textColor = .textBlue
        subTotalAmout.titleText.alignment = .right
        subTotalAmout.wantsLayer = true
//        subTotalAmout.layer?.backgroundColor = NSColor.red.withAlphaComponent(0.3).cgColor
        contentView.addSubview(subTotalAmout)
        
        subTotalAmout.anchor(top: borderCV.bottomAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: subTotalLabel.trailingAnchor, paddingLeft: 10, right: titleText.trailingAnchor, paddingRight: 0, width: 0, height: 20)
        
        // ----------------------------------
        
        taxLabel = NSTextField(labelWithString: "Tax")
        taxLabel.font = .systemFont(ofSize: 18, weight: .regular)
        taxLabel.textColor = .textBlue
        contentView.addSubview(taxLabel)
        
        taxLabel.anchor(top: subTotalLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: subTotalLabel.leadingAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        taxAmout.placeholderString = "0 %"
        taxAmout.delegate = self
        taxAmout.font = .systemFont(ofSize: 16, weight: .regular)
        taxAmout.textColor = .white
        taxAmout.backgroundColor = .clear
        taxAmout.isBezeled = false
        taxAmout.isBordered = false
        taxAmout.focusRingType = .none
        taxAmout.lineBreakMode = .byTruncatingTail
        taxAmout.alignment = .right
        contentView.addSubview(taxAmout)
        
        taxAmout.anchor(top: subTotalLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: subTotalAmout.leadingAnchor, paddingLeft: 0, right: subTotalAmout.trailingAnchor, paddingRight: 0, width: 0, height: 20)
        
        // ----------------------------------
        
        partition_3.wantsLayer = true
        partition_3.layer?.backgroundColor = NSColor.lightGray.cgColor
        contentView.addSubview(partition_3)
        
        partition_3.anchor(top: taxAmout.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: taxLabel.leadingAnchor, paddingLeft: 0, right: taxAmout.trailingAnchor, paddingRight: 0, width: 0, height: 0.5)
        
        // ----------------------------------
        
        totalAmout.titleText.stringValue = "$82939.22"
        totalAmout.titleText.font = .systemFont(ofSize: 18, weight: .regular)
        totalAmout.titleText.textColor = .textBlue
        totalAmout.wantsLayer = true
//        totalAmout.layer?.backgroundColor = NSColor.red.withAlphaComponent(0.3).cgColor
        contentView.addSubview(totalAmout)
        
        totalAmout.anchor(top: partition_3.bottomAnchor, paddingTop: 10, bottom: mainView.bottomAnchor, paddingBottom: 30, left: taxAmout.leadingAnchor, paddingLeft: 0, right: taxAmout.trailingAnchor, paddingRight: 0, width: 0, height: 20)
        
        // ----------------------------------
        
        totalLabel = NSTextField(labelWithString: "Total")
        totalLabel.font = .systemFont(ofSize: 18, weight: .regular)
        totalLabel.textColor = .textBlue
        contentView.addSubview(totalLabel)
        
        totalLabel.anchor(top: nil, paddingTop: 0, bottom: totalAmout.bottomAnchor, paddingBottom: 0, left: subTotalLabel.leadingAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        var notesLabel : NSTextField!
        notesLabel = NSTextField(labelWithString: "Terms & Conditions")
        notesLabel.font = .systemFont(ofSize: 18, weight: .regular)
        notesLabel.textColor = .textBlue
        contentView.addSubview(notesLabel)
        
        notesLabel.anchor(top: subTotalLabel.topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: invoiceItemCV.leadingAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        let notesScrollView = NSScrollView()
        notesScrollView.translatesAutoresizingMaskIntoConstraints = false
        notesScrollView.hasVerticalScroller = true
        notesScrollView.hasHorizontalScroller = false
        notesScrollView.drawsBackground = false
        notesScrollView.borderType = .noBorder

        notesTextView.isVerticallyResizable = true
        notesTextView.isHorizontallyResizable = false
        notesTextView.autoresizingMask = [.width]
        notesTextView.textColor = .white
        notesTextView.font = .systemFont(ofSize: 14, weight: .regular)
        notesTextView.drawsBackground = false
        notesTextView.wantsLayer = true
        notesTextView.layer?.backgroundColor = NSColor.lightGray.withAlphaComponent(0.3).cgColor
        notesTextView.layer?.cornerRadius = 10
        
        notesScrollView.documentView = notesTextView
        contentView.addSubview(notesScrollView)

        notesScrollView.anchor(
            top: notesLabel.bottomAnchor, paddingTop: 10, bottom: totalAmout.bottomAnchor, paddingBottom: 0, left: notesLabel.leadingAnchor, paddingLeft: 0, right: mainView.centerXAnchor, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
       
    }
}

extension InvoiceView : InvoiceItemCVCellDelegate {
    
    @objc func addNewItem() {
        let oldConstant = itemScrollViewConstraint.constant
        itemScrollViewConstraint.constant = oldConstant + 60
        invoiceItemCVList.append(AmountModel(qty: "", price: "", amount: ""))
        
        DispatchQueue.main.async {
            self.invoiceItemCV.reloadData()
        }
    }
    
    func minusTapped(index: Int) {
        guard invoiceItemCVList.count > 1 else {
            showAlert(title: "Item Required", message: "At least one item required")
            return
        }
        
        let oldConstant = itemScrollViewConstraint.constant
        itemScrollViewConstraint.constant = oldConstant - 60
        invoiceItemCVList.remove(at: index)
        
        var total: Double = 0.0

        for item in invoiceItemCVList {
            total += Double(item.amount) ?? 0.0
        }
        
        subTotalAmout.titleText.stringValue = String(format: "%.2f", total)
        
        DispatchQueue.main.async {
            self.invoiceItemCV.reloadData()
        }
    }
    
    func amoutUpdated(index: Int, amount: AmountModel) {

        guard invoiceItemCVList.indices.contains(index) else { return }
        
        invoiceItemCVList[index] = amount

        // ── Calculate subtotal ────────────────────────────────
        var subtotal: Double = 0.0
        for item in invoiceItemCVList {
            subtotal += Double(item.amount) ?? 0.0
        }
        subTotalAmout.titleText.stringValue = String(format: "%.2f", subtotal)

        // ── Calculate total with tax ──────────────────────────
        let taxText = taxAmout.stringValue.trimmingCharacters(in: .whitespaces)

        if taxText.isEmpty {
            // No tax — total = subtotal
            totalAmout.titleText.stringValue = String(format: "%.2f", subtotal)
        } else if let taxPercent = Double(taxText) {
            // Tax exists — calculate and add
            let taxValue = subtotal * (taxPercent / 100)
            let total    = subtotal + taxValue
            totalAmout.titleText.stringValue = String(format: "%.2f", total)
        } else {
            // Invalid tax input — treat as no tax
            totalAmout.titleText.stringValue = String(format: "%.2f", subtotal)
        }
    }
    
    func controlTextDidChange(_ obj: Notification) {
        guard let field = obj.object as? NSTextField else { return }
        
        if field == taxAmout {
            
            // Character limit — max 3 digits
            if field.stringValue.count > 3 {
                field.stringValue = String(field.stringValue.prefix(3))
            }
            
            // Recalculate total whenever tax changes
            let subtotal = Double(subTotalAmout.titleText.stringValue) ?? 0.0
            let taxText  = field.stringValue.trimmingCharacters(in: .whitespaces)
            
            if taxText.isEmpty {
                totalAmout.titleText.stringValue = String(format: "%.2f", subtotal)
            } else if let taxPercent = Double(taxText) {
                let taxValue = subtotal * (taxPercent / 100)
                let total    = subtotal + taxValue
                totalAmout.titleText.stringValue = String(format: "%.2f", total)
            }
        }
    }
    
    
}

extension InvoiceView: NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return invoiceItemCVList.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let cell = collectionView.makeItem(withIdentifier: InvoiceItemCVCell.identifier,for: indexPath) as! InvoiceItemCVCell
        let item = invoiceItemCVList[indexPath.item]
        
        cell.currentIndex = indexPath.item
        cell.delegate = self

        // IMPORTANT
        cell.qtyLabel.stringValue = item.qty
        cell.rateLabel.stringValue = item.price
        cell.amountLabel.stringValue = item.amount.isEmpty ? "0" : item.amount
        
        return cell
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        
        return NSSize(width: collectionView.frame.size.width, height: 60)
    }
    
}

extension InvoiceView {
    @objc func saveTapped() {
        let generator = InvoicePDFGenerator(
            items:         invoiceItemCVList,
            invoiceNumber: invoiceNumberField.stringValue,
            invoiceDate:   invoiceDate.stringValue,
            dueDate:       dueDate.stringValue,
            brandName:     brandNameTitle.stringValue,
            yourName:      yourNameField.stringValue,
            yourAddress:   yourAddressField.stringValue,
            yourCityState: yourCityStateField.stringValue,
            billName:      billNameField.stringValue,
            billAddress:   billAddressField.stringValue,
            billCityState: billCityStateField.stringValue,
            subtotal:      subTotalAmout.titleText.stringValue,
            tax:           taxAmout.stringValue,
            total:         totalAmout.titleText.stringValue,
            notes:         notesTextView.string
        )
        generator.saveAsPDF()
    }
}

//extension InvoiceView {
//    // MARK: - PDF Generation
//
//    func saveAsPDF() {
//        generatePDF { pdfData in
//            guard let pdfData = pdfData else { return }
//            self.showSavePanel(pdfData: pdfData)
//        }
//    }
//    
//    private func generatePDF(completion: @escaping (Data?) -> Void) {
//        
//        let a4Width:  CGFloat = 595.28
//        let a4Height: CGFloat = 841.89
//        let a4Size = CGSize(width: a4Width, height: a4Height)
//        let margin: CGFloat = 40
//        
//        var pdfPages: [NSView] = []
//        var currentPage = buildPage(size: a4Size)
//        
//        // ── AppKit Y starts from BOTTOM ──────────────────────────
//        // So we build layout from bottom up, then flip when rendering
//        // Easier approach: track from top, subtract from a4Height when placing
//        
//        var currentY: CGFloat = margin  // this represents distance from TOP
//        
//        // Header
//        let headerView = buildHeaderBlock(width: a4Width - (margin * 2))
//        let headerH = headerView.frame.height
//        // Place from top: actual AppKit Y = a4Height - currentY - height
//        headerView.frame.origin = CGPoint(x: margin, y: a4Height - currentY - headerH)
//        currentPage.addSubview(headerView)
//        currentY += headerH + 20
//        
//        // Items header row
//        let itemsHeader = buildItemsHeaderRow(width: a4Width - (margin * 2))
//        let itemsHeaderH = itemsHeader.frame.height
//        itemsHeader.frame.origin = CGPoint(x: margin, y: a4Height - currentY - itemsHeaderH)
//        currentPage.addSubview(itemsHeader)
//        currentY += itemsHeaderH + 5
//        
//        // Separator
//        let sep1 = buildSeparator(width: a4Width - (margin * 2))
//        sep1.frame.origin = CGPoint(x: margin, y: a4Height - currentY - 1)
//        currentPage.addSubview(sep1)
//        currentY += 6
//        
//        // Item rows
//        let rowHeight: CGFloat = 40
//        
//        for item in invoiceItemCVList {
//            let remainingSpace = a4Height - currentY - margin
//            if remainingSpace < rowHeight {
//                pdfPages.append(currentPage)
//                currentPage = buildPage(size: a4Size)
//                currentY = margin
//            }
//            
//            let row = buildItemRow(item: item, width: a4Width - (margin * 2))
//            row.frame.origin = CGPoint(x: margin, y: a4Height - currentY - rowHeight)
//            currentPage.addSubview(row)
//            currentY += rowHeight
//        }
//        
//        // Separator after items
//        let sep2 = buildSeparator(width: a4Width - (margin * 2))
//        sep2.frame.origin = CGPoint(x: margin, y: a4Height - currentY - 1)
//        currentPage.addSubview(sep2)
//        currentY += 10
//        
//        // Footer
//        let footerHeight: CGFloat = 120
//        if (a4Height - currentY - margin) < footerHeight {
//            pdfPages.append(currentPage)
//            currentPage = buildPage(size: a4Size)
//            currentY = margin
//        }
//        
//        let footerView = buildFooterBlock(width: a4Width - (margin * 2))
//        footerView.frame.origin = CGPoint(x: margin, y: a4Height - currentY - footerHeight)
//        currentPage.addSubview(footerView)
//        
//        pdfPages.append(currentPage)
//        
//        // ── Render to PDF ────────────────────────────────────────
//        let pdfData = NSMutableData()
//        var mediaBox = CGRect(origin: .zero, size: a4Size)
//        
//        guard let consumer = CGDataConsumer(data: pdfData),
//              let context  = CGContext(consumer: consumer, mediaBox: &mediaBox, nil) else {
//            completion(nil)
//            return
//        }
//        
//        for page in pdfPages {
//            page.layoutSubtreeIfNeeded()
//            
//            context.beginPage(mediaBox: &mediaBox)
//            
//            let nsCtx = NSGraphicsContext(cgContext: context, flipped: false)
//            NSGraphicsContext.saveGraphicsState()
//            NSGraphicsContext.current = nsCtx
//            page.displayIgnoringOpacity(page.bounds, in: nsCtx)
//            NSGraphicsContext.restoreGraphicsState()
//            
//            context.endPage()
//        }
//        
//        context.closePDF()
//        completion(pdfData as Data)
//    }
//    
//    // MARK: - Page Builder
//
//    private func buildPage(size: CGSize) -> NSView {
//        let page = NSView(frame: CGRect(origin: .zero, size: size))
//        page.wantsLayer = true
//        page.layer?.backgroundColor = NSColor.white.cgColor
//        return page
//    }
//
//    // MARK: - Header Block
//
//    private func buildHeaderBlock(width: CGFloat) -> NSView {
//        let container = NSView(frame: CGRect(x: 0, y: 0, width: width, height: 220))
//        container.wantsLayer = true
//
//        // ── Row 1: INVOICE title (right) + Invoice# (left) ──────
//        // In AppKit Y=0 is bottom, so highest Y = top of container
//        // Container height = 220, so top row Y = 220 - 20 - padding
//
//        let titleLabel = makeLabel(text: "INVOICE", font: .systemFont(ofSize: 28, weight: .bold), color: .black, alignment: .right)
//        titleLabel.frame = CGRect(x: width - 160, y: 185, width: 160, height: 35)
//        container.addSubview(titleLabel)
//
//        let invoiceNoTitle = makeLabel(text: "Invoice#", font: .systemFont(ofSize: 13), color: .darkGray)
//        invoiceNoTitle.frame = CGRect(x: 0, y: 195, width: 100, height: 20)
//        container.addSubview(invoiceNoTitle)
//
//        let invoiceNoVal = makeLabel(text: invoiceNumberField.stringValue.isEmpty ? "-" : invoiceNumberField.stringValue, font: .systemFont(ofSize: 13), color: .black)
//        invoiceNoVal.frame = CGRect(x: 100, y: 195, width: 160, height: 20)
//        container.addSubview(invoiceNoVal)
//
//        // ── Row 2: Invoice Date ──────────────────────────────────
//        let invDateTitle = makeLabel(text: "Invoice Date", font: .systemFont(ofSize: 13), color: .darkGray)
//        invDateTitle.frame = CGRect(x: 0, y: 170, width: 100, height: 20)
//        container.addSubview(invDateTitle)
//
//        let invDateVal = makeLabel(text: invoiceDate.stringValue, font: .systemFont(ofSize: 13), color: .black)
//        invDateVal.frame = CGRect(x: 100, y: 170, width: 160, height: 20)
//        container.addSubview(invDateVal)
//
//        // ── Row 3: Due Date ──────────────────────────────────────
//        let dueDateTitle = makeLabel(text: "Due Date", font: .systemFont(ofSize: 13), color: .darkGray)
//        dueDateTitle.frame = CGRect(x: 0, y: 145, width: 100, height: 20)
//        container.addSubview(dueDateTitle)
//
//        let dueDateVal = makeLabel(text: dueDate.stringValue, font: .systemFont(ofSize: 13), color: .black)
//        dueDateVal.frame = CGRect(x: 100, y: 145, width: 160, height: 20)
//        container.addSubview(dueDateVal)
//
//        // ── Separator ────────────────────────────────────────────
//        let sep = buildSeparator(width: width)
//        sep.frame.origin = CGPoint(x: 0, y: 128)
//        container.addSubview(sep)
//
//        // ── From (left) + Bill To (right) ────────────────────────
//        let fromName = makeLabel(text: brandNameTitle.stringValue, font: .systemFont(ofSize: 16, weight: .semibold), color: .black)
//        fromName.frame = CGRect(x: 0, y: 100, width: width / 2 - 10, height: 22)
//        container.addSubview(fromName)
//
//        let fromAddr = makeLabel(text: yourNameField.stringValue, font: .systemFont(ofSize: 12), color: .darkGray)
//        fromAddr.frame = CGRect(x: 0, y: 78, width: width / 2 - 10, height: 18)
//        container.addSubview(fromAddr)
//
//        let fromCity = makeLabel(text: yourAddressField.stringValue, font: .systemFont(ofSize: 12), color: .darkGray)
//        fromCity.frame = CGRect(x: 0, y: 56, width: width / 2 - 10, height: 18)
//        container.addSubview(fromCity)
//
//        let fromCountry = makeLabel(text: yourCityStateField.stringValue, font: .systemFont(ofSize: 12), color: .darkGray)
//        fromCountry.frame = CGRect(x: 0, y: 34, width: width / 2 - 10, height: 18)
//        container.addSubview(fromCountry)
//
//        // Bill To
//        let billTitle = makeLabel(text: "Bill To", font: .systemFont(ofSize: 16, weight: .semibold), color: .black)
//        billTitle.frame = CGRect(x: width / 2, y: 100, width: width / 2, height: 22)
//        container.addSubview(billTitle)
//
//        let billName = makeLabel(text: billNameField.stringValue, font: .systemFont(ofSize: 12), color: .darkGray)
//        billName.frame = CGRect(x: width / 2, y: 78, width: width / 2, height: 18)
//        container.addSubview(billName)
//
//        let billAddr = makeLabel(text: billAddressField.stringValue, font: .systemFont(ofSize: 12), color: .darkGray)
//        billAddr.frame = CGRect(x: width / 2, y: 56, width: width / 2, height: 18)
//        container.addSubview(billAddr)
//
//        let billCity = makeLabel(text: billCityStateField.stringValue, font: .systemFont(ofSize: 12), color: .darkGray)
//        billCity.frame = CGRect(x: width / 2, y: 34, width: width / 2, height: 18)
//        container.addSubview(billCity)
//
//        return container
//    }
//    
//    // MARK: - Items Header Row
//
//    private func buildItemsHeaderRow(width: CGFloat) -> NSView {
//        let container = NSView(frame: CGRect(x: 0, y: 0, width: width, height: 25))
//
//        let desc = makeLabel(text: "DESCRIPTION", font: .systemFont(ofSize: 11, weight: .semibold), color: .systemBlue)
//        desc.frame = CGRect(x: 0, y: 0, width: width * 0.46, height: 20)
//        container.addSubview(desc)
//
//        let qty = makeLabel(text: "QTY", font: .systemFont(ofSize: 11, weight: .semibold), color: .systemBlue, alignment: .right)
//        qty.frame = CGRect(x: width * 0.46, y: 0, width: width * 0.18, height: 20)
//        container.addSubview(qty)
//
//        let rate = makeLabel(text: "RATE", font: .systemFont(ofSize: 11, weight: .semibold), color: .systemBlue, alignment: .right)
//        rate.frame = CGRect(x: width * 0.64, y: 0, width: width * 0.18, height: 20)
//        container.addSubview(rate)
//
//        let amount = makeLabel(text: "AMOUNT", font: .systemFont(ofSize: 11, weight: .semibold), color: .systemBlue, alignment: .right)
//        amount.frame = CGRect(x: width * 0.82, y: 0, width: width * 0.18, height: 20)
//        container.addSubview(amount)
//
//        return container
//    }
//
//    // MARK: - Item Row
//
//    private func buildItemRow(item: AmountModel, width: CGFloat) -> NSView {
//        let container = NSView(frame: CGRect(x: 0, y: 0, width: width, height: 50))
//
//        let desc = makeLabel(text: item.qty.isEmpty ? "-" : item.qty, font: .systemFont(ofSize: 12), color: .black)
//        desc.frame = CGRect(x: 0, y: 15, width: width * 0.46, height: 20)
//        container.addSubview(desc)
//
//        let qty = makeLabel(text: item.qty.isEmpty ? "0" : item.qty, font: .systemFont(ofSize: 12), color: .black, alignment: .right)
//        qty.frame = CGRect(x: width * 0.46, y: 15, width: width * 0.18, height: 20)
//        container.addSubview(qty)
//
//        let rate = makeLabel(text: item.price.isEmpty ? "0" : item.price, font: .systemFont(ofSize: 12), color: .black, alignment: .right)
//        rate.frame = CGRect(x: width * 0.64, y: 15, width: width * 0.18, height: 20)
//        container.addSubview(rate)
//
//        let amount = makeLabel(text: item.amount.isEmpty ? "0" : item.amount, font: .systemFont(ofSize: 12), color: .black, alignment: .right)
//        amount.frame = CGRect(x: width * 0.82, y: 15, width: width * 0.18, height: 20)
//        container.addSubview(amount)
//
//        // Bottom separator
//        let sep = buildSeparator(width: width)
//        sep.frame.origin = CGPoint(x: 0, y: 48)
//        container.addSubview(sep)
//
//        return container
//    }
//
//    // MARK: - Footer Block
//
//    private func buildFooterBlock(width: CGFloat) -> NSView {
//        let container = NSView(frame: CGRect(x: 0, y: 0, width: width, height: 120))
//
//        // Subtotal row
//        let subtotalTitle = makeLabel(text: "Subtotal", font: .systemFont(ofSize: 13), color: .systemBlue)
//        subtotalTitle.frame = CGRect(x: width * 0.5, y: 80, width: width * 0.25, height: 20)
//        container.addSubview(subtotalTitle)
//
//        let subtotalVal = makeLabel(text: subTotalAmout.titleText.stringValue, font: .systemFont(ofSize: 13), color: .systemBlue, alignment: .right)
//        subtotalVal.frame = CGRect(x: width * 0.75, y: 80, width: width * 0.25, height: 20)
//        container.addSubview(subtotalVal)
//
//        // Tax row
//        let taxTitle = makeLabel(text: "Tax", font: .systemFont(ofSize: 13), color: .systemBlue)
//        taxTitle.frame = CGRect(x: width * 0.5, y: 52, width: width * 0.25, height: 20)
//        container.addSubview(taxTitle)
//
//        let taxVal = makeLabel(
//            text: taxAmout.stringValue.isEmpty ? "0 %" : "\(taxAmout.stringValue) %",
//            font: .systemFont(ofSize: 13), color: .black, alignment: .right
//        )
//        taxVal.frame = CGRect(x: width * 0.75, y: 52, width: width * 0.25, height: 20)
//        container.addSubview(taxVal)
//
//        // Separator
//        let sep = buildSeparator(width: width * 0.5)
//        sep.frame.origin = CGPoint(x: width * 0.5, y: 45)
//        container.addSubview(sep)
//
//        // Total row
//        let totalTitle = makeLabel(text: "Total", font: .systemFont(ofSize: 14, weight: .semibold), color: .systemBlue)
//        totalTitle.frame = CGRect(x: width * 0.5, y: 20, width: width * 0.25, height: 22)
//        container.addSubview(totalTitle)
//
//        let totalVal = makeLabel(text: totalAmout.titleText.stringValue, font: .systemFont(ofSize: 14, weight: .semibold), color: .systemBlue, alignment: .right)
//        totalVal.frame = CGRect(x: width * 0.75, y: 20, width: width * 0.25, height: 22)
//        container.addSubview(totalVal)
//
//        return container
//    }
//    
//    // MARK: - Helpers
//
//    private func buildSeparator(width: CGFloat) -> NSView {
//        let sep = NSView(frame: CGRect(x: 0, y: 0, width: width, height: 0.5))
//        sep.wantsLayer = true
//        sep.layer?.backgroundColor = NSColor.lightGray.cgColor
//        return sep
//    }
//
//    private func makeLabel(
//        text: String,
//        font: NSFont,
//        color: NSColor,
//        alignment: NSTextAlignment = .left
//    ) -> NSTextField {
//        let label = NSTextField(labelWithString: text)
//        label.font = font
//        label.textColor = color
//        label.alignment = alignment
//        label.lineBreakMode = .byTruncatingTail
//        return label
//    }
//
//    // MARK: - NSSavePanel
//
//    private func showSavePanel(pdfData: Data) {
//        let panel = NSSavePanel()
//        panel.title            = "Save Invoice"
//        panel.nameFieldLabel   = "File name:"
//        panel.nameFieldStringValue = "Invoice_\(invoiceNumberField.stringValue.isEmpty ? "Draft" : invoiceNumberField.stringValue)"
//        panel.allowedContentTypes  = [.pdf]
//        panel.canCreateDirectories = true
//
//        panel.begin { response in
//            guard response == .OK, let url = panel.url else { return }
//            do {
//                try pdfData.write(to: url)
//                print("PDF saved to: \(url.path)")
//            } catch {
//                print("Failed to save PDF: \(error)")
//            }
//        }
//    }
//}
