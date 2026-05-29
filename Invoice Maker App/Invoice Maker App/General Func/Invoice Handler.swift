//
//  Invoice Handler.swift
//  Invoice Maker App
//
//  Created by Dev-Mac on 2026-05-16.
//

import Foundation
// MARK: - InvoicePDFGenerator.swift

import Cocoa
import UniformTypeIdentifiers

class InvoicePDFGenerator {
    
    // MARK: - Data
    private let invoiceItemCVList: [AmountModel]
    
    // Header fields
    private let invoiceNumber: String
    private let invoiceDateText: String
    private let dueDateText: String
    private let brandName: String
    private let yourName: String
    private let yourAddress: String
    private let yourCityState: String
    
    // Bill To fields
    private let billName: String
    private let billAddress: String
    private let billCityState: String
    
    // Footer fields
    private let subtotal: String
    private let tax: String
    private let total: String
    private let notes: String

    // MARK: - Init
    init(
        items: [AmountModel],
        invoiceNumber: String,
        invoiceDate: String,
        dueDate: String,
        brandName: String,
        yourName: String,
        yourAddress: String,
        yourCityState: String,
        billName: String,
        billAddress: String,
        billCityState: String,
        subtotal: String,
        tax: String,
        total: String,
        notes: String
    ) {
        self.invoiceItemCVList = items
        self.invoiceNumber     = invoiceNumber
        self.invoiceDateText   = invoiceDate
        self.dueDateText       = dueDate
        self.brandName         = brandName
        self.yourName          = yourName
        self.yourAddress       = yourAddress
        self.yourCityState     = yourCityState
        self.billName          = billName
        self.billAddress       = billAddress
        self.billCityState     = billCityState
        self.subtotal          = subtotal
        self.tax               = tax
        self.total             = total
        self.notes             = notes
    }
    
    // MARK: - Public Entry Point
    func saveAsPDF() {
        generatePDF { pdfData in
            guard let pdfData = pdfData else { return }
            self.showSavePanel(pdfData: pdfData)
        }
    }
    
    func sharePDF(view: NSView) {
        generatePDF { [weak self] pdfData in
            guard let self = self, let pdfData = pdfData else { return }
            
            DispatchQueue.main.async {
                // Save to temp file first (sharing works better with file URL)
                let tempURL = FileManager.default.temporaryDirectory
                    .appendingPathComponent("Invoice.pdf")
                
                do {
                    try pdfData.write(to: tempURL)
                    
                    // Show native share sheet
                    let picker = NSSharingServicePicker(items: [tempURL])
                    picker.show(relativeTo: .zero, of: view, preferredEdge: .minY)
                    
                } catch {
                    print("Failed to write PDF: \(error)")
                }
            }
        }
    }
    
