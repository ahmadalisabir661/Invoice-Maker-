//
//  ViewController.swift
//  Invoice Maker App
//
//  Created by Dev-Mac on 2026-04-29.
//

import Cocoa

class ViewController: NSViewController, NSWindowDelegate {

    var saveBtn : NSTextField!
    
    let topBar = TopBarView()
    var sideBarView = SidebarView()
    var invoiceView = InvoiceView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.mainBG.cgColor
        
        sideBarView.delegate = self
        
        setup()
    }

    func windowWillResize(_ sender: NSWindow, to frameSize: NSSize) -> NSSize {
        let minimumSize = NSSize(width: 1400, height: 790)
        
        var newSize = NSSize()
        
        if frameSize.width < minimumSize.width {
            newSize.width = minimumSize.width
        } else {
            newSize.width = frameSize.width
        }
        
        if frameSize.height < minimumSize.height {
            newSize.height = minimumSize.height
        } else {
            newSize.height = frameSize.height
        }
        
        return newSize
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        
        view.window?.delegate = self
        view.window?.tabbingMode = .disallowed
        
        var frame = view.window?.frame
        
        let initialSize = NSSize(width: NSScreen.main!.visibleFrame.width, height: NSScreen.main!.visibleFrame.height)
        
        frame?.size = initialSize
        
        view.window?.setFrame(frame!, display: true)
        view.window?.center()
        view.window?.title = "Invoice Maker"
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        view.window?.makeFirstResponder(nil)
    }
    
    func setup() {
        
        sideBarView.wantsLayer = true
        sideBarView.isHidden = true
        sideBarView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(sideBarView)
        
        NSLayoutConstraint.activate([
            sideBarView.topAnchor.constraint(equalTo: self.view.topAnchor),
            sideBarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            sideBarView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            sideBarView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.23)
        ])
        
        // ------------------------------
        
        topBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBar)

        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            topBar.heightAnchor.constraint(equalToConstant: 70)
        ])

        // Hook up button actions
        topBar.saveButton.target = self
        topBar.saveButton.action = #selector(saveTapped)
        
        // ------------------------------
        
        invoiceView.wantsLayer = true
        invoiceView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(invoiceView)
        
        NSLayoutConstraint.activate([
            invoiceView.topAnchor.constraint(equalTo: topBar.bottomAnchor),
//            invoiceView.leadingAnchor.constraint(equalTo: sideBarView.trailingAnchor),
            invoiceView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            invoiceView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            invoiceView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
        // ------------------------------
    }
    
}

extension ViewController {
    
    @objc func saveTapped() {
        invoiceView.saveTapped()
    }
    
}

// delegates
extension ViewController: SidebarDelegate {
    
    // sidebar
    func sidebartapped(_ item: SidebarItem) {
        switch item {
        case .dashboard:
            print("")
        case .invoiceBill:
            invoiceView.isHidden = false
        case .clientVendor:
            print("")
        case .items:
            invoiceView.isHidden = true
        case .payments:
            print("")
        case .reports:
            print("")
        case .settings:
            print("")
        }
    }
    
}
