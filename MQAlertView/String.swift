//
//  String.swift
//  MQAlertView
//
//  Created by fanyao on 2017/11/15.
//

import Foundation

extension String {
    /// 返回文本高度
    ///
    /// - Parameters:
    ///   - width: 文本宽度
    ///   - font: 文本字体
    /// - Returns: 文本占高度
    public func height(with width: CGFloat ,font:UIFont) -> CGFloat {
        let calString = self as NSString
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let attributes = [NSAttributedStringKey.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        
        let boundingBox = calString.boundingRect(with: constraintRect, options: option, attributes: attributes, context: nil)
        return boundingBox.height
    }
}