    // MARK: - Generate PDF
    private func generatePDF(completion: @escaping (Data?) -> Void) {
        
        let a4Width:  CGFloat = 595.28
        let a4Height: CGFloat = 841.89
        let a4Size   = CGSize(width: a4Width, height: a4Height)
        let margin:  CGFloat = 40
        
        var pdfPages: [NSView] = []
        var currentPage = buildPage(size: a4Size)
        var currentY: CGFloat = margin
        
        // Header
        let headerView = buildHeaderBlock(width: a4Width - (margin * 2))
        let headerH    = headerView.frame.height
        headerView.frame.origin = CGPoint(x: margin, y: a4Height - currentY - headerH)
        currentPage.addSubview(headerView)
        currentY += headerH + 20
        
        // Items header row
        let itemsHeader  = buildItemsHeaderRow(width: a4Width - (margin * 2))
        let itemsHeaderH = itemsHeader.frame.height
        itemsHeader.frame.origin = CGPoint(x: margin, y: a4Height - currentY - itemsHeaderH)
        currentPage.addSubview(itemsHeader)
        currentY += itemsHeaderH + 5
        
        // Separator
        let sep1 = buildSeparator(width: a4Width - (margin * 2))
        sep1.frame.origin = CGPoint(x: margin, y: a4Height - currentY - 1)
        currentPage.addSubview(sep1)
        currentY += 6
        
        // Item rows
        let rowHeight: CGFloat = 40
        for item in invoiceItemCVList {
            if (a4Height - currentY - margin) < rowHeight {
                pdfPages.append(currentPage)
                currentPage = buildPage(size: a4Size)
                currentY    = margin
            }
            let row = buildItemRow(item: item, width: a4Width - (margin * 2))
            row.frame.origin = CGPoint(x: margin, y: a4Height - currentY - rowHeight)
            currentPage.addSubview(row)
            currentY += rowHeight
        }
        
        // Separator after items
        let sep2 = buildSeparator(width: a4Width - (margin * 2))
        sep2.frame.origin = CGPoint(x: margin, y: a4Height - currentY - 1)
        currentPage.addSubview(sep2)
        currentY += 10
        
        // Footer
        let footerHeight: CGFloat = 120
        if (a4Height - currentY - margin) < footerHeight {
            pdfPages.append(currentPage)
            currentPage = buildPage(size: a4Size)
            currentY    = margin
        }
        let footerView = buildFooterBlock(width: a4Width - (margin * 2))
        footerView.frame.origin = CGPoint(x: margin, y: a4Height - currentY - footerHeight)
        currentPage.addSubview(footerView)
        
        // After footer, before pdfPages.append(currentPage)
        if !notes.isEmpty {
            let notesHeight: CGFloat = 80
            
            // Check if fits
            if (a4Height - currentY - margin) < notesHeight {
                pdfPages.append(currentPage)
                currentPage = buildPage(size: a4Size)
                currentY    = margin
            }
            
            let notesView = buildNotesBlock(width: a4Width - (margin * 2), notes: notes)
            notesView.frame.origin = CGPoint(x: margin, y: a4Height - currentY - notesHeight)
            currentPage.addSubview(notesView)
            currentY += notesHeight
        }

        pdfPages.append(currentPage)
        
//        pdfPages.append(currentPage)
        
        // Render
        let pdfData = NSMutableData()
        var mediaBox = CGRect(origin: .zero, size: a4Size)
        
        guard let consumer = CGDataConsumer(data: pdfData),
              let context  = CGContext(consumer: consumer, mediaBox: &mediaBox, nil) else {
            completion(nil)
            return
        }
        
        for page in pdfPages {
            page.layoutSubtreeIfNeeded()
            context.beginPage(mediaBox: &mediaBox)
            let nsCtx = NSGraphicsContext(cgContext: context, flipped: false)
            NSGraphicsContext.saveGraphicsState()
            NSGraphicsContext.current = nsCtx
            page.displayIgnoringOpacity(page.bounds, in: nsCtx)
            NSGraphicsContext.restoreGraphicsState()
            context.endPage()
        }
        
        context.closePDF()
        completion(pdfData as Data)
    }
    
    // MARK: - Page Builder
    private func buildPage(size: CGSize) -> NSView {
        let page = NSView(frame: CGRect(origin: .zero, size: size))
        page.wantsLayer = true
        page.layer?.backgroundColor = NSColor.white.cgColor
        return page
    }
    
