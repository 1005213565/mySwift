//
//  SFBaseNetworking.swift
//  swift实践
//  Alamofire封装
//  Created by mac on 2019/10/15.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire


class SFBaseNetworking: NSObject {

    /**
     请求数据，返回的就是json数据
     methodType 请求类型
     url 请求地址
     parameters 请求参数
     finishedCallback 闭包回调
     */
    class func requstData(_ methodType:HTTPMethod, url: String, parameters:[String:Any], finishedCallback:@escaping (_ result: Any, _ isSuccess:Bool) ->()) -> () {
        
        var headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "client-type": "sxyUIT2jE"
        ]
        if APPHelper.shared.loginUserModel?.token != nil {
            
            headers["token"] = APPHelper.shared.loginUserModel?.token;
        }
        Alamofire.request(url, method: methodType, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            finishedCallback(response.value!, response.result.isSuccess);
        }
    }
}
