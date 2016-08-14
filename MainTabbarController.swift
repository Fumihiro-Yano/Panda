//
//  MainTabbarController.swift
//  Panda
//
//  Created by 矢野史洋 on 2016/08/03.
//  Copyright © 2016年 矢野史洋. All rights reserved.
//

import UIKit

//UITabBarControllerを継承
class MainTabbarController: UITabBarController {
    var firstView: ViewController!
    var secondView: ViewController!
    var thirdView: ViewController3!
    var fourthView: ViewController!
    var tabPageViewController: TabPageViewController!
    var nav: UINavigationController?
    var nav2: UINavigationController?
    var nav3: UINavigationController?
    var nav4: UINavigationController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstView = ViewController()
        secondView = ViewController()
        thirdView = ViewController3()
        fourthView = ViewController()
        
        let tabPageViewController = TabPageViewController()
        let vc1 = EntertainmentListViewController()
        let vc2 = HealthAndMedicalListViewController()
        let vc3 = ComputerListViewController()
        let vc4 = SportListViewController()
        let vc5 = GameAndAnimeListViewController()
        let vc6 = PoliticalAndEconomyListViewController()
        tabPageViewController.tabItems = [(vc1, "エンタメ"), (vc2, "健康と医療"), (vc3, "コンピュータ"), (vc4, "スポーツ"), (vc5, "ゲームとアニメ"), (vc6, "政治と経済")]
        tabPageViewController.isInfinity = true
        var option = TabPageOption()
        option.currentColor = UIColor.hex("FF5730", alpha: 1.0)
        tabPageViewController.option = option
        
        // fontの設定
        let fontFamily: UIFont! = UIFont.systemFontOfSize(10)
        
        //TabBarの背景色を変更する
        UITabBar.appearance().barTintColor = UIColor.hex("3FB9E3", alpha: 1.0)
        
        // 選択時の設定
        let selectedAttributes = [NSFontAttributeName: fontFamily, NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        // タイトルテキストカラーの設定
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, forState: UIControlState.Selected)
        
        // アイコンカラーの設定
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        
        // 非選択時の設定
        let nomalAttributes = [NSFontAttributeName: fontFamily, NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        /// タイトルテキストカラーの設定
        UITabBarItem.appearance().setTitleTextAttributes(nomalAttributes, forState: UIControlState.Normal)
        
        //表示するtabItemを指定
        tabPageViewController.tabBarItem = UITabBarItem(title: "答える", image: UIImage(named: "check_questionnaire_tab_icon.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: UIImage(named: "check_questionnaire_tab_icon.png"))
        secondView.tabBarItem = UITabBarItem(title: "質問する", image: UIImage(named: "question_tab_icon.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: UIImage(named: "question_tab_icon.png"))
        thirdView.tabBarItem = UITabBarItem(title: "通知", image: UIImage(named: "alarm.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: UIImage(named: "result_tab@2.png"))
        fourthView.tabBarItem = UITabBarItem(title: "マイページ", image: UIImage(named: "user_tab.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: UIImage(named: "user_tab.png"))
        
        nav = UINavigationController(rootViewController: tabPageViewController)
        nav2 = UINavigationController(rootViewController: secondView)
        nav3 = UINavigationController(rootViewController: thirdView)
        nav4 = UINavigationController(rootViewController: fourthView)
        
        //navigationbarとviewがかぶらないようにしている。
        nav!.navigationBar.translucent = false
        nav2!.navigationBar.translucent = false
        nav3!.navigationBar.translucent = false
        nav4!.navigationBar.translucent = false
        
        // タブで表示するViewControllerを配列に格納。
        let tabs = NSArray(objects: nav!, nav2!, nav3!, nav4!)
        
        // 配列をTabにセット。
        self.setViewControllers(tabs as? [UIViewController], animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}