    // MARK: - Header Block
    private func buildHeaderBlock(width: CGFloat) -> NSView {
        let container = NSView(frame: CGRect(x: 0, y: 0, width: width, height: 220))
        container.wantsLayer = true

        let titleLabel = makeLabel(text: "INVOICE", font: .systemFont(ofSize: 28, weight: .bold), color: .black, alignment: .right)
        titleLabel.frame = CGRect(x: width - 160, y: 185, width: 160, height: 35)
        container.addSubview(titleLabel)

        let invoiceNoTitle = makeLabel(text: "Invoice#", font: .systemFont(ofSize: 13), color: .darkGray)
        invoiceNoTitle.frame = CGRect(x: 0, y: 195, width: 100, height: 20)
        container.addSubview(invoiceNoTitle)

        let invoiceNoVal = makeLabel(text: invoiceNumber.isEmpty ? "-" : invoiceNumber, font: .systemFont(ofSize: 13), color: .black)
        invoiceNoVal.frame = CGRect(x: 100, y: 195, width: 160, height: 20)
        container.addSubview(invoiceNoVal)

        let invDateTitle = makeLabel(text: "Invoice Date", font: .systemFont(ofSize: 13), color: .darkGray)
        invDateTitle.frame = CGRect(x: 0, y: 170, width: 100, height: 20)
        container.addSubview(invDateTitle)

        let invDateVal = makeLabel(text: invoiceDateText, font: .systemFont(ofSize: 13), color: .black)
        invDateVal.frame = CGRect(x: 100, y: 170, width: 160, height: 20)
        container.addSubview(invDateVal)

        let dueDateTitle = makeLabel(text: "Due Date", font: .systemFont(ofSize: 13), color: .darkGray)
        dueDateTitle.frame = CGRect(x: 0, y: 145, width: 100, height: 20)
        container.addSubview(dueDateTitle)

        let dueDateVal = makeLabel(text: dueDateText, font: .systemFont(ofSize: 13), color: .black)
        dueDateVal.frame = CGRect(x: 100, y: 145, width: 160, height: 20)
        container.addSubview(dueDateVal)

        let sep = buildSeparator(width: width)
        sep.frame.origin = CGPoint(x: 0, y: 128)
        container.addSubview(sep)

        // From
        let fromName = makeLabel(text: brandName, font: .systemFont(ofSize: 16, weight: .semibold), color: .black)
        fromName.frame = CGRect(x: 0, y: 100, width: width / 2 - 10, height: 22)
        container.addSubview(fromName)

        let fromAddr = makeLabel(text: yourName, font: .systemFont(ofSize: 12), color: .darkGray)
        fromAddr.frame = CGRect(x: 0, y: 78, width: width / 2 - 10, height: 18)
        container.addSubview(fromAddr)

        let fromCity = makeLabel(text: yourAddress, font: .systemFont(ofSize: 12), color: .darkGray)
        fromCity.frame = CGRect(x: 0, y: 56, width: width / 2 - 10, height: 18)
        container.addSubview(fromCity)

        let fromCountry = makeLabel(text: yourCityState, font: .systemFont(ofSize: 12), color: .darkGray)
        fromCountry.frame = CGRect(x: 0, y: 34, width: width / 2 - 10, height: 18)
        container.addSubview(fromCountry)

        // Bill To
        let billTitle = makeLabel(text: "Bill To", font: .systemFont(ofSize: 16, weight: .semibold), color: .black)
        billTitle.frame = CGRect(x: width / 2, y: 100, width: width / 2, height: 22)
        container.addSubview(billTitle)

        let billNameLabel = makeLabel(text: billName, font: .systemFont(ofSize: 12), color: .darkGray)
        billNameLabel.frame = CGRect(x: width / 2, y: 78, width: width / 2, height: 18)
        container.addSubview(billNameLabel)

        let billAddrLabel = makeLabel(text: billAddress, font: .systemFont(ofSize: 12), color: .darkGray)
        billAddrLabel.frame = CGRect(x: width / 2, y: 56, width: width / 2, height: 18)
        container.addSubview(billAddrLabel)

        let billCityLabel = makeLabel(text: billCityState, font: .systemFont(ofSize: 12), color: .darkGray)
        billCityLabel.frame = CGRect(x: width / 2, y: 34, width: width / 2, height: 18)
        container.addSubview(billCityLabel)

        return container
    }
    
//    // MARK: - Items Header Row
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
//    private func buildItemRow(item: AmountModel, width: CGFloat) -> NSView {
//        let container = NSView(frame: CGRect(x: 0, y: 0, width: width, height: 40))
//
//        let desc = makeLabel(text: item.qty.isEmpty ? "-" : item.qty, font: .systemFont(ofSize: 12), color: .black)
//        desc.frame = CGRect(x: 0, y: 10, width: width * 0.46, height: 20)
//        container.addSubview(desc)
//
//        let qty = makeLabel(text: item.qty.isEmpty ? "0" : item.qty, font: .systemFont(ofSize: 12), color: .black, alignment: .right)
//        qty.frame = CGRect(x: width * 0.46, y: 10, width: width * 0.18, height: 20)
//        container.addSubview(qty)
//
//        let rate = makeLabel(text: item.price.isEmpty ? "0" : item.price, font: .systemFont(ofSize: 12), color: .black, alignment: .right)
//        rate.frame = CGRect(x: width * 0.64, y: 10, width: width * 0.18, height: 20)
//        container.addSubview(rate)
//
//        let amount = makeLabel(text: item.amount.isEmpty ? "0" : item.amount, font: .systemFont(ofSize: 12), color: .black, alignment: .right)
//        amount.frame = CGRect(x: width * 0.82, y: 10, width: width * 0.18, height: 20)
//        container.addSubview(amount)
//
//        let sep = buildSeparator(width: width)
//        sep.frame.origin = CGPoint(x: 0, y: 0)
//        container.addSubview(sep)
//
//        return container
//    }
    
