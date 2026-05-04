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

enum SidebarItem {
    case dashboard
    case invoiceBill
    case clientVendor
    case payments
    case reports
    case settings
}

protocol SidebarDelegate : AnyObject {
    func sidebartapped(_ item: SidebarItem)
}

class Sidebar: NSView {
    
    weak var delegate: SidebarDelegate?
    
    var titleText : NSTextField!
    var itemsCV = NSCollectionView()
    
    var itemsCVList : [SidebarItemModel] = [
        SidebarItemModel(image: .dashboardIcon, titleText: "Dashboard"),
        SidebarItemModel(image: .invoiceIcon, titleText: "Create Invoice"),
        SidebarItemModel(image: .invoiceIcon, titleText: "Create Bill"),
        SidebarItemModel(image: .clientsIcon, titleText: "Clients/Vendors"),
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
        titleText.font = .systemFont(ofSize: 30, weight: .medium)
        titleText.textColor = .textBlue
        self.addSubview(titleText)
        
        titleText.anchor(top: self.topAnchor, paddingTop: 40, bottom: nil, paddingBottom: 0, left: self.leadingAnchor, paddingLeft: 20, right: nil, paddingRight: 0, width: 0, height: 0)
        
        // ----------------------------------
        
        let layout = NSCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        itemsCV.collectionViewLayout = layout
        itemsCV.dataSource = self
        itemsCV.delegate = self
        itemsCV.isSelectable = true
        itemsCV.allowsEmptySelection = false
        itemsCV.register(SideBarItemsCVCell.self, forItemWithIdentifier: SideBarItemsCVCell.identifier)
        itemsCV.backgroundColors = [.clear]
        
        let scrollView = NSScrollView()
        scrollView.documentView = itemsCV
        scrollView.hasVerticalScroller = true
        scrollView.drawsBackground = false
        
        addSubview(scrollView)
        
        scrollView.anchor(top: titleText.bottomAnchor, paddingTop: 50, bottom: bottomAnchor, paddingBottom: 0, left: leadingAnchor, paddingLeft: 20, right: trailingAnchor, paddingRight: 20, width: 0, height: 0)
        
        // ----------------------------------
        
    }
    
}

extension Sidebar: NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsCVList.count
    }
    
    func collectionView(_ collectionView: NSCollectionView,
                        itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let cell = collectionView.makeItem(withIdentifier: SideBarItemsCVCell.identifier,for: indexPath) as! SideBarItemsCVCell
        let item = itemsCVList[indexPath.item]
        cell.titleText.stringValue = item.titleText
        cell.titleImage.image = item.image
        cell.titleImage.image?.isTemplate = true
        cell.titleImage.contentTintColor = .textGray
        return cell
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        
        return NSSize(width: collectionView.frame.size.width, height: 65)
    }
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        guard let indexPath = indexPaths.first else { return }
        
        switch indexPath.item {
        case 0:
            print("")
        case 1:
            delegate?.sidebartapped(.invoiceBill)
        case 2:
            print("")
        case 3:
            print("")
        case 4:
            print("")
        case 5:
            print("")
        case 6:
            print("")
        default:
            print("")
        }
    }
    
}
