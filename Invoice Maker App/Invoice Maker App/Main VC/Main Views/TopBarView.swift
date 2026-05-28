//
//  TopBarView.swift
//  Invoice Maker App
//
//  Created by Dev-Mac on 2026-05-23.
//

import Foundation
import Cocoa

class TopBarView: NSView {

    // MARK: - Views
    var titleLabel       : NSTextField!
    var draftBadge       = NSView()
    var draftLabel       : NSTextField!
    var subtitleLabel    : NSTextField!
    var autoSavedIcon    = NSImageView()
    var autoSavedLabel   : NSTextField!
    var saveButton       = NSButton()
    var shareButton      = NSButton()
    var uploadButton     = NSButton()
    var moreButton       = NSButton()

    // MARK: - Init
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Setup
    func setup() {
        wantsLayer = true
        layer?.backgroundColor = NSColor.clear.cgColor
        layer?.borderColor = NSColor.blueBorder.cgColor
        layer?.borderWidth = 1.5
        layer?.cornerRadius = 15
        
        setupTitleSection()
        setupRightSection()
    }

    // MARK: - Title Section (left side)
    private func setupTitleSection() {

        // "Invoice" label
        titleLabel = NSTextField(labelWithString: "Invoice")
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        // "Draft" badge
        draftBadge.wantsLayer = true
        draftBadge.isHidden = true
        draftBadge.layer?.backgroundColor = NSColor.white.withAlphaComponent(0.1).cgColor
        draftBadge.layer?.borderColor = NSColor.white.withAlphaComponent(0.2).cgColor
        draftBadge.layer?.borderWidth = 1
        draftBadge.layer?.cornerRadius = 10
        draftBadge.translatesAutoresizingMaskIntoConstraints = false
        addSubview(draftBadge)

        draftLabel = NSTextField(labelWithString: "Draft")
        draftLabel.font = .systemFont(ofSize: 11, weight: .medium)
        draftLabel.textColor = .white.withAlphaComponent(0.7)
        draftLabel.translatesAutoresizingMaskIntoConstraints = false
        draftBadge.addSubview(draftLabel)

        // "Invoice #INV-2024-0001" subtitle
        let year = Calendar.current.component(.year, from: Date())
        var invoiceNumber = "INV-\(year)-0001"
        subtitleLabel = NSTextField(labelWithString: invoiceNumber)
        subtitleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        subtitleLabel.textColor = .white.withAlphaComponent(0.5)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            // Title label — top left after back button
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),

            // Draft badge — right of title, vertically centered with it
            draftBadge.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            draftBadge.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            draftBadge.heightAnchor.constraint(equalToConstant: 20),
            draftBadge.widthAnchor.constraint(equalToConstant: 44),

            // Draft label centered inside badge
            draftLabel.centerXAnchor.constraint(equalTo: draftBadge.centerXAnchor),
            draftLabel.centerYAnchor.constraint(equalTo: draftBadge.centerYAnchor),

