//
//  MQAlertView.swift
//  AlertView
//
//  Created by Sowrirajan Sugumaran on 9/13/17.
//  Copyright © 2017 Sowrirajan Sugumaran. All rights reserved.
//

import UIKit

public enum MQAlertType {
    case text
    case input
}

public class MQAlertView: UIView, MQAlertProtocol {
    
    // Declare the protocol controls
    lazy public var backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        return backgroundView
    }()
    lazy public var dialogView: UIView = {
        let dialogView = UIView()
        dialogView.backgroundColor = UIColor.clear
        dialogView.layer.cornerRadius = 5
        dialogView.clipsToBounds = true
        return dialogView
    }()
    public var appearFrom: AppearFrom = .right
    public var clearBackground = Bool()
    public var btnDoneClick: (() -> Void)?
    
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        return titleLabel
    }()
    fileprivate lazy var messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        messageLabel.font = UIFont.systemFont(ofSize: 15)
        messageLabel.textAlignment = .center
        messageLabel.textColor = UIColor.darkGray
        messageLabel.sizeToFit()
        return messageLabel
    }()
    fileprivate lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.placeholder = "请输入..."
        textField.textColor = UIColor.gray
        textField.borderStyle = .none
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 0.5
        textField.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 0))
        //设置显示模式为永远显示(默认不显示)
        textField.leftViewMode = .always;
        return textField
    }()
    
    fileprivate lazy var btnCancel: UIButton = {
        let btnCancel = UIButton()
        btnCancel.backgroundColor =  UIColor.darkText
        btnCancel.setTitleColor(UIColor.white, for: .normal)
        btnCancel.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btnCancel.layer.cornerRadius = 5
        btnCancel.clipsToBounds = true
        return btnCancel
    }()
    
    fileprivate lazy var btnDone: UIButton = {
        let btnDone = UIButton()
        btnDone.backgroundColor =  UIColor.darkText
        btnDone.setTitleColor(UIColor.white, for: .normal)
        btnDone.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btnDone.layer.cornerRadius = 5
        btnDone.clipsToBounds = true
        return btnDone
    }()
    
    deinit {
        print("alertType deinit")
    }
    
    public convenience init(title: String,
                            alertType: MQAlertType,
                            message: String,
                            btnDoneTitle: String) {
        self.init(frame:UIScreen.main.bounds)
        self.initialise(title: title,
                        alertType: alertType,
                        message: message,
                        btnDoneTitle: btnDoneTitle)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func initialise(title: String,
                                alertType: MQAlertType,
                                message: String,
                                btnDoneTitle: String) {
        // get dynamic width for alertView and all controlls
        
        let dialogViewWidth: CGFloat = 270
        backgroundView.frame = self.frame
        addSubview(backgroundView)
        
        titleLabel.text = title
        titleLabel.frame.origin.y = 35
        titleLabel.center.x = 15
        titleLabel.frame.size = CGSize.init(width: dialogViewWidth - 30, height: 36)
        dialogView.addSubview(titleLabel)
        
        let contentVY: CGFloat = (titleLabel.frame.origin.y + titleLabel.frame.size.height + 15)
        var contentVW: CGFloat = 0
        var contentVH: CGFloat = 0
        if alertType == .text {
            messageLabel.text = message
            contentVW = dialogViewWidth - 30
            contentVH = messageLabel.text!.height(with: contentVW, font: messageLabel.font)
            messageLabel.frame = CGRect(x: 15, y: contentVY, width: contentVW, height: contentVH)
            dialogView.addSubview(messageLabel)
        }else {
            textField.placeholder = message
            contentVW = dialogViewWidth - 30
            contentVH = 45
            textField.frame = CGRect(x: 15, y: contentVY, width: contentVW, height: contentVH)
            dialogView.addSubview(textField)
        }
        
        let btnCancelW = (dialogViewWidth - 45) / 2
        btnCancel.addTarget(self, action: #selector(didButtonTapped), for: UIControlEvents.touchUpInside)
        btnCancel.frame = CGRect(x: 15, y: contentVY + contentVH + 20, width: btnCancelW, height:40)
        btnCancel.setTitle("取消", for: UIControlState.normal)
        dialogView.addSubview(btnCancel)
        btnDone.setTitle(btnDoneTitle, for: UIControlState.normal)
        btnDone.addTarget(self, action: #selector(didBtnDoneTappad), for: UIControlEvents.touchUpInside)
        btnDone.frame = btnCancel.frame
        btnDone.frame.origin.x = 15 + btnCancelW + 15
        dialogView.addSubview(btnDone)
        
        // set dynamic height for alert view and their controls
        let dialogViewHeight = btnDone.frame.maxY + 20
        dialogView.frame.origin = CGPoint(x: 32, y: frame.height)
        dialogView.frame.size = CGSize(width: dialogViewWidth, height: dialogViewHeight)
        
        if alertType == .text  {
            messageLabel.center = CGPoint(x: dialogView.frame.size.width / 2, y: dialogView.frame.size.height/2)
        }else {
            textField.center = CGPoint(x: dialogView.frame.size.width / 2, y: dialogView.frame.size.height/2)
        }
        
        self.createGradientLayer(view: dialogView, colorOne: UIColor.white, colorTwo: UIColor.white)
        addSubview(dialogView)
        
    }
    
    @objc private func didBtnDoneTappad() {
        btnDoneClick?()
        dismiss(animated: true)
    }
    
    // dismiss the alert view
    @objc private func didButtonTapped() {
        dismiss(animated: true)
    }
    
    // set gradient colors
    private func createGradientLayer(view:UIView, colorOne:UIColor, colorTwo:UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension MQAlertView {
    public convenience init(title: String,
                            message: String,
                            btnDoneTitle: String) {
        self.init(frame:UIScreen.main.bounds)
        self.initialise(title: title,
                        alertType: .text,
                        message: message,
                        btnDoneTitle: btnDoneTitle)
    }
    
    public convenience init(title: String,
                            placeholder: String,
                            btnDoneTitle: String) {
        self.init(frame:UIScreen.main.bounds)
        self.initialise(title: title,
                        alertType: .input,
                        message: placeholder,
                        btnDoneTitle: btnDoneTitle)
    }
}

extension MQAlertView {
    
    public func getTitleLabel() -> UILabel {
        return titleLabel
    }
    
    public func getMessageLabel() -> UILabel {
        return messageLabel
    }
    
    public func getBtnCancel() -> UIButton {
        return btnCancel
    }
    
    public func getBtnDone() -> UIButton {
        return btnDone
    }
    
    public func getTextField() -> UITextField {
        return textField
    }
}


