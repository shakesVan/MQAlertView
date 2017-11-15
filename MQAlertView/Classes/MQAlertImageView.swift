//
//  MQAlertImageView.swift
//  BaoLi
//
//  Created by fanyao on 2017/11/6.
//  Copyright © 2017年 AbbyNie. All rights reserved.
//

import Foundation
import UIKit

public class MQAlertImageView: UIView, MQAlertProtocol {
    // Declare the protocol controls
    lazy public var backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black
        return backgroundView
    }()
    lazy public var dialogView: UIView = {
        let dialogView = UIView()
        dialogView.backgroundColor = .white
        return dialogView
    }()
    public var appearFrom: AppearFrom = .bottom
    public var clearBackground = false
    
    private lazy var imageView: UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFit
        imgV.backgroundColor = .black
        return imgV
    }()
    
    
    private lazy var isSetupUI: Bool? = {
        self.setupUI()
        return true
    }()
    
    private func setupUI() {
        
        frame = UIScreen.main.bounds
        backgroundView.frame = frame
        addSubview(backgroundView)
        addSubview(dialogView)
        dialogView.frame = frame
        
        dialogView.addSubview(imageView)
        imageView.frame = dialogView.frame
        
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 1
        tap.addTarget(self, action: #selector(cancelBtnClick))
        addGestureRecognizer(tap)
        
    }
    
    @objc private func cancelBtnClick() {
        //隐藏self
        dismiss(animated: false)
        print("cancelBtnClick")
    }
    
    public func getImageView() -> UIImageView{
        return imageView
    }
    
    deinit {
        print("MQAlertImageView deinit")
    }
    
    public convenience init() {
        self.init(frame: CGRect())
        _ = isSetupUI
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
