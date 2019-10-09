//
//  SFHomeCell.swift
//  swift实践
//
//  Created by mac on 2019/10/9.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class SFHomeCell: UITableViewCell {

    public var titleLabel:UILabel?
    public var buyCarBtn:UIButton?;
    
    
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:(按钮的点击)类似OC中的pragma mark
    @objc func buyCarBtnAction()  {
        
        print("点击了购买");
    }
    
}
