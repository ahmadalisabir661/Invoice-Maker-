//
//  InvoiceItemCVCell.swift
//  Invoice Maker App
//
//  Created by Dev-Mac on 2026-05-01.
//

import Foundation
import Cocoa

protocol InvoiceItemCVCellDelegate : AnyObject {
    func minusTapped(index: Int)
}

class InvoiceItemCVCell : NSCollectionViewItem {
    
    weak var delegate : InvoiceItemCVCellDelegate?
    static let identifier = NSUserInterfaceItemIdentifier("InvoiceItemCVCell")
    
    var dataView = NSView()
    
    var descView = NSView()
    var descLabel : NSTextField!
    var descCoLabel : NSTextField!
    var qtyLabel = NSTextField()
    var rateLabel = NSTextField()
    var amountLabel = BtnView()
    var minusIcon = CustomPlusView()

    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.clear.cgColor
        
        // ----------------------------------
        
        descView.wantsLayer = true
//        descView.layer?.backgroundColor = NSColor.red.withAlphaComponent(0.3).cgColor
        descView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(descView)
        
        NSLayoutConstraint.activate([
            descView.topAnchor.constraint(equalTo: self.view.topAnchor),
            descView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            descView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            descView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.46),
        ])

        // ----------------------------------
        
        minusIcon.imageView.image = NSImage(systemSymbolName: "minus", accessibilityDescription: nil)
        minusIcon.wantsLayer = true
        minusIcon.layer?.backgroundColor = NSColor.lightGray.cgColor
        minusIcon.layer?.cornerRadius = 18 / 2
        descView.addSubview(minusIcon)
        
        minusIcon.addGestureRecognizer(NSClickGestureRecognizer(target: self, action: #selector(minusTapped)))
        
        minusIcon.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: descView.leadingAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 18, height: 18)
        minusIcon.center(centerX: nil, centerY: self.view.centerYAnchor)
        
                
        // ----------------------------------
        
        let frame = CGRect(x: 20, y: 20, width: 500, height: 300)

        // 2. Create NSScrollView
        let scrollView = NSScrollView(frame: frame)
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        scrollView.autohidesScrollers = true
        scrollView.borderType = .noBorder
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        // 3. Create NSTextView sized to scroll view's content area
        let contentSize = scrollView.contentSize
        let textView = NSTextView(frame: CGRect(origin: .zero, size: contentSize))
        textView.minSize = NSSize(width: 0, height: contentSize.height)
        textView.maxSize = NSSize(width: CGFloat.greatestFiniteMagnitude,
                                  height: CGFloat.greatestFiniteMagnitude)

        // 4. Allow vertical growth
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = false
        textView.autoresizingMask = [.width]
        textView.textContainer?.containerSize = NSSize(
            width: contentSize.width,
            height: CGFloat.greatestFiniteMagnitude
        )
        textView.textContainer?.widthTracksTextView = true
        textView.isEditable = true
        textView.isSelectable = true
        textView.allowsUndo = true
        textView.font = NSFont.systemFont(ofSize: 14)
        textView.backgroundColor = .clear
        textView.wantsLayer = true
        textView.layer?.backgroundColor = NSColor.clear.cgColor
        textView.wantsLayer = true
        textView.layer?.borderColor = NSColor.lightGray.cgColor
        textView.layer?.borderWidth = 1
        textView.layer?.cornerRadius = 10
        scrollView.documentView = textView

        // Add these ↓
        scrollView.drawsBackground = false

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: descView.topAnchor, constant: 5),
            scrollView.leadingAnchor.constraint(equalTo: minusIcon.trailingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: descView.trailingAnchor, constant: -5),
            scrollView.bottomAnchor.constraint(equalTo: descView.bottomAnchor, constant: -5)
        ])
        
        // ----------------------------------
        
        qtyLabel.placeholderString = "0"
        qtyLabel.font = .systemFont(ofSize: 14, weight: .regular)
        qtyLabel.textColor = .white
        qtyLabel.backgroundColor = .clear
        qtyLabel.isBezeled = false
        qtyLabel.isBordered = false
        qtyLabel.focusRingType = .none
        qtyLabel.lineBreakMode = .byTruncatingTail
        qtyLabel.alignment = .right
        qtyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(qtyLabel)
        
        NSLayoutConstraint.activate([
            qtyLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            qtyLabel.heightAnchor.constraint(equalToConstant: 17),
            qtyLabel.leadingAnchor.constraint(equalTo: descView.trailingAnchor),
            qtyLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.18),
        ])
        
        // ----------------------------------
        
        rateLabel.placeholderString = "0"
        rateLabel.font = .systemFont(ofSize: 14, weight: .regular)
        rateLabel.textColor = .white
        rateLabel.backgroundColor = .clear
        rateLabel.isBezeled = false
        rateLabel.isBordered = false
        rateLabel.focusRingType = .none
        rateLabel.lineBreakMode = .byTruncatingTail
        rateLabel.alignment = .right
        rateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(rateLabel)
        
        NSLayoutConstraint.activate([
            rateLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            rateLabel.heightAnchor.constraint(equalToConstant: 17),
            rateLabel.leadingAnchor.constraint(equalTo: qtyLabel.trailingAnchor),
            rateLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.18),
        ])
        
        // ----------------------------------
        
        amountLabel.titleText.stringValue = "0"
        amountLabel.titleText.font = .systemFont(ofSize: 14, weight: .regular)
        amountLabel.titleText.alignment = .right
        amountLabel.wantsLayer = true
//        amountLabel.layer?.backgroundColor = NSColor.primaryNavy.withAlphaComponent(0.1).cgColor
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(amountLabel)
        
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: self.view.topAnchor),
            amountLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            amountLabel.leadingAnchor.constraint(equalTo: rateLabel.trailingAnchor),
            amountLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.18),
        ])
        
        // ----------------------------------
        
    }
    
    @objc func minusTapped() {
        delegate?.minusTapped(index: currentIndex)
    }
    
}
