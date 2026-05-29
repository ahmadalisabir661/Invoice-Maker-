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
    let text: String
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
    var yourCountryView = NSView()
    var yourCountryLabel : NSTextField!
    var yourCountryIcon = NSImageView()

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

    // Properties
    var datePopover: NSPopover?
    var datePicker: NSDatePicker?
    
    var invoicePickedDate : Date?
    var duePickedDate : Date?
    
    var yourCountryViewWidth : NSLayoutConstraint!
    var isYourCountry: Bool = true
    var searchField = NSTextField()
    let countryCV = NSCollectionView()
    let countrySV = NSScrollView()

    var invoiceItemCVList : [AmountModel] = [
        AmountModel(text: "", qty: "", price: "", amount: "")
    ]
    
    var countryCVList : [String] = []
    var countryCVFilteredList : [String] = []
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.mainBG.cgColor
        
        addCountryList()
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
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.contentView.heightAnchor),
        ])
    }
    
    func headerSection() {
        
        mainView.wantsLayer = true
        mainView.layer?.backgroundColor = NSColor.secondaryBlue.cgColor
        mainView.layer?.borderColor = NSColor.blueBorder.cgColor
        mainView.layer?.borderWidth = 1.5
        mainView.layer?.cornerRadius = 20
        mainView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainView)
        
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20), // ← stays at top
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            mainView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
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
        
        let year = Calendar.current.component(.year, from: Date())
        var invoiceNumber = "INV-\(year)-0001"
        invoiceNumberField.stringValue = invoiceNumber
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
        
        invoiceDate.addGestureRecognizer(NSClickGestureRecognizer(target: self, action: #selector(invoiceDateClicked(_:))))
        
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
        
        dueDate.addGestureRecognizer(NSClickGestureRecognizer(target: self, action: #selector(dueDateClicked(_:))))
        
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
        
        yourCountryView.wantsLayer = true
        yourCountryView.layer?.borderColor = NSColor.blueBorder.cgColor
        yourCountryView.layer?.borderWidth = 1
        yourCountryView.layer?.cornerRadius = 5
        yourCountryView.layer?.backgroundColor = NSColor.itemBlue.cgColor
        yourCountryView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(yourCountryView)
        
        yourCountryView.addGestureRecognizer(NSClickGestureRecognizer(target: self, action: #selector(yourCountryPopover(_:))))
        
        yourCountryViewWidth = yourCountryView.widthAnchor.constraint(equalToConstant: 0)
        updateYourCountryWidth("Canada")
        
        NSLayoutConstraint.activate([
            yourCountryView.topAnchor.constraint(equalTo: yourCityStateField.bottomAnchor, constant: 15),
            yourCountryView.leadingAnchor.constraint(equalTo: yourCityStateField.leadingAnchor),
            yourCountryViewWidth,
            yourCountryView.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        // ----------------------------------
        
        yourCountryLabel = NSTextField(labelWithString: "Canada")
        yourCountryLabel.font = .systemFont(ofSize: 16, weight: .regular)
        yourCountryLabel.textColor = .white
        yourCountryView.addSubview(yourCountryLabel)
                
        yourCountryLabel.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: yourCountryView.leadingAnchor, paddingLeft: 5, right: nil, paddingRight: 0, width: 0, height: 0)
        yourCountryLabel.center(centerX: nil, centerY: yourCountryView.centerYAnchor)
        
        // ----------------------------------
        
        let image = NSImage(systemSymbolName: "chevron.down", accessibilityDescription: nil)

        yourCountryIcon.image = image
        yourCountryIcon.image?.isTemplate = true
        yourCountryIcon.contentTintColor = .white
        yourCountryIcon.imageScaling = .scaleAxesIndependently
        yourCountryView.addSubview(yourCountryIcon)
        
        yourCountryIcon.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: yourCountryView.trailingAnchor, paddingRight: 5, width: 15, height: 10)
        yourCountryIcon.center(centerX: nil, centerY: yourCountryView.centerYAnchor)
        
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
        
        billCountryLabel.addGestureRecognizer(NSClickGestureRecognizer(target: self, action: #selector(billingCountryPopover(_:))))
        
        billCountryLabel.anchor(top: billCityStateField.bottomAnchor, paddingTop: 15, bottom: nil, paddingBottom: 0, left: billCityStateField.leadingAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
                
        // ----------------------------------
        
        partition_1.wantsLayer = true
        partition_1.layer?.backgroundColor = NSColor.lightGray.cgColor
        contentView.addSubview(partition_1)
        
        partition_1.anchor(top: yourCountryLabel.bottomAnchor, paddingTop: 30, bottom: nil, paddingBottom: 0, left: mainView.leadingAnchor, paddingLeft: 20, right: mainView.trailingAnchor, paddingRight: 20, width: 0, height: 0.5)
        
        // ----------------------------------
        
        invoicePickedDate = Date()
        duePickedDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        invoiceDate.stringValue = formatter.string(from: Date())
        dueDate.stringValue = formatter.string(from: Calendar.current.date(byAdding: .day, value: 1, to: Date())!)
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
        
        totalAmout.titleText.stringValue = "0"
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
        notesTextView.layer?.backgroundColor = NSColor.itemBlue.cgColor
        notesTextView.layer?.borderColor = NSColor.blueBorder.withAlphaComponent(1.5).cgColor
        notesTextView.layer?.borderWidth = 1
        notesTextView.layer?.cornerRadius = 10
        
        notesScrollView.documentView = notesTextView
        contentView.addSubview(notesScrollView)

        notesScrollView.anchor(
            top: notesLabel.bottomAnchor, paddingTop: 10, bottom: totalAmout.bottomAnchor, paddingBottom: 0, left: notesLabel.leadingAnchor, paddingLeft: 0, right: mainView.centerXAnchor, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
       
    }
}

extension InvoiceView : InvoiceItemCVCellDelegate {
    
    func addCountryList() {
        countryCVFilteredList = ["Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Argentina", "Armenia", "Australia",
                         "Austria", "Azerbaijan", "Bahrain", "Bangladesh", "Belarus", "Belgium", "Bhutan", "Bolivia", "Brazil", "Brunei", "Bulgaria", "Cambodia", "Cameroon", "Canada", "Chile", "China", "Colombia", "Costa Rica", "Croatia", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Estonia", "Ethiopia", "Finland", "France", "Georgia", "Germany", "Ghana", "Greece", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Israel", "Italy", "Japan",
                         "Jordan", "Kazakhstan", "Kenya", "Kuwait", "Latvia", "Lebanon", "Libya", "Lithuania", "Luxembourg", "Malaysia",
                         "Maldives", "Mexico", "Monaco", "Morocco", "Myanmar", "Nepal", "Netherlands", "New Zealand", "Nigeria", "North Korea", "Norway", "Oman", "Pakistan", "Palestine", "Peru", "Philippines", "Poland", "Portugal", "Qatar", "Romania", "Russia", "Saudi Arabia", "Singapore", "Slovakia", "South Africa", "South Korea", "Spain", "Sri Lanka", "Sweden", "Switzerland", "Thailand", "Turkey", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "Vietnam"]
        countryCVList = countryCVFilteredList
    }
    
    @objc func addNewItem() {
        let oldConstant = itemScrollViewConstraint.constant
        itemScrollViewConstraint.constant = oldConstant + 60
        for invoice in invoiceItemCVList {
            print("that will qty: \(invoice.qty), price: \(invoice.price), amount: \(invoice.amount)")
        }
        invoiceItemCVList.append(AmountModel(text: "", qty: "", price: "", amount: ""))
        
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
    
    func textViewUpdated(index: Int, text: String) {
        guard invoiceItemCVList.indices.contains(index) else { return }

        for (i, item) in invoiceItemCVList.enumerated() {
            if i == index {
                let newItem = AmountModel(text: text, qty: item.qty, price: item.price, amount: item.amount)
                invoiceItemCVList[i] = newItem
                break
            }
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
        else if field == searchField {
            if field.stringValue.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                countryCVFilteredList = countryCVList
            } else {
                countryCVFilteredList = countryCVList.filter {
                    $0.localizedCaseInsensitiveContains(field.stringValue)
                }
            }
            DispatchQueue.main.async {
                self.countryCV.reloadData()
            }
        }
    }
    
    func updateYourCountryWidth(_ text: String) {
        let font = NSFont.systemFont(ofSize: 16, weight: .regular)
        let textWidth = (text as NSString).size(withAttributes: [.font: font]).width
        
        // 5 (left padding) + textWidth + 8 (gap) + 15 (icon) + 5 (right padding)
        yourCountryViewWidth.constant = textWidth + 33
    }
}

extension InvoiceView: NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == invoiceItemCV {
            return invoiceItemCVList.count
        } else if collectionView == countryCV {
            return countryCVFilteredList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        if collectionView == invoiceItemCV {
            let cell = collectionView.makeItem(withIdentifier: InvoiceItemCVCell.identifier,for: indexPath) as! InvoiceItemCVCell
            let item = invoiceItemCVList[indexPath.item]
            
            cell.currentIndex = indexPath.item
            cell.delegate = self

            // IMPORTANT
            cell.textView.string = item.text
            cell.qtyLabel.stringValue = item.qty
            cell.rateLabel.stringValue = item.price
            cell.amountLabel.stringValue = item.amount.isEmpty ? "0" : item.amount
            
            return cell
        } else if collectionView == countryCV {
            let cell = collectionView.makeItem(withIdentifier: CountryCVCell.identifier,for: indexPath) as! CountryCVCell
            cell.titleText.stringValue = countryCVFilteredList[indexPath.item]
            return cell
        }
      return NSCollectionViewItem()
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        if collectionView == invoiceItemCV {
            return NSSize(width: collectionView.frame.size.width, height: 60)
        } else if collectionView == countryCV {
            return NSSize(width: collectionView.frame.size.width, height: 40)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        if collectionView == countryCV {
            guard let index = indexPaths.first else {return}
            if isYourCountry {
                let text = countryCVFilteredList[index.item]
                updateYourCountryWidth(text)
                yourCountryLabel.stringValue = text
            } else {
                billCountryLabel.stringValue = countryCVFilteredList[index.item]
            }
        }
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
    
    @objc func yourCountryPopover(_ sender: NSClickGestureRecognizer) {
        guard let anchorView = sender.view else { return }
        searchField.stringValue = ""
        countryCVFilteredList = countryCVList
        isYourCountry = true
        showCountryList(relativeTo: anchorView, isYourCountry: true)
    }
    
    @objc func billingCountryPopover(_ sender: NSClickGestureRecognizer) {
        guard let anchorView = sender.view else { return }
        searchField.stringValue = ""
        countryCVFilteredList = countryCVList
        isYourCountry = false
        showCountryList(relativeTo: anchorView, isYourCountry: false)
    }
    
    func showCountryList(relativeTo anchorView: NSView, isYourCountry: Bool) {
        if let existing = datePopover, existing.isShown {
            existing.close()
            datePopover = nil
            return
        }

        let popover = NSPopover()
        popover.behavior = .transient

        var searchView = NSView()
        searchView.wantsLayer = true
        searchView.layer?.borderColor = NSColor.blueBorder.cgColor
        searchView.layer?.borderWidth = 1
        searchView.layer?.cornerRadius = 8
        searchView.translatesAutoresizingMaskIntoConstraints = false
        
        // ---------------------------------
        
        var searchIcon = NSImageView()
        searchIcon.image = .search
        searchIcon.image?.isTemplate = true
        searchIcon.contentTintColor = .white
        searchIcon.imageScaling = .scaleAxesIndependently
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        
        // ---------------------------------
        
        searchField.font = .systemFont(ofSize: 16, weight: .medium)
        searchField.placeholderString = "Search Country..."
        searchField.textColor = .white
        searchField.focusRingType = .none
        searchField.isBezeled = false
        searchField.delegate = self
        searchField.drawsBackground = false
        searchField.maximumNumberOfLines = 0
        searchField.lineBreakMode = .byTruncatingTail
        searchField.translatesAutoresizingMaskIntoConstraints = false
        
        // ---------------------------------
        
        let layout = NSCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        countryCV.collectionViewLayout = layout
        countryCV.dataSource = self
        countryCV.delegate = self
        countryCV.isSelectable = true
        countryCV.allowsEmptySelection = false
        countryCV.register(CountryCVCell.self, forItemWithIdentifier: CountryCVCell.identifier)
        countryCV.backgroundColors = [.clear]
        
        countrySV.documentView = countryCV
        countrySV.hasVerticalScroller = false
        countrySV.hasHorizontalScroller = false
        countrySV.drawsBackground = false
        countrySV.translatesAutoresizingMaskIntoConstraints = false
        
        let container = NSView(frame: NSRect(x: 0, y: 0, width: 300, height: 270))
        container.addSubview(searchView)
        searchView.addSubview(searchIcon)
        searchView.addSubview(searchField)
        container.addSubview(countrySV)

        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            searchView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            searchView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            searchView.heightAnchor.constraint(equalToConstant: 40),
            
            searchIcon.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 8),
            searchIcon.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            searchIcon.heightAnchor.constraint(equalToConstant: 15),
            searchIcon.widthAnchor.constraint(equalToConstant: 15),
            
            searchField.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            searchField.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 10),
            searchField.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -5),
            searchField.heightAnchor.constraint(equalToConstant: 20),
            
            countrySV.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 10),
            countrySV.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            countrySV.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            countrySV.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12),
        ])

        let vc = NSViewController()
        vc.view = container

//        popover.contentViewController = vc
//        DispatchQueue.main.async {
//            popover.show(relativeTo: anchorView.bounds, of: anchorView, preferredEdge: .maxY)
//        }
//        
//        DispatchQueue.main.async { [self] in
//            for (i, country) in countryCVFilteredList.enumerated() {
//                if isYourCountry {
//                    if country == yourCountryLabel.stringValue {
//                        let indexPath = IndexPath(item: i, section: 0)
//                        self.countryCV.selectItems(at: [indexPath], scrollPosition: .top)
//                    }
//                } else {
//                    if country == billCountryLabel.stringValue {
//                        let indexPath = IndexPath(item: i, section: 0)
//                        self.countryCV.selectItems(at: [indexPath], scrollPosition: .top)
//                    }
//                }
//            }
//        }
//        
//        self.datePopover = popover
        popover.contentViewController = vc
        self.datePopover = popover

        DispatchQueue.main.async {
            popover.show(relativeTo: anchorView.bounds, of: anchorView, preferredEdge: .maxY)
            
            // Small delay to ensure cells are laid out after popover appears
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                guard let self = self else { return }
                
                let targetLabel = self.isYourCountry ? self.yourCountryLabel.stringValue : self.billCountryLabel.stringValue
                
                if let index = self.countryCVFilteredList.firstIndex(of: targetLabel) {
                    let indexPath = IndexPath(item: index, section: 0)
                    self.countryCV.selectItems(at: [indexPath], scrollPosition: .centeredVertically)
                }
            }
        }
    }

}

// date pickers
extension InvoiceView {
    
    @objc func invoiceDateClicked(_ sender: NSClickGestureRecognizer) {
        guard let anchorView = sender.view else { return }
        showDatePicker(relativeTo: anchorView, type: "invoice")
    }
    
    @objc func dueDateClicked(_ sender: NSClickGestureRecognizer) {
        guard let anchorView = sender.view else { return }
        showDatePicker(relativeTo: anchorView, type: "due")
    }

    func showDatePicker(relativeTo anchorView: NSView, type: String) {
        if let existing = datePopover, existing.isShown {
            existing.close()
            datePopover = nil
            return
        }

        let popover = NSPopover()
        popover.behavior = .transient

        let picker = NSDatePicker()
        picker.datePickerStyle = .clockAndCalendar
        picker.datePickerElements = .yearMonthDay
        picker.dateValue = Date()
        picker.isBordered = false
        picker.translatesAutoresizingMaskIntoConstraints = false

        let confirmBtn = NSButton()
        confirmBtn.title = "Done"
        confirmBtn.bezelStyle = .rounded
        confirmBtn.target = self
        if type == "invoice" {
            confirmBtn.action = #selector(invoiceDatePicked(_:))
        } else {
            confirmBtn.action = #selector(dueDatePicked(_:))
        }
        confirmBtn.translatesAutoresizingMaskIntoConstraints = false

        let container = NSView(frame: NSRect(x: 0, y: 0, width: 300, height: 220))
        container.addSubview(picker)
        container.addSubview(confirmBtn)

        NSLayoutConstraint.activate([
            picker.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            picker.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            picker.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),

            confirmBtn.topAnchor.constraint(equalTo: picker.bottomAnchor, constant: 10),
            confirmBtn.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            confirmBtn.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12),
            confirmBtn.widthAnchor.constraint(equalToConstant: 80)
        ])

        let vc = NSViewController()
        vc.view = container

        popover.contentViewController = vc
        popover.show(relativeTo: anchorView.bounds, of: anchorView, preferredEdge: .maxY)

        self.datePopover = popover
        self.datePicker = picker
    }
    
    @objc func invoiceDatePicked(_ sender: NSButton) {
        guard let picker = datePicker else { return }

        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let dateString = formatter.string(from: picker.dateValue)

        if let dueDate = duePickedDate {
            guard picker.dateValue < dueDate else { return }
        }
        
        // Set to your label/text field
        invoicePickedDate = picker.dateValue
        invoiceDate.stringValue = dateString
        print("date: \(dateString)")

        datePopover?.close()
        datePopover = nil
    }
    
    @objc func dueDatePicked(_ sender: NSButton) {
        guard let picker = datePicker else { return }

        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let dateString = formatter.string(from: picker.dateValue)

        if let invoiceDate = invoicePickedDate {
            guard picker.dateValue > invoiceDate else { return }
        }
        
        // Set to your label/text field
        duePickedDate = picker.dateValue
        dueDate.stringValue = dateString
        print("date: \(dateString)")

        datePopover?.close()
        datePopover = nil
    }
    
}
