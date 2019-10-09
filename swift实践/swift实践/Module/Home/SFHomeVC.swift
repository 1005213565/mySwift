//
//  SFHomeVC.swift
//  swift实践
//
//  Created by mac on 2019/10/9.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class SFHomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    lazy var homeTableView:UITableView = {
        
    
        let tableView = UITableView.init(frame:CGRect.init(x: 0, y: 0, width:APPFrme.ScreenWidth , height: APPFrme.ScreenHeight), style: UITableView.Style.grouped);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.register(SFHomeCell.classForCoder(), forCellReuseIdentifier: "cell");
        return tableView;
        
    }();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.green;
        self.navigationItem.title = "首页";
        
        self.view.addSubview(self.homeTableView);
    }



    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:SFHomeCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SFHomeCell;
        cell.titleLabel?.text = "哈哈";
        return cell;
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("点击了==\(indexPath)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60;
    }
}
