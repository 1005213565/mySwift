//
//  SFTabBarController.swift
//  swift实践
//
//  Created by mac on 2019/10/9.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit



class SFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let homeVC = SFHomeVC();
        let homeNormalImage = UIImage.init(named: "homeTabBarNormalImage");
        homeNormalImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal);
        
        let homeSelectedImage = UIImage.init(named: "homeTabBarSelectedImage");
        homeNormalImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        homeVC.tabBarItem = UITabBarItem.init(title: "首页", image:homeNormalImage, selectedImage: homeSelectedImage);
        let homeNav = UINavigationController.init(rootViewController: homeVC);
        
        let orderVC = SFOrderVC();
        orderVC.tabBarItem = UITabBarItem.init(title: "订单", image: UIImage.init(named: "orderTabBarNormalImage"), selectedImage: UIImage.init(named: "orderTabBarSelectedImage"));
        let orderNav = UINavigationController.init(rootViewController: orderVC);
        
        
        let mineVC = SFMineVC();
        mineVC.tabBarItem = UITabBarItem.init(title: "我的", image: UIImage.init(named: "mineTabBarNormalImage"), selectedImage: UIImage.init(named: "mineTabBarSelectedImage"));
        let mineNav = UINavigationController.init(rootViewController: mineVC);
        
        
        self.addChild(homeNav);
        self.addChild(orderNav);
        self.addChild(mineNav);
        
        
    }


}
