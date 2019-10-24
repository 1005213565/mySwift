//
//  SFLoginVC.swift
//  swift实践
//
//  Created by mac on 2019/10/10.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import HandyJSON
import NVActivityIndicatorView

class SFLoginVC: UIViewController,NVActivityIndicatorViewable {

    lazy var accountTF:UITextField = {
    
        var tf = UITextField();
        tf.backgroundColor = UIColor.green;
        tf.placeholder = "请输入账号";
        return tf;
    }();
    
    lazy var passwordTF:UITextField = {
        
        var tf = UITextField();
        tf.backgroundColor = UIColor.red;
        tf.placeholder = "请输入密码";
        return tf;
    }();
    
    lazy var loginBtn:UIButton = {
        
        var btn = UIButton.init(type: .system);
        btn.setTitle("登录", for: UIControl.State.normal);
        btn.backgroundColor = UIColor.blue;
        btn.addTarget(self, action: #selector(loginBtnAction), for: .touchUpInside);
        
        return btn;
    }();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createUI();
    }

    // MARK:---私有方法---
    //
    func createUI() -> () {
        
        self.view.addSubview(accountTF);
        accountTF.snp.makeConstraints { (make) in
            
            make.left.equalToSuperview().offset(80);
            make.top.equalToSuperview().offset(200);
            make.right.equalToSuperview().offset(-80);
            make.height.equalTo(40);
        }
        
        self.view.addSubview(passwordTF);
        passwordTF.snp.makeConstraints { (make) in
            
            make.left.equalToSuperview().offset(80);
            make.top.equalTo(accountTF.snp_bottom).offset(20);
            make.right.equalToSuperview().offset(-80);
            make.height.equalTo(40);
        }
        
        self.view.addSubview(loginBtn);
        loginBtn.snp.makeConstraints { (make) in
            
            make.left.equalToSuperview().offset(80);
            make.right.equalToSuperview().offset(-80);
            make.height.equalTo(40);
            make.top.equalTo(passwordTF.snp_bottom).offset(40);
        }
    }
    
    
    // MARK:---按钮的点击方法---
    @objc func loginBtnAction() {
        
        requestLogin(APPHelper.shared.homeUrl + APPURL.SFLoginUrl, ["mobile":"18392475589","password":"8a6f2805b4515ac12058e79e66539be9","zone":"86"]);
        
        
    }
    
    // 我打了tag标签
    
    // MARK:---网络请求---
    // 登录
    func requestLogin(_ url:String, _ par:[String:Any]) -> () {
        
        startAnimating();
        SFBaseNetworking.requstData(.post, url: url, parameters:par) { (response: Any, isSuccess: Bool) in
            
            self.stopAnimating();
            
            if isSuccess {
                
                
                let code = (response as! Dictionary<String,Any>)["code"];
                
                if code != nil && code as! Int == 0 { // 将code转换为Int类型
                    
                    var tempData:Dictionary<String,Any> = response as! Dictionary<String,Any>
                    let tempDic = tempData["data"];
                    
                    // 使用HandyJSON将字典转换为model
                    let loginModel = SFLoginUserModel.deserialize(from: (tempDic as! Dictionary<String,Any>));
                    // 存储用户登录信息
                    APPHelper.shared.loginUserModel = loginModel;
                    
                    
                    // 登录成功本地存储登录成功
                    APPHelper.shared.isLogin = true;
                    
                    print("转换成功的model==\(String(describing: loginModel?.id!)) \(String(describing: loginModel?.gender)) \(String(describing: loginModel?.nick))");
                    
                    let tabBarVC = SFTabBarController();
                    UIApplication.shared.delegate?.window??.rootViewController = tabBarVC;
                    
                }
            }
        }

    }
}

















