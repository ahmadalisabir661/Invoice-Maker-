//
//  BaseView.swift
//  Invoice Maker App
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
