//
//  ButtonsBarView.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/28/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit
import SwiftEntryKit

struct ButtonsBarContent {
    let leading: EKProperty.ButtonContent
    let trailing: EKProperty.ButtonContent
}

class ButtonsBarView: UIView {
    
    typealias Action = () -> ()

    // MARK: Props
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var approveButton: UIButton!
    
    var approveAction: Action!
    
    var buttonsContent: ButtonsBarContent! {
        didSet {
            set(button: closeButton, with: buttonsContent.leading)
            set(button: approveButton, with: buttonsContent.trailing)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
    }
    
    init() {
        super.init(frame: .zero)
        fromNib()
    }
    
    private func set(button: UIButton, with content: EKProperty.ButtonContent) {
        button.setTitle(content.label.text, for: .normal)
        button.setTitleColor(content.label.style.color, for: .normal)
        button.titleLabel?.font = content.label.style.font
        button.backgroundColor = content.backgroundColor
    }
    
    private func setBackground(for button: UIButton, by content: EKProperty.ButtonContent) {
        button.backgroundColor = content.backgroundColor
    }
    
    // MARK: Actions
    
    @IBAction func leftButtonTouchUpInside() {
        SwiftEntryKit.dismiss()
    }
    
    @IBAction func rightButtonTouchUpInside() {
        approveAction?()
    }
    
    @IBAction func buttonTouchDown(_ button: UIButton) {
        button.backgroundColor = button.titleColor(for: .normal)!.withAlphaComponent(0.05)
    }
    
    @IBAction func buttonTouchUp(_ button: UIButton) {
        setBackground(for: button, by: button == closeButton ? buttonsContent.leading : buttonsContent.trailing)
    }
}