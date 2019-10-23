//
//  SFHomeCell.swift
//  swift实践
//
//  Created by mac on 2019/10/9.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Kingfisher

// MARK:---闭包的定义---
// 购买按钮的闭包回调声明   1.定义一个闭包类型
typealias ClickBuyBtnBlock = (_ tag:Int) ->();


typealias ClickMoreBlock = (_ tag:Int , _ str:String) ->();

// MARK:---协议的定义---
protocol MyDategate {
    
    // 代理方法
    func degateNeedDo(str:String) -> ();
}



class SFHomeCell: UITableViewCell {

    
    
    public var titleLabel:UILabel?
    public var buyCarBtn:UIButton?;
    public var headImageView:UIImageView?
    
    
    // 声明代理
    var dategate:MyDategate?
    
    
    // 2. 声明一个闭包变量
    private var clickBuyBtnBlock:ClickBuyBtnBlock?;
    
    private var clickMoreBlock:ClickMoreBlock?;
    
    
    // 3. 定义一个方法,方法的参数为和ClickBuyBtnBlock类型一致的闭包,并赋值给callBack  逃逸闭包
    func callBackBlock(block: @escaping ClickBuyBtnBlock) {
        clickBuyBtnBlock = block
    }
    
    func callMoreBlock(block: @escaping ClickMoreBlock) {
        
        clickMoreBlock = block;
    }
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style:style, reuseIdentifier:reuseIdentifier);
        
        self.titleLabel = UILabel();
        self.titleLabel?.frame = CGRect.init(x: 0, y: 0, width: 90, height: 50);
        self.titleLabel?.backgroundColor = UIColor.green;
        self.contentView.addSubview(titleLabel!);
        
        
        self.buyCarBtn = UIButton.init(type: UIButton.ButtonType.system);
        self.buyCarBtn?.frame = CGRect.init(x: 100, y: 0, width: 50, height: 50);
        self.buyCarBtn?.setTitle("购买", for: UIControl.State.normal);
        self.buyCarBtn?.addTarget(self, action: #selector(buyCarBtnAction), for: UIControl.Event.touchUpInside);
        self.contentView.addSubview(self.buyCarBtn!);
        
        
        self.headImageView = UIImageView();
        headImageView?.isUserInteractionEnabled = true;
        headImageView?.backgroundColor = UIColor.purple;
        self.contentView.addSubview(headImageView!);
        headImageView?.snp.makeConstraints({ (make) in
            
            make.top.equalToSuperview().offset(10);
            make.right.equalToSuperview().offset(-10);
            make.width.height.equalTo(60);
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:(按钮的点击)类似OC中的pragma mark
    @objc func buyCarBtnAction()  {
        
        print("点击了购买");
        if self.clickBuyBtnBlock != nil  { // 如果这个闭包存在则回调
            
            self.clickBuyBtnBlock?(2);
        }
        
        
        
        if self.clickMoreBlock != nil {
            
            self.clickMoreBlock?(10, "我是字符串");
        }
        
        // 调用代理方法
        if self.dategate != nil {
            
            dategate?.degateNeedDo(str: "代理方法过来的");
        }
        
        
    }
    
    // MARK:(外部调用方法)
    func configDicData(_ data:Dictionary<String, Any>) -> () {
        
        self.titleLabel?.text = data["title"] as?String;
        self.headImageView?.kf.setImage(with: URL.init(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1570700856044&di=bf3fbf3b5c0132920626a2039d874269&imgtype=0&src=http%3A%2F%2Fpic23.nipic.com%2F20120823%2F10717094_095551546198_2.jpg"), placeholder: nil, options: nil, progressBlock: { (a, b) in
            
        }, completionHandler: { (image, err, cacheType, url) in
            
        });
    }
    
}
