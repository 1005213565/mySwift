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
        
        set(isLogin){
            
            UserDefaults.standard.set(isLogin, forKey: APPStorageName.isLogin);
            UserDefaults.standard.synchronize();
        }
        
        get {
            
            let isLogin = UserDefaults.standard.bool(forKey: APPStorageName.isLogin)
            
            return isLogin;
        }
    }
    
}
