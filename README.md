# ExtrudeHeader
下拉放大背景
using

tableview.addExtrudeHeader(ofImage: #imageLiteral(resourceName: "mm"), height: 160, closure: { (header) in
    let view = UIView()
    view.backgroundColor = UIColor.red
    header.addSubview(view)
    view.snp.makeConstraints({ (make) in
        make.bottom.equalTo(-60)
        make.height.width.equalTo(60)
        make.centerX.equalToSuperview()
    })
})

