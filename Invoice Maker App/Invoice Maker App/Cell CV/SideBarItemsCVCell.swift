//
//  SideBarItemsCVCell.swift
//  Invoice Maker App
//
//  Created by Dev-Mac on 2026-04-29.
//

import Foundation
import Cocoa

class SideBarItemsCVCell: NSCollectionViewItem {

    static let identifier = NSUserInterfaceItemIdentifier("SideBarItemsCVCell")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.systemBlue.cgColor
        view.layer?.cornerRadius = 10

        setupUI()
    }

    private func setupUI() {
//        let label = NSTextField(labelWithString: "Item")
//        label.textColor = .white
//        label.font = NSFont.systemFont(ofSize: 14, weight: .medium)
//
//        view.addSubview(label)
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
    }

}
