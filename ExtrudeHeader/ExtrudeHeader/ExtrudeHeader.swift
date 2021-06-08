//
//  ExtrudeHeader.swift
//  SwiftDemo1
//
//  Created by rxj on 2021/6/8.
//

import UIKit
import SnapKit

typealias HeaderClosure = (ExtrudeHeader) -> Void

protocol ExtrudeProtocol {
    func addExtrudeHeader(ofImage image: UIImage?, height: CGFloat, _ closure: @escaping HeaderClosure)
}

extension UIScrollView: ExtrudeProtocol {
    func addExtrudeHeader(ofImage image: UIImage?,
                          height: CGFloat,
                          _ closure: @escaping HeaderClosure) {
        let extrudeHeader = ExtrudeHeader(frame: CGRect(x: 0, y: -height, width: UIScreen.main.bounds.width, height: height))
         extrudeHeader.scrollView = self
         extrudeHeader.backImage = image
         extrudeHeader.headerClosure(closure)
    }
}

class ExtrudeHeader: UIView {
    
    private var headerHeight: CGFloat = 0.0
    var backImage: UIImage? {
        didSet {
            guard backImage != nil else {
                return
            }
            backImgView.image = backImage
        }
    }
    private var backImgView: UIImageView!
    weak var scrollView: UIScrollView? {
        didSet {
            scrollView?.addSubview(self)
            scrollView?.contentInset.top = headerHeight
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.headerHeight = frame.height
        backgroundColor = .purple
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        backImgView.layer.masksToBounds = true
        addSubview(backImgView)
        backImgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func headerClosure(_ closure: HeaderClosure) {
        closure(self)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset" {
            scrollViewDidChange()
        }
    }
    
    private func scrollViewDidChange() {
        guard let scrollView = scrollView else {
            return
        }
        let offsetY = scrollView.contentOffset.y
        print("\(offsetY)")
        if (offsetY <= 0.0) {
            var frame = self.frame;
            frame.origin.y = offsetY;
            frame.size.height = -offsetY;
            self.frame = frame;
        }
    }
    
    private func addObserver() {
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
    }
    private func removeObserver() {
        scrollView?.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    deinit {
        removeObserver()
        print("ExtrudeHeader deinit")
    }
    
}
