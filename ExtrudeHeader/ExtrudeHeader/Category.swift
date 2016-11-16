//
//  Category.swift
//  ExtrudeHeader
//
//  Created by rxj on 2016/11/16.
//  Copyright © 2016年 renxiaojian. All rights reserved.
//

import Foundation
import UIKit

var extrudeHeaderKey: Void?
extension UIScrollView {
    func addExtrudeHeader(ofImage image: UIImage?, height: CGFloat, closure: @escaping ExtrClosure) {
       let extrudeHeader = ExtrudeHeader(frame: CGRect(x: 0, y: -height, width: frame.width, height: height))
        extrudeHeader.scrollView = self
        extrudeHeader.backImage = image
        extrudeHeader.headerClosure(closure)
    }
    
}