    // MARK: - Items Header Row
    private func buildItemsHeaderRow(width: CGFloat) -> NSView {
        let container = NSView(frame: CGRect(x: 0, y: 0, width: width, height: 25))

        let desc = makeLabel(text: "DESCRIPTION", font: .systemFont(ofSize: 11, weight: .semibold), color: .systemBlue)
        desc.frame = CGRect(x: 0, y: 0, width: width * 0.35, height: 20)   // ← was 0.46
        container.addSubview(desc)

        let qty = makeLabel(text: "QTY", font: .systemFont(ofSize: 11, weight: .semibold), color: .systemBlue, alignment: .right)
        qty.frame = CGRect(x: width * 0.35, y: 0, width: width * 0.15, height: 20)  // ← was 0.18
        container.addSubview(qty)

        let rate = makeLabel(text: "RATE", font: .systemFont(ofSize: 11, weight: .semibold), color: .systemBlue, alignment: .right)
        rate.frame = CGRect(x: width * 0.50, y: 0, width: width * 0.25, height: 20) // ← was 0.18
        container.addSubview(rate)

        let amount = makeLabel(text: "AMOUNT", font: .systemFont(ofSize: 11, weight: .semibold), color: .systemBlue, alignment: .right)
        amount.frame = CGRect(x: width * 0.75, y: 0, width: width * 0.25, height: 20) // ← was 0.18
        container.addSubview(amount)

        return container
    }

    // MARK: - Item Row
    private func buildItemRow(item: AmountModel, width: CGFloat) -> NSView {
        let container = NSView(frame: CGRect(x: 0, y: 0, width: width, height: 40))

        let desc = makeLabel(text: item.qty.isEmpty ? "-" : item.qty, font: .systemFont(ofSize: 12), color: .black)
        desc.frame = CGRect(x: 0, y: 10, width: width * 0.35, height: 20)   // ← was 0.46
        container.addSubview(desc)

        let qty = makeLabel(text: item.qty.isEmpty ? "0" : item.qty, font: .systemFont(ofSize: 12), color: .black, alignment: .right)
        qty.frame = CGRect(x: width * 0.35, y: 10, width: width * 0.15, height: 20) // ← was 0.18
        container.addSubview(qty)

        let rate = makeLabel(text: item.price.isEmpty ? "0" : item.price, font: .systemFont(ofSize: 12), color: .black, alignment: .right)
        rate.frame = CGRect(x: width * 0.50, y: 10, width: width * 0.25, height: 20) // ← was 0.18
        container.addSubview(rate)

        let amount = makeLabel(text: item.amount.isEmpty ? "0" : item.amount, font: .systemFont(ofSize: 12), color: .black, alignment: .right)
        amount.frame = CGRect(x: width * 0.75, y: 10, width: width * 0.25, height: 20) // ← was 0.18
        container.addSubview(amount)

        let sep = buildSeparator(width: width)
        sep.frame.origin = CGPoint(x: 0, y: 0)
        container.addSubview(sep)

        return container
    }
    
