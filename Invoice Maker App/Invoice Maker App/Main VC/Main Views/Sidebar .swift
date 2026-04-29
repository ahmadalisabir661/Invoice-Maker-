//
//  Sidebar .swift
//  Invoice Maker App
//
//  Created by Dev-Mac on 2026-04-29.
//

import Cocoa

struct SidebarItemModel {
    let image : NSImage
    let titleText : String
}

class Sidebar: NSView {

    var titleText : NSTextField!
    var itemsCV = NSCollectionView()
    
    var items : [SidebarItemModel] = [
        SidebarItemModel(image: .dashboardIcon, titleText: "Dashboard"),
        SidebarItemModel(image: .invoiceIcon, titleText: "Invoices"),
        SidebarItemModel(image: .clientsIcon, titleText: "Clients"),
        SidebarItemModel(image: .paymentIcon, titleText: "Payments"),
        SidebarItemModel(image: .reportsIcon, titleText: "Reports"),
        SidebarItemModel(image: .settingsIcon, titleText: "Settings"),
    ]
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        wantsLayer = true
        layer?.backgroundColor = NSColor.primaryNavy.cgColor
        
        titleText = NSTextField(labelWithString: "Invoice Maker")
        titleText.font = .systemFont(ofSize: 20, weight: .semibold)
        titleText.textColor = .textBlue
        self.addSubview(titleText)
        
        titleText.anchor(top: self.topAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        titleText.center(centerX: self.centerXAnchor, centerY: nil)
        
        // ----------------------------------
        
        let layout = NSCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        itemsCV.collectionViewLayout = layout
        itemsCV.dataSource = self
        itemsCV.delegate = self
        itemsCV.isSelectable = true
        itemsCV.register(SideBarItemsCVCell.self,
                         forItemWithIdentifier: SideBarItemsCVCell.identifier)
        itemsCV.backgroundColors = [.clear]

        let scrollView = NSScrollView()
        scrollView.documentView = itemsCV
        scrollView.hasVerticalScroller = true
        scrollView.drawsBackground = false

        addSubview(scrollView)

        scrollView.anchor(top: titleText.bottomAnchor, paddingTop: 50, bottom: bottomAnchor, paddingBottom: 0, left: leadingAnchor, paddingLeft: 0, right: trailingAnchor, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------

    }

}

extension Sidebar: NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: NSCollectionView,
                        itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {

        let item = collectionView.makeItem(withIdentifier: SideBarItemsCVCell.identifier,for: indexPath) as! SideBarItemsCVCell

        return item
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {

      return NSSize(width: collectionView.frame.size.width, height: 40)
    }
    
}
