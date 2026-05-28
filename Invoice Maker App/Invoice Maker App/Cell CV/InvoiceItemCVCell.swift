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
    func amoutUpdated(index: Int, amount: AmountModel)
    func textViewUpdated(index: Int, text: String)
}

class InvoiceItemCVCell : NSCollectionViewItem, NSTextViewDelegate {
    
    weak var delegate : InvoiceItemCVCellDelegate?
    static let identifier = NSUserInterfaceItemIdentifier("InvoiceItemCVCell")
    
    var dataView = NSView()
    
    var descView = NSView()
    var descLabel : NSTextField!
    var descCoLabel : NSTextField!
    var qtyLabel = NSTextField()
    var rateLabel = NSTextField()
    var amountLabel = NSTextField()
    var minusIcon = CustomPlusView()

    var scrollView : NSScrollView!
    var textView : NSTextView!
    
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
        scrollView = NSScrollView(frame: frame)
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        scrollView.autohidesScrollers = true
        scrollView.borderType = .noBorder
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        // 3. Create NSTextView sized to scroll view's content area
        let contentSize = scrollView.contentSize
        textView = NSTextView(frame: CGRect(origin: .zero, size: contentSize))
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
        textView.delegate = self
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
        qtyLabel.delegate = self
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
//            qtyLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        // ----------------------------------
        
        rateLabel.placeholderString = "0"
        rateLabel.delegate = self
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
//            rateLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        // ----------------------------------
        
        amountLabel.placeholderString = "0"
        amountLabel.delegate = self
        amountLabel.font = .systemFont(ofSize: 14, weight: .regular)
        amountLabel.textColor = .white
        amountLabel.backgroundColor = .clear
        amountLabel.isBezeled = false
        amountLabel.isBordered = false
        amountLabel.focusRingType = .none
        amountLabel.lineBreakMode = .byTruncatingTail
        amountLabel.alignment = .right
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(amountLabel)
        
        NSLayoutConstraint.activate([
            amountLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            amountLabel.heightAnchor.constraint(equalToConstant: 17),
            amountLabel.leadingAnchor.constraint(equalTo: rateLabel.trailingAnchor),
            //            amountLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.18),
            amountLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),

        ])
        
        // ----------------------------------
        
    }
    
}

extension InvoiceItemCVCell {
    
    @objc func minusTapped() {
        delegate?.minusTapped(index: currentIndex)
    }
    
}

extension InvoiceItemCVCell : NSTextFieldDelegate {
    
    // ─── NSTextFieldDelegate Observers ───────────────────────────────
    
    func controlTextDidChange(_ obj: Notification) {
        guard let field = obj.object as? NSTextField else { return }
        
        if field == qtyLabel {
            if field.stringValue.count > 8 {
                field.stringValue = String(field.stringValue.prefix(8))
            }
        } else if field == rateLabel {
            if field.stringValue.count > 12 {
                field.stringValue = String(field.stringValue.prefix(12))
            }
        }
    }
    
    func controlTextDidEndEditing(_ obj: Notification) {
        guard let field = obj.object as? NSTextField else { return }
        
        let value = field.stringValue
        
        if field == qtyLabel {
            if value.isEmpty { return }
            
            // Only digits allowed for qty
            let isOnlyNumbers = value.unicodeScalars.allSatisfy { CharacterSet.decimalDigits.contains($0) }
            
            if !isOnlyNumbers {
                field.stringValue = ""
                return
            }
            
            // Auto calculate if rate also has value
            calculateTotal()
        }
        
        else if field == rateLabel {
            if value.isEmpty { return }
            
            // Digits + decimal allowed for rate
            let allowedCharacters = CharacterSet.decimalDigits.union(CharacterSet(charactersIn: "."))
            let isValidDecimal = value.unicodeScalars.allSatisfy { allowedCharacters.contains($0) }
            let dotCount = value.filter { $0 == "." }.count

            guard isValidDecimal && dotCount <= 1 && Double(value) != nil else {
                field.stringValue = ""
                return
            }
            
            // Auto calculate if qty also has value
            calculateTotal()
        }
    }

    func textDidEndEditing(_ notification: Notification) {
        guard let textView = notification.object as? NSTextView else { return }
        
        delegate?.textViewUpdated(index: currentIndex, text: textView.string)
        print(textView.string)
        calculateTotal()
    }
    
    // ─── Calculate & print total ──────────────────────────────────────────

    private func calculateTotal() {

        guard !qtyLabel.stringValue.isEmpty,
              !rateLabel.stringValue.isEmpty else { return }

        guard let qty = Double(qtyLabel.stringValue),
              let rate = Double(rateLabel.stringValue) else { return }

        let total = qty * rate

        let formatted: String

        if total.truncatingRemainder(dividingBy: 1) == 0 {
            formatted = String(format: "%.0f", total)
        } else {
            formatted = String(format: "%.2f", total)
        }

        print("Qty: \(qty) × Rate: \(rate) = Total: \(formatted)")

        DispatchQueue.main.async {
            self.amountLabel.stringValue = formatted
        }

        let item = AmountModel(
            text: textView.string,
            qty: "\(qty)",
            price: "\(rate)",
            amount: formatted
        )

        delegate?.amoutUpdated(index: currentIndex, amount: item)
    }
    
}