    // MARK: - Footer Block
    private func buildFooterBlock(width: CGFloat) -> NSView {
        let container = NSView(frame: CGRect(x: 0, y: 0, width: width, height: 120))

        let subtotalTitle = makeLabel(text: "Subtotal", font: .systemFont(ofSize: 13), color: .systemBlue)
        subtotalTitle.frame = CGRect(x: width * 0.5, y: 80, width: width * 0.25, height: 20)
        container.addSubview(subtotalTitle)

        let subtotalVal = makeLabel(text: subtotal, font: .systemFont(ofSize: 13), color: .systemBlue, alignment: .right)
//        subtotalVal.frame = CGRect(x: width * 0.75, y: 80, width: width * 0.25, height: 20)
        subtotalVal.frame = CGRect(x: width * 0.65, y: 80, width: width * 0.35, height: 20)
        container.addSubview(subtotalVal)

        let taxTitle = makeLabel(text: "Tax", font: .systemFont(ofSize: 13), color: .systemBlue)
        taxTitle.frame = CGRect(x: width * 0.5, y: 52, width: width * 0.25, height: 20)
        container.addSubview(taxTitle)

        let taxVal = makeLabel(text: tax.isEmpty ? "0 %" : "\(tax) %", font: .systemFont(ofSize: 13), color: .black, alignment: .right)
//        taxVal.frame = CGRect(x: width * 0.75, y: 52, width: width * 0.25, height: 20)
        taxVal.frame = CGRect(x: width * 0.65, y: 52, width: width * 0.35, height: 20)
        container.addSubview(taxVal)

        let sep = buildSeparator(width: width * 0.5)
        sep.frame.origin = CGPoint(x: width * 0.5, y: 45)
        container.addSubview(sep)

        let totalTitle = makeLabel(text: "Total", font: .systemFont(ofSize: 14, weight: .semibold), color: .systemBlue)
//        totalTitle.frame = CGRect(x: width * 0.5, y: 20, width: width * 0.25, height: 22)
        totalTitle.frame = CGRect(x: width * 0.5, y: 20, width: width * 0.15, height: 22)
        container.addSubview(totalTitle)

        let totalVal = makeLabel(text: total, font: .systemFont(ofSize: 14, weight: .semibold), color: .systemBlue, alignment: .right)
//        totalVal.frame = CGRect(x: width * 0.75, y: 20, width: width * 0.25, height: 22)
        totalVal.frame = CGRect(x: width * 0.65, y: 20, width: width * 0.35, height: 22)
        container.addSubview(totalVal)

        return container
    }
    
    private func buildNotesBlock(width: CGFloat, notes: String) -> NSView {
        let container = NSView(frame: CGRect(x: 0, y: 0, width: width, height: 80))

        let titleLabel = makeLabel(
            text: "Terms & Conditions",
            font: .systemFont(ofSize: 13, weight: .semibold),
            color: .systemBlue
        )
        titleLabel.frame = CGRect(x: 0, y: 55, width: width * 0.5, height: 20)
        container.addSubview(titleLabel)

        let notesLabel = makeLabel(
            text: notes,
            font: .systemFont(ofSize: 11),
            color: .darkGray
        )
        notesLabel.frame         = CGRect(x: 0, y: 0, width: width * 0.5, height: 50)
        notesLabel.maximumNumberOfLines = 3
        notesLabel.lineBreakMode = .byWordWrapping
        container.addSubview(notesLabel)

        return container
    }
    
    // MARK: - Helpers
    private func buildSeparator(width: CGFloat) -> NSView {
        let sep = NSView(frame: CGRect(x: 0, y: 0, width: width, height: 0.5))
        sep.wantsLayer = true
        sep.layer?.backgroundColor = NSColor.lightGray.cgColor
        return sep
    }

    private func makeLabel(text: String, font: NSFont, color: NSColor, alignment: NSTextAlignment = .left) -> NSTextField {
        let label = NSTextField(labelWithString: text)
        label.font      = font
        label.textColor = color
        label.alignment = alignment
//        label.lineBreakMode = .byTruncatingTail
        label.lineBreakMode = .byClipping  // ← was .byTruncatingTail
        return label
    }
    
    // MARK: - Save Panel
    private func showSavePanel(pdfData: Data) {
        let panel = NSSavePanel()
        panel.title                = "Save Invoice"
        panel.nameFieldLabel       = "File name:"
        panel.nameFieldStringValue = "Invoice_\(invoiceNumber.isEmpty ? "Draft" : invoiceNumber)"
        panel.allowedContentTypes  = [.pdf]
        panel.canCreateDirectories = true

        panel.begin { response in
            guard response == .OK, let url = panel.url else { return }
            do {
                try pdfData.write(to: url)
                print("PDF saved: \(url.path)")
            } catch {
                print("Save failed: \(error)")
            }
        }
    }
}
