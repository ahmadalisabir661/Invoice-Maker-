//
//  Invoice View.swift
//  Invoice Maker App
//
//  Created by Dev-Mac on 2026-04-30.
//

import Foundation
import Cocoa
 
/*
class InvoiceView : NSView {
    
    var mainHeaderView = NSView()
    var invoiceBtn = BtnView()
    var billBtn = BtnView()
    
    let scrollView = NSScrollView()
    let contentView = NSView()

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
    
    var subTotalAmout = BtnView()
    var subTotalLabel : NSTextField!
    var taxAmout = BtnView()
    var taxLabel : NSTextField!
    var totalAmout = BtnView()
    var totalLabel : NSTextField!
    
    var partition_3 = NSView()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.mainBG.cgColor
        setupHeader()
        setupScrollView()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHeader()
        setupScrollView()
        setup()
    }

    func setupHeader() {
        mainHeaderView.wantsLayer = true
        mainHeaderView.layer?.backgroundColor = NSColor.clear.cgColor
        mainHeaderView.layer?.borderColor = NSColor.white.withAlphaComponent(0.5).cgColor
        mainHeaderView.layer?.borderWidth = 1
        mainHeaderView.layer?.cornerRadius = 15
        mainHeaderView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mainHeaderView)
        
        NSLayoutConstraint.activate([
            mainHeaderView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            mainHeaderView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainHeaderView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            mainHeaderView.heightAnchor.constraint(equalToConstant: 70),
        ])
        
        // ----------------------------------
        
        invoiceBtn.wantsLayer = true
        invoiceBtn.layer?.backgroundColor = NSColor.textBlue.withAlphaComponent(0.2).cgColor
        invoiceBtn.layer?.cornerRadius = 13
        invoiceBtn.titleText.stringValue = "Create Invoice"
        invoiceBtn.titleText.font = .systemFont(ofSize: 20, weight: .semibold)
        invoiceBtn.titleText.alignment = .center
        invoiceBtn.titleText.textColor = .textBlue
        mainHeaderView.addSubview(invoiceBtn)
        
        invoiceBtn.addGestureRecognizer(NSClickGestureRecognizer(target: self, action: #selector(createInvoiceClicked)))
        
        invoiceBtn.anchor(top: mainHeaderView.topAnchor, paddingTop: 7, bottom: mainHeaderView.bottomAnchor, paddingBottom: 7, left: mainHeaderView.leadingAnchor, paddingLeft: 7, right: mainHeaderView.centerXAnchor, paddingRight: 7, width: 0, height: 0)
        
        // ----------------------------------
        
        billBtn.wantsLayer = true
        billBtn.layer?.backgroundColor = NSColor.clear.cgColor
        billBtn.layer?.cornerRadius = 13
        billBtn.titleText.stringValue = "Create Bill"
        billBtn.titleText.font = .systemFont(ofSize: 20, weight: .semibold)
        billBtn.titleText.alignment = .center
        billBtn.titleText.textColor = .textGray
        mainHeaderView.addSubview(billBtn)
        
        billBtn.addGestureRecognizer(NSClickGestureRecognizer(target: self, action: #selector(createBillTapped)))

        billBtn.anchor(top: mainHeaderView.topAnchor, paddingTop: 7, bottom: mainHeaderView.bottomAnchor, paddingBottom: 7, left: mainHeaderView.centerXAnchor, paddingLeft: 7, right: mainHeaderView.trailingAnchor, paddingRight: 7, width: 0, height: 0)
        
        // ----------------------------------
    }
    
    func setupScrollView() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        scrollView.drawsBackground = false
        self.addSubview(scrollView)

        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.topAnchor.constraint(equalTo: mainHeaderView.bottomAnchor, constant: 20),
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
    
    func setup() {
        
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
            mainView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6),
            mainView.heightAnchor.constraint(greaterThanOrEqualToConstant: 800)
        ])
        
        // ----------------------------------
        
        titleText = NSTextField(labelWithString: "Invoice")
        titleText.font = .systemFont(ofSize: 30, weight: .medium)
        titleText.textColor = .white
        contentView.addSubview(titleText)
        
        titleText.anchor(top: mainView.topAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: mainView.trailingAnchor, paddingRight: 20, width: 0, height: 0)
        
        // ----------------------------------
        
        invoiceNumber = NSTextField(labelWithString: "INV-2024-001")
        invoiceNumber.font = .systemFont(ofSize: 18, weight: .regular)
        invoiceNumber.textColor = .textBlue
        contentView.addSubview(invoiceNumber)
        
        invoiceNumber.anchor(top: titleText.bottomAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: titleText.trailingAnchor, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        invoiceLabel = NSTextField(labelWithString: "ISSUE DATE:")
        invoiceLabel.font = .systemFont(ofSize: 18, weight: .regular)
        invoiceLabel.textColor = .textBlue
        contentView.addSubview(invoiceLabel)
        
        invoiceLabel.anchor(top: nil, paddingTop: 0, bottom: invoiceNumber.bottomAnchor, paddingBottom: 0, left: nil, paddingLeft: 0, right: invoiceNumber.leadingAnchor, paddingRight: 10, width: 0, height: 0)
        
        // ----------------------------------
        
        issueDate = NSTextField(labelWithString: "INV-2024-001")
        issueDate.font = .systemFont(ofSize: 18, weight: .regular)
        issueDate.textColor = .textBlue
        contentView.addSubview(issueDate)
        
        issueDate.anchor(top: invoiceNumber.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: titleText.trailingAnchor, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        issueDateLabel = NSTextField(labelWithString: "DUE DATE:")
        issueDateLabel.font = .systemFont(ofSize: 18, weight: .regular)
        issueDateLabel.textColor = .textBlue
        contentView.addSubview(issueDateLabel)
        
        issueDateLabel.anchor(top: nil, paddingTop: 0, bottom: issueDate.bottomAnchor, paddingBottom: 0, left: nil, paddingLeft: 0, right: issueDate.leadingAnchor, paddingRight: 10, width: 0, height: 0)
        
        // ----------------------------------
        
        partition_1.wantsLayer = true
        partition_1.layer?.backgroundColor = NSColor.lightGray.cgColor
        contentView.addSubview(partition_1)
        
        partition_1.anchor(top: issueDateLabel.bottomAnchor, paddingTop: 30, bottom: nil, paddingBottom: 0, left: mainView.leadingAnchor, paddingLeft: 20, right: mainView.trailingAnchor, paddingRight: 20, width: 0, height: 0.5)
        
        // ----------------------------------
        
        billToLabel = NSTextField(labelWithString: "BILL TO")
        billToLabel.font = .systemFont(ofSize: 18, weight: .regular)
        billToLabel.textColor = .textBlue
        contentView.addSubview(billToLabel)
        
        billToLabel.anchor(top: partition_1.bottomAnchor, paddingTop: 40, bottom: nil, paddingBottom: 0, left: mainView.leadingAnchor, paddingLeft: 20, right: nil, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        billToView.wantsLayer = true
        billToView.layer?.backgroundColor = NSColor.lightGray.withAlphaComponent(0.3).cgColor
        billToView.layer?.cornerRadius = 8
        contentView.addSubview(billToView)
        
        billToView.anchor(top: billToLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: mainView.leadingAnchor, paddingLeft: 20, right: mainView.centerXAnchor, paddingRight: 10, width: 0, height: 150)
        
        // ----------------------------------
        
        shipToLabel = NSTextField(labelWithString: "SHIP TO")
        shipToLabel.font = .systemFont(ofSize: 18, weight: .regular)
        shipToLabel.textColor = .textBlue
        contentView.addSubview(shipToLabel)
        
        shipToLabel.anchor(top: billToLabel.topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: mainView.centerXAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        shipToView.wantsLayer = true
        shipToView.layer?.backgroundColor = NSColor.lightGray.withAlphaComponent(0.3).cgColor
        shipToView.layer?.cornerRadius = 8
        contentView.addSubview(shipToView)
        
        shipToView.anchor(top: billToLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: mainView.centerXAnchor, paddingLeft: 10, right: mainView.trailingAnchor, paddingRight: 20, width: 0, height: 150)
        
        // ----------------------------------
        
        itemsContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(itemsContainer)
        
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
        
        let itemScrollView = NSScrollView()
        itemScrollView.documentView = invoiceItemCV
        itemScrollView.hasVerticalScroller = true
        itemScrollView.drawsBackground = false
        
        contentView.addSubview(itemScrollView)
        
        itemScrollView.anchor(top: partition_2.bottomAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: itemsContainer.leadingAnchor, paddingLeft: 0, right: itemsContainer.trailingAnchor, paddingRight: 0, width: 0, height: 200)
        
        // ----------------------------------
        
        subTotalAmout.titleText.stringValue = "$82939.22"
        subTotalAmout.titleText.font = .systemFont(ofSize: 18, weight: .regular)
        subTotalAmout.titleText.textColor = .textBlue
        subTotalAmout.wantsLayer = true
//        subTotalAmout.layer?.backgroundColor = NSColor.red.withAlphaComponent(0.3).cgColor
        contentView.addSubview(subTotalAmout)
        
        subTotalAmout.anchor(top: itemScrollView.bottomAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: titleText.trailingAnchor, paddingRight: 0, width: 100, height: 20)
        
        // ----------------------------------
        
        subTotalLabel = NSTextField(labelWithString: "Subtotal")
        subTotalLabel.font = .systemFont(ofSize: 18, weight: .regular)
        subTotalLabel.textColor = .textBlue
        contentView.addSubview(subTotalLabel)
        
        subTotalLabel.anchor(top: nil, paddingTop: 0, bottom: subTotalAmout.bottomAnchor, paddingBottom: 0, left: nil, paddingLeft: 0, right: subTotalAmout.leadingAnchor, paddingRight: 20, width: 0, height: 0)
        
        // ----------------------------------
        
        taxAmout.titleText.stringValue = "$82939.22"
        taxAmout.titleText.font = .systemFont(ofSize: 18, weight: .regular)
        taxAmout.titleText.textColor = .textBlue
        taxAmout.wantsLayer = true
//        taxAmout.layer?.backgroundColor = NSColor.red.withAlphaComponent(0.3).cgColor
        contentView.addSubview(taxAmout)
        
        taxAmout.anchor(top: subTotalLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: titleText.trailingAnchor, paddingRight: 0, width: 100, height: 20)
        
        // ----------------------------------
        
        taxLabel = NSTextField(labelWithString: "Tax")
        taxLabel.font = .systemFont(ofSize: 18, weight: .regular)
        taxLabel.textColor = .textBlue
        contentView.addSubview(taxLabel)
        
        taxLabel.anchor(top: nil, paddingTop: 0, bottom: taxAmout.bottomAnchor, paddingBottom: 0, left: subTotalLabel.leadingAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        
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
        
        totalAmout.anchor(top: partition_3.bottomAnchor, paddingTop: 10, bottom: mainView.bottomAnchor, paddingBottom: 30, left: nil, paddingLeft: 0, right: titleText.trailingAnchor, paddingRight: 0, width: 100, height: 20)
        
        // ----------------------------------
        
        totalLabel = NSTextField(labelWithString: "Total")
        totalLabel.font = .systemFont(ofSize: 18, weight: .regular)
        totalLabel.textColor = .textBlue
        contentView.addSubview(totalLabel)
        
        totalLabel.anchor(top: nil, paddingTop: 0, bottom: totalAmout.bottomAnchor, paddingBottom: 0, left: subTotalLabel.leadingAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        var notesLabel : NSTextField!
        notesLabel = NSTextField(labelWithString: "Notes")
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

        let notesTextView = NSTextView()
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

extension InvoiceView {
    
    @objc func createInvoiceClicked() {
        invoiceBtn.layer?.backgroundColor = NSColor.textBlue.withAlphaComponent(0.2).cgColor
        billBtn.layer?.backgroundColor = NSColor.clear.cgColor
        
        invoiceBtn.titleText.textColor = .textBlue
        billBtn.titleText.textColor = .textGray
        
        titleText.stringValue = "Invoice"
    }
    
    @objc func createBillTapped() {
        invoiceBtn.layer?.backgroundColor = NSColor.clear.cgColor
        billBtn.layer?.backgroundColor = NSColor.textBlue.withAlphaComponent(0.2).cgColor
        
        billBtn.titleText.textColor = .textBlue
        invoiceBtn.titleText.textColor = .textGray
        
        titleText.stringValue = "Bill"
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
*/

