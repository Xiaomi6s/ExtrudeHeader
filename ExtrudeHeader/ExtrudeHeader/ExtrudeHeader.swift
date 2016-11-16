//
//  ExtrudeHeader.swift
//  ExtrudeHeader
//
//  Created by rxj on 2016/11/16.
//  Copyright © 2016年 renxiaojian. All rights reserved.
//

import UIKit
import SnapKit

typealias ExtrClosure = (ExtrudeHeader) ->Void

class ExtrudeHeader: UIView {
    
    
    var backImage: UIImage? {
        didSet{
            guard backImage != nil else {
                return
            }
            backImgView.image = backImage
            imgheight =  (scrollView?.frame.width)! * (backImage?.size.height)! / (backImage?.size.width)!
            heightConstraint?.update(inset: imgheight)
            
            
        }
    }
    weak var scrollView: UIScrollView? {
        didSet{
            scrollView?.addSubview(self)
            scrollView?.contentInset.top = headerHeight
        }
    }
    private var isZoom: Bool = false {
        didSet{
            if isZoom != oldValue {
                isZoomDidChange()
            }
        }
    }
    private var backImgView: UIImageView!
    private var headerHeight: CGFloat
    private var imgheight: CGFloat = 0
   
    private var heightConstraint: Constraint?
    override init(frame: CGRect) {
        headerHeight = frame.height
        super.init(frame: frame)
        backgroundColor = UIColor.purple
        setupUI()
        
        
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeObserver()
        print("ExtrudeHeader deinit")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview is UIScrollView {
            addObserver()
        }
    }
    
    private func setupUI() {
        backImgView = UIImageView()
        backImgView.contentMode = .scaleAspectFill
        addSubview(backImgView)
        backImgView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            self.heightConstraint = make.height.equalTo(headerHeight).constraint
            
        }
    }
     func headerClosure(_ closure: ExtrClosure) {
            closure(self)
        
    }
    
    private func addObserver() {
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        scrollView?.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    private func removeObserver() {
        scrollView?.removeObserver(self, forKeyPath: "contentOffset")
        scrollView?.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset" {
            scrollViewDidChange()
            
        } else if keyPath == "contentSize" {
            frame = CGRect(x: frame.minX, y: frame.minY, width: (scrollView?.frame.width)!, height: headerHeight)
            
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    private func scrollViewDidChange() {
        if (scrollView?.contentOffset.y)! <= CGFloat(-imgheight){
            isZoom = true
        } else {
            isZoom = false
        }
        var height = (scrollView?.contentOffset.y)! + headerHeight
        height = abs(height) + headerHeight
        let rect = CGRect(x: frame.minX, y:  -height, width: frame.width, height: height)
        frame = rect
        
    }
    
    private func isZoomDidChange() {
        if isZoom {
            backImgView.snp.remakeConstraints({ (make) in
                make.edges.equalToSuperview()
                
            })
            
        } else {
            backImgView.snp.remakeConstraints({ (make) in
                make.bottom.equalToSuperview()
                make.left.right.equalToSuperview()
                make.height.equalTo(imgheight)
                
            })
        }
    }
    
}
