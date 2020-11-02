//
//  ViewController.swift
//  ExtrudeHeader
//
//  Created by rxj on 2016/11/16.
//  Copyright © 2016年 renxiaojian. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDelegate {

    var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain);
        self.tableview.dataSource = self;
        self.tableview.delegate = self;
        self.view.addSubview(self.tableview);
        self.tableview.snp.makeConstraints { (make) in
            make.edges.equalToSuperview();
        }
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

extension ViewController: UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        cell?.textLabel?.text = "cell\(indexPath.row)"
        return cell!
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