class InvoiceView : NSView {
    
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
    
    var subTotalAmout = BtnView()
    var subTotalLabel : NSTextField!
    var taxAmout = BtnView()
    var taxLabel : NSTextField!
    var totalAmout = BtnView()
    var totalLabel : NSTextField!
    
    var partition_3 = NSView()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.mainBG.cgColor
        setupScrollView()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupScrollView()
        setup()
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
    
    func setup() {
        
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
            mainView.heightAnchor.constraint(greaterThanOrEqualToConstant: 800)
        ])
        
        // ----------------------------------
        
        titleText = NSTextField(labelWithString: "INVOICE")
        titleText.font = .systemFont(ofSize: 35, weight: .regular)
        titleText.textColor = .white
        contentView.addSubview(titleText)
        
        titleText.anchor(top: mainView.topAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: mainView.trailingAnchor, paddingRight: 20, width: 0, height: 0)
        
        // ----------------------------------
        
        brandNameTitle.stringValue = "AK Khan"
        brandNameTitle.font = .systemFont(ofSize: 25, weight: .medium)
        brandNameTitle.textColor = .white
        brandNameTitle.backgroundColor = .clear
        brandNameTitle.isBezeled = false
        brandNameTitle.isBordered = false
        brandNameTitle.focusRingType = .none
        brandNameTitle.lineBreakMode = .byTruncatingTail
        brandNameTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(brandNameTitle)
                
        NSLayoutConstraint.activate([
            brandNameTitle.centerYAnchor.constraint(equalTo: titleText.centerYAnchor),
            brandNameTitle.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            brandNameTitle.heightAnchor.constraint(equalToConstant: 25),
            brandNameTitle.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.6)
        ])
                
        // ----------------------------------
        
        yourNameField.placeholderString = "Your Name"
        yourNameField.font = .systemFont(ofSize: 16, weight: .regular)
        yourNameField.textColor = .white
        yourNameField.backgroundColor = .clear
        yourNameField.isBezeled = false
        yourNameField.isBordered = false
        yourNameField.focusRingType = .none
        yourNameField.lineBreakMode = .byTruncatingTail
        yourNameField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(yourNameField)
        
        NSLayoutConstraint.activate([
            yourNameField.topAnchor.constraint(equalTo: brandNameTitle.bottomAnchor, constant: 15),
            yourNameField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            yourNameField.heightAnchor.constraint(equalToConstant: 17),
            yourNameField.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.6)
        ])
        
        // ----------------------------------
        
        yourAddressField.placeholderString = "Address"
        yourAddressField.font = .systemFont(ofSize: 16, weight: .regular)
        yourAddressField.textColor = .white
        yourAddressField.backgroundColor = .clear
        yourAddressField.isBezeled = false
        yourAddressField.isBordered = false
        yourAddressField.focusRingType = .none
        yourAddressField.lineBreakMode = .byTruncatingTail
        yourAddressField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(yourAddressField)
        
        NSLayoutConstraint.activate([
            yourAddressField.topAnchor.constraint(equalTo: yourNameField.bottomAnchor, constant: 15),
            yourAddressField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            yourAddressField.heightAnchor.constraint(equalToConstant: 17),
            yourAddressField.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.6)
        ])
        
        // ----------------------------------
        
        yourCityStateField.placeholderString = "City, State, ZIP/Postal Code"
        yourCityStateField.font = .systemFont(ofSize: 16, weight: .regular)
        yourCityStateField.textColor = .white
        yourCityStateField.backgroundColor = .clear
        yourCityStateField.isBezeled = false
        yourCityStateField.isBordered = false
        yourCityStateField.focusRingType = .none
        yourCityStateField.lineBreakMode = .byTruncatingTail
        yourCityStateField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(yourCityStateField)
        
        NSLayoutConstraint.activate([
            yourCityStateField.topAnchor.constraint(equalTo: yourAddressField.bottomAnchor, constant: 15),
            yourCityStateField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            yourCityStateField.heightAnchor.constraint(equalToConstant: 17),
            yourCityStateField.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.6)
        ])
        
        // ----------------------------------
        
        yourCountryLabel = NSTextField(labelWithString: "Canada")
        yourCountryLabel.font = .systemFont(ofSize: 16, weight: .regular)
        yourCountryLabel.textColor = .white
        contentView.addSubview(yourCountryLabel)
        
        yourCountryLabel.anchor(top: yourCityStateField.bottomAnchor, paddingTop: 15, bottom: nil, paddingBottom: 0, left: yourCityStateField.leadingAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        billTolabel = NSTextField(labelWithString: "Bill To")
        billTolabel.font = .systemFont(ofSize: 18, weight: .medium)
        billTolabel.textColor = .white
        contentView.addSubview(billTolabel)
        
        billTolabel.anchor(top: yourCountryLabel.bottomAnchor, paddingTop: 60, bottom: nil, paddingBottom: 0, left: yourCountryLabel.leadingAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        clearView.wantsLayer = true
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
        billNameField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(billNameField)
                
        NSLayoutConstraint.activate([
            billNameField.topAnchor.constraint(equalTo: billTolabel.bottomAnchor, constant: 15),
            billNameField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            billNameField.heightAnchor.constraint(equalToConstant: 17),
            billNameField.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.6)
        ])
                
        // ----------------------------------
        
        billAddressField.placeholderString = "Address"
        billAddressField.font = .systemFont(ofSize: 16, weight: .regular)
        billAddressField.textColor = .white
        billAddressField.backgroundColor = .clear
        billAddressField.isBezeled = false
        billAddressField.isBordered = false
        billAddressField.focusRingType = .none
        billAddressField.lineBreakMode = .byTruncatingTail
        billAddressField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(billAddressField)
                
        NSLayoutConstraint.activate([
            billAddressField.topAnchor.constraint(equalTo: billNameField.bottomAnchor, constant: 15),
            billAddressField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            billAddressField.heightAnchor.constraint(equalToConstant: 17),
            billAddressField.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.6)
        ])
        
        // ----------------------------------
        
        billCityStateField.placeholderString = "City, State, ZIP/Postal Code"
        billCityStateField.font = .systemFont(ofSize: 16, weight: .regular)
        billCityStateField.textColor = .white
        billCityStateField.backgroundColor = .clear
        billCityStateField.isBezeled = false
        billCityStateField.isBordered = false
        billCityStateField.focusRingType = .none
        billCityStateField.lineBreakMode = .byTruncatingTail
        billCityStateField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(billCityStateField)
                
        NSLayoutConstraint.activate([
            billCityStateField.topAnchor.constraint(equalTo: billAddressField.bottomAnchor, constant: 15),
            billCityStateField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            billCityStateField.heightAnchor.constraint(equalToConstant: 17),
            billCityStateField.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.6)
        ])
        
        // ----------------------------------
        
        billCountryLabel = NSTextField(labelWithString: "Canada")
        billCountryLabel.font = .systemFont(ofSize: 16, weight: .regular)
        billCountryLabel.textColor = .white
        contentView.addSubview(billCountryLabel)
        
        billCountryLabel.anchor(top: billCityStateField.bottomAnchor, paddingTop: 15, bottom: nil, paddingBottom: 0, left: billCityStateField.leadingAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
                
        // ----------------------------------
        
        invoiceNumberField.placeholderString = "Click to Enter"
        invoiceNumberField.font = .systemFont(ofSize: 16, weight: .regular)
        invoiceNumberField.textColor = .white
        invoiceNumberField.backgroundColor = .clear
        invoiceNumberField.isBezeled = false
        invoiceNumberField.isBordered = false
        invoiceNumberField.focusRingType = .none
        invoiceNumberField.lineBreakMode = .byTruncatingTail
        invoiceNumberField.alignment = .right
        invoiceNumberField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(invoiceNumberField)
                
        NSLayoutConstraint.activate([
            invoiceNumberField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            invoiceNumberField.centerYAnchor.constraint(equalTo: billTolabel.centerYAnchor),
            invoiceNumberField.heightAnchor.constraint(equalToConstant: 17),
            invoiceNumberField.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.2)
        ])
        
        // ----------------------------------
        
        invoiceNoLabel = NSTextField(labelWithString: "Invoice#")
        invoiceNoLabel.font = .systemFont(ofSize: 16, weight: .regular)
        invoiceNoLabel.textColor = .white
        contentView.addSubview(invoiceNoLabel)
        
        invoiceNoLabel.anchor(top: nil, paddingTop: 15, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: invoiceNumberField.leadingAnchor, paddingRight: 30, width: 0, height: 0)
        invoiceNoLabel.center(centerX: nil, centerY: invoiceNumberField.centerYAnchor)
                
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
        
        invoiceDate.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: invoiceNumberField.trailingAnchor, paddingRight: 0, width: 0, height: 0)
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
        
        dueDate.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: invoiceNumberField.trailingAnchor, paddingRight: 0, width: 0, height: 0)
        dueDate.center(centerX: nil, centerY: dueDateLabel.centerYAnchor)
        
        // ----------------------------------
        
        partition_1.wantsLayer = true
        partition_1.layer?.backgroundColor = NSColor.lightGray.cgColor
        contentView.addSubview(partition_1)
        
        partition_1.anchor(top: yourCountryLabel.bottomAnchor, paddingTop: 230, bottom: nil, paddingBottom: 0, left: mainView.leadingAnchor, paddingLeft: 20, right: mainView.trailingAnchor, paddingRight: 20, width: 0, height: 0.5)
        
        // ----------------------------------
        
        billToLabel = NSTextField(labelWithString: "BILL TO")
        billToLabel.font = .systemFont(ofSize: 18, weight: .regular)
        billToLabel.textColor = .textBlue
        contentView.addSubview(billToLabel)
        
        billToLabel.anchor(top: partition_1.bottomAnchor, paddingTop: 40, bottom: nil, paddingBottom: 0, left: mainView.leadingAnchor, paddingLeft: 20, right: nil, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        billToView.wantsLayer = true
        billToView.layer?.backgroundColor = NSColor.lightGray.withAlphaComponent(0.3).cgColor
        billToView.layer?.cornerRadius = 8
        contentView.addSubview(billToView)
        
        billToView.anchor(top: billToLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: mainView.leadingAnchor, paddingLeft: 20, right: mainView.centerXAnchor, paddingRight: 10, width: 0, height: 150)
        
        // ----------------------------------
        
        shipToLabel = NSTextField(labelWithString: "SHIP TO")
        shipToLabel.font = .systemFont(ofSize: 18, weight: .regular)
        shipToLabel.textColor = .textBlue
        contentView.addSubview(shipToLabel)
        
        shipToLabel.anchor(top: billToLabel.topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: mainView.centerXAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        shipToView.wantsLayer = true
        shipToView.layer?.backgroundColor = NSColor.lightGray.withAlphaComponent(0.3).cgColor
        shipToView.layer?.cornerRadius = 8
        contentView.addSubview(shipToView)
        
        shipToView.anchor(top: billToLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: mainView.centerXAnchor, paddingLeft: 10, right: mainView.trailingAnchor, paddingRight: 20, width: 0, height: 150)
        
        // ----------------------------------
        
        itemsContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(itemsContainer)
        
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
        
        let itemScrollView = NSScrollView()
        itemScrollView.documentView = invoiceItemCV
        itemScrollView.hasVerticalScroller = true
        itemScrollView.drawsBackground = false
        
        contentView.addSubview(itemScrollView)
        
        itemScrollView.anchor(top: partition_2.bottomAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: itemsContainer.leadingAnchor, paddingLeft: 0, right: itemsContainer.trailingAnchor, paddingRight: 0, width: 0, height: 200)
        
        // ----------------------------------
        
        subTotalAmout.titleText.stringValue = "$82939.22"
        subTotalAmout.titleText.font = .systemFont(ofSize: 18, weight: .regular)
        subTotalAmout.titleText.textColor = .textBlue
        subTotalAmout.wantsLayer = true
//        subTotalAmout.layer?.backgroundColor = NSColor.red.withAlphaComponent(0.3).cgColor
        contentView.addSubview(subTotalAmout)
        
        subTotalAmout.anchor(top: itemScrollView.bottomAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: titleText.trailingAnchor, paddingRight: 0, width: 100, height: 20)
        
        // ----------------------------------
        
        subTotalLabel = NSTextField(labelWithString: "Subtotal")
        subTotalLabel.font = .systemFont(ofSize: 18, weight: .regular)
        subTotalLabel.textColor = .textBlue
        contentView.addSubview(subTotalLabel)
        
        subTotalLabel.anchor(top: nil, paddingTop: 0, bottom: subTotalAmout.bottomAnchor, paddingBottom: 0, left: nil, paddingLeft: 0, right: subTotalAmout.leadingAnchor, paddingRight: 20, width: 0, height: 0)
        
        // ----------------------------------
        
        taxAmout.titleText.stringValue = "$82939.22"
        taxAmout.titleText.font = .systemFont(ofSize: 18, weight: .regular)
        taxAmout.titleText.textColor = .textBlue
        taxAmout.wantsLayer = true
//        taxAmout.layer?.backgroundColor = NSColor.red.withAlphaComponent(0.3).cgColor
        contentView.addSubview(taxAmout)
        
        taxAmout.anchor(top: subTotalLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: titleText.trailingAnchor, paddingRight: 0, width: 100, height: 20)
        
        // ----------------------------------
        
        taxLabel = NSTextField(labelWithString: "Tax")
        taxLabel.font = .systemFont(ofSize: 18, weight: .regular)
        taxLabel.textColor = .textBlue
        contentView.addSubview(taxLabel)
        
        taxLabel.anchor(top: nil, paddingTop: 0, bottom: taxAmout.bottomAnchor, paddingBottom: 0, left: subTotalLabel.leadingAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        
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
        
        totalAmout.anchor(top: partition_3.bottomAnchor, paddingTop: 10, bottom: mainView.bottomAnchor, paddingBottom: 30, left: nil, paddingLeft: 0, right: titleText.trailingAnchor, paddingRight: 0, width: 100, height: 20)
        
        // ----------------------------------
        
        totalLabel = NSTextField(labelWithString: "Total")
        totalLabel.font = .systemFont(ofSize: 18, weight: .regular)
        totalLabel.textColor = .textBlue
        contentView.addSubview(totalLabel)
        
        totalLabel.anchor(top: nil, paddingTop: 0, bottom: totalAmout.bottomAnchor, paddingBottom: 0, left: subTotalLabel.leadingAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        var notesLabel : NSTextField!
        notesLabel = NSTextField(labelWithString: "Notes")
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

        let notesTextView = NSTextView()
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

extension InvoiceView {
    
    
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
