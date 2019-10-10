//
//  SFHomeVC.swift
//  swift实践
//
//  Created by mac on 2019/10/9.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Kingfisher

class SFHomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource,MyDategate {

    lazy var homeTableView:UITableView = {
        
    
        let tableView = UITableView.init(frame:CGRect.init(x: 0, y: 0, width:APPFrme.ScreenWidth , height: APPFrme.ScreenHeight), style: UITableView.Style.grouped);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.register(SFHomeCell.classForCoder(), forCellReuseIdentifier: "cell");
        return tableView;
        
    }();
    
    // 所有数据
    var allArr:Array<Any> = Array();
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.green;
        self.navigationItem.title = "首页";
        
        self.view.addSubview(self.homeTableView);
        requestAllData();
        
        // 设置导航栏右侧按钮
        
        let rightBtn0 = UIBarButtonItem.init(title: "刷新", style: .plain, target: self, action: #selector(refreshData));
        let rightBtn1 = UIBarButtonItem.init(title: "加载", style: .plain, target: self, action: #selector(loadMoreData));
        
        
        self.navigationItem.rightBarButtonItems = [rightBtn0,rightBtn1];
    }

    // MARK:---数据请求---
    func requestAllData() -> () {
        
        
        for i in 0..<10 {
            
            print("\(i)");
            
            var tempDic:Dictionary = [String:Any]();
            tempDic["title"] = "石峰"+String(i);
            
            self.allArr.append(tempDic)
        }
        
        self.homeTableView.reloadData();
        print("最终数据=\(self.allArr)")
    }
    

    //MARK:---tableview的代理方法---
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.allArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:SFHomeCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SFHomeCell;
        cell.selectionStyle = .none;
        cell.dategate = self as MyDategate; // 设置代理方法
        
        let tempDic = self.allArr[indexPath.row];
        cell.configDicData(tempDic as! Dictionary);
        
        cell.callBackBlock { (tag) in
            
            print("闭包传递的数据\(tag)")
        }
        
        cell.callMoreBlock { (tag, str) in
            
            print("两个参数\(tag)  \(str)")
        }
        
        return cell;
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("点击了==\(indexPath)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100;
    }
    
    // MARK:---MyDategate---
    func degateNeedDo(str: String) {
        
        print("走了代理方法=\(str)")
    }
    
    
    // MARK:---按钮的点击方法---
    // 刷新按钮
    @objc func refreshData() {
        
        print("点击了刷新");
        self.allArr.removeAll();
        requestAllData();
    }
    
    // 加载更多按钮
    @objc func loadMoreData() {
        
        print("点击了加载更多数据")
        requestAllData();
    }
}
