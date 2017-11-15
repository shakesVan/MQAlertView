//
//  MQAlertView.swift
//  MQAlertView_Example
//
//  Created by fanyao on 2017/11/15.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import MQAlertView

extension MQAlertView {
    open func setupViews(event: @escaping () -> Void) {
        getBtnCancel().setTitleColor(.gray, for: .normal)
        getBtnCancel().setTitle("cancel", for: .normal)
        btnDoneClick = event
    }
}

