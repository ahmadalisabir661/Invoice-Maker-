//
//  BaseView.swift
//  Invoice Maker App
//
//  Created by Dev-Mac on 2026-05-10.
//

import Foundation
import Cocoa

class BaseView : NSView {
    
    func showAlert(title: String, message: String, style: NSAlert.Style = .informational) {
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = message
        alert.alertStyle = style
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
}
