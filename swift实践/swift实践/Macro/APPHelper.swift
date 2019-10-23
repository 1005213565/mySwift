//
//  APPHelper.swift
//  swift实践
//
//  Created by mac on 2019/10/10.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class APPHelper: NSObject {

    // 单例的写法
    static let shared = APPHelper();
    
    // 是否已经登录
    var isLogin:Bool?{
        
        set{

            UserDefaults.standard.set(newValue, forKey: APPStorageName.isLogin);
            UserDefaults.standard.synchronize();
        }
        
        
        
        get {
            
            let isLogin = UserDefaults.standard.bool(forKey: APPStorageName.isLogin)
            
            return isLogin;
        }
    }
    
    // 用户信息
    var loginUserModel:SFLoginUserModel? {
        
        set{
        
            newValue?.saveObject();
        }
        
        get {
            
            return SFLoginUserModel.getLoginUserModel();
        }
    }
    
    // 域名url
    var homeUrl:String = "http://gw-debug.istarguide.com"
    
    // MARK:---方法---
    // 设置是否使用线上环境，默认是测试环境
    func useIsDistribution(useDis:Bool) -> () {
        
        if useDis {
            
            self.homeUrl = "https://gw-prod.istarguide.com";
        }else {
            
            self.homeUrl = "http://gw-debug.istarguide.com";
        }
    }
}
