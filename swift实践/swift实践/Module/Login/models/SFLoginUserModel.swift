//
//  SFLoginUserModel.swift
//  swift实践
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import HandyJSON

class SFLoginUserModel: NSObject, HandyJSON, NSCoding {

    var id:String?;
    var token:String?; // 请求数据时需要的token
    var nick:String?;
    var gender:String?; // 性别 1男 2女
    var avatar:String?; // 头像url
    var birthday:String?; // 生日
    var lastLoginTime:String?; // 最后登录时间
    var mobile:String?; // 电话
    var registerClientId:String?; // 注册监听id  sxyc04b6q
    var registerSource:String?; // 不知道干嘛的  返回的是0
    var rongcloudToken:String?; // 融云token
    var userInviteCode:String?; // 用户邀请码
    var username:String?; // 不知道干嘛的  返回的是68137082
    var uuid:String?; //
    var zone:String?; // 所在地区 中国86
    
    
    // MARK:---HandyJSON必须实现---
    // HandyJSON需要的
    required override init(){
        
        super.init()
    }
    
    
    // MARK:---归档和解档---
    // 编码object
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(id, forKey: "id");
        aCoder.encode(token, forKey: "token");
        aCoder.encode(nick, forKey: "nick");
        aCoder.encode(gender, forKey: "gender");
        aCoder.encode(avatar, forKey: "avatar");
        aCoder.encode(birthday, forKey: "birthday");
        aCoder.encode(lastLoginTime, forKey: "lastLoginTime");
        aCoder.encode(mobile, forKey: "mobile");
        aCoder.encode(registerClientId, forKey: "registerClientId");
        aCoder.encode(registerSource, forKey: "registerSource");
        aCoder.encode(rongcloudToken, forKey: "rongcloudToken");
        aCoder.encode(userInviteCode, forKey: "userInviteCode");
        aCoder.encode(username, forKey: "username");
        aCoder.encode(uuid, forKey: "uuid");
        aCoder.encode(zone, forKey: "zone");
    }
    
    // 解码
    required init?(coder aDecoder: NSCoder) {
        
        id = aDecoder.decodeObject(forKey: "id") as? String;
        token = aDecoder.decodeObject(forKey: "token") as? String;
        nick = aDecoder.decodeObject(forKey: "nick") as? String;
        gender = aDecoder.decodeObject(forKey: "gender") as? String;
        avatar = aDecoder.decodeObject(forKey: "avatar") as? String;
        birthday = aDecoder.decodeObject(forKey: "birthday") as? String;
        lastLoginTime = aDecoder.decodeObject(forKey: "lastLoginTime") as? String;
        mobile = aDecoder.decodeObject(forKey: "mobile") as? String;
        registerClientId = aDecoder.decodeObject(forKey: "registerClientId") as? String;
        registerSource = aDecoder.decodeObject(forKey: "registerSource") as? String;
        rongcloudToken = aDecoder.decodeObject(forKey: "rongcloudToken") as? String;
        userInviteCode = aDecoder.decodeObject(forKey: "userInviteCode") as? String;
        username = aDecoder.decodeObject(forKey: "username") as? String;
        uuid = aDecoder.decodeObject(forKey: "uuid") as? String;
        zone = aDecoder.decodeObject(forKey: "zone") as? String;
        super.init();
    }
    
    
    
    
    
    
    // MARK:---外部接口---
    // 保存数据
    func saveObject() -> Void {
        
        // 序列化
        let data = NSKeyedArchiver.archivedData(withRootObject: self);
        // 存储到本地
        let def = UserDefaults.standard;
        def.set(data, forKey: "SFLoginUserModel");
        def.synchronize();
        
    }
    
    // 获取数据
    static func getLoginUserModel() -> SFLoginUserModel {
        
        // 反序列化
        let def = UserDefaults.standard;
        if let data = def.object(forKey: "SFLoginUserModel") {
            
            if let loginUserModel:SFLoginUserModel = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? SFLoginUserModel {
                
                return loginUserModel;
            }
        }
        return SFLoginUserModel();
    }
}