            // Subtitle below title
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
        ])
    }

    // MARK: - Right Section
    private func setupRightSection() {

        // ── Auto-saved indicator ─────────────────────────
        autoSavedIcon.image = NSImage(systemSymbolName: "checkmark.circle.fill",
                                       accessibilityDescription: nil)
        autoSavedIcon.contentTintColor = NSColor.systemGreen
        autoSavedIcon.isHidden = true
        autoSavedIcon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(autoSavedIcon)

        autoSavedLabel = NSTextField(labelWithString: "Auto-saved")
        autoSavedLabel.font = .systemFont(ofSize: 13, weight: .regular)
        autoSavedLabel.textColor = .white.withAlphaComponent(0.6)
        autoSavedLabel.isHidden = true
        autoSavedLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(autoSavedLabel)

        // ── Save button ───────────────────────────────────
        saveButton = makeActionButton(
            title: "Save",
            icon: "square.and.arrow.down",
            style: .filled
        )
        addSubview(saveButton)

        // ── Share button ──────────────────────────────────
        shareButton = makeActionButton(
            title: "Share",
            icon: "square.and.arrow.up",
            style: .outlined
        )
        addSubview(shareButton)

        // ── Upload to Cloud button ────────────────────────
        uploadButton = makeActionButton(
            title: "Upload to Cloud",
            icon: "icloud.and.arrow.up",
            style: .purple
        )
        addSubview(uploadButton)

        // ── More (⋮) button ───────────────────────────────
        moreButton.image = NSImage(systemSymbolName: "ellipsis",
                                    accessibilityDescription: nil)
        moreButton.bezelStyle = .inline
        moreButton.isBordered = false
        moreButton.isHidden = true
        moreButton.contentTintColor = .white.withAlphaComponent(0.7)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(moreButton)

        NSLayoutConstraint.activate([

            // More button — pinned to far right
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            moreButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            moreButton.widthAnchor.constraint(equalToConstant: 28),
            moreButton.heightAnchor.constraint(equalToConstant: 28),

            // Upload button — left of more
            uploadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            uploadButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            uploadButton.heightAnchor.constraint(equalToConstant: 34),
            uploadButton.widthAnchor.constraint(equalToConstant: 140),

            // Share button — left of upload
            shareButton.trailingAnchor.constraint(equalTo: uploadButton.leadingAnchor, constant: -10),
            shareButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            shareButton.heightAnchor.constraint(equalToConstant: 34),
            shareButton.widthAnchor.constraint(equalToConstant: 80),

            // Save button — left of share
            saveButton.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -10),
            saveButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 34),
            saveButton.widthAnchor.constraint(equalToConstant: 70),

            // Auto-saved label — left of save
            autoSavedLabel.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: -16),
            autoSavedLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            // Auto-saved icon — left of label
            autoSavedIcon.trailingAnchor.constraint(equalTo: autoSavedLabel.leadingAnchor, constant: -5),
            autoSavedIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            autoSavedIcon.widthAnchor.constraint(equalToConstant: 16),
            autoSavedIcon.heightAnchor.constraint(equalToConstant: 16),
        ])
    }

    // MARK: - Button Factory
    private func makeActionButton(title: String, icon: String, style: ButtonStyle) -> NSButton {
        let button = NSButton()
        button.title = ""
        button.bezelStyle = .inline
        button.isBordered = false
        button.wantsLayer = true
        button.layer?.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false

        // Icon + title using attributed string
        let iconImage = NSImage(systemSymbolName: icon, accessibilityDescription: nil)
        let config    = NSImage.SymbolConfiguration(pointSize: 12, weight: .medium)
        let tintedIcon = iconImage?.withSymbolConfiguration(config)

        let attachment = NSTextAttachment()
        attachment.image = tintedIcon

        let iconString = NSMutableAttributedString(attachment: attachment)
        let titleString = NSAttributedString(
            string: "  \(title)",
            attributes: [
                .foregroundColor: NSColor.white,
                .font: NSFont.systemFont(ofSize: 13, weight: .medium)
            ]
        )
        iconString.append(titleString)
        button.attributedTitle = iconString

        switch style {
        case .filled:
            button.layer?.backgroundColor = NSColor(hex: "2563EB").cgColor
        case .outlined:
            button.layer?.backgroundColor = NSColor.clear.cgColor
            button.layer?.borderColor = NSColor(hex: "2563EB").cgColor
            button.layer?.borderWidth = 1
        case .purple:
            button.layer?.backgroundColor = NSColor.clear.cgColor
            button.layer?.borderColor = NSColor(hex: "7C3AED").cgColor
            button.layer?.borderWidth = 1
        }

        return button
    }

    enum ButtonStyle {
        case filled, outlined, purple
    }
}

// MARK: - NSColor hex helper (add once in your project)
extension NSColor {
    convenience init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexString = hexString.hasPrefix("#") ? String(hexString.dropFirst()) : hexString
        var rgb: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgb)
        let r = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let g = CGFloat((rgb >> 08) & 0xFF) / 255.0
        let b = CGFloat((rgb >> 00) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
