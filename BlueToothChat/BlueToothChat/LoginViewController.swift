//
//  LoginViewController.swift
//  BlueToothChat
//
//  Created by john on 16/5/12.
//  Copyright © 2016年 jhon. All rights reserved.
//

import UIKit
import CocoaAsyncSocket



class LoginViewController: UIViewController,AsyncUdpSocketDelegate {

    var nameField   :UITextField?
    var ipStr       :String?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
//        中心点的坐标
        let center = self.view.center
        
//        用户名的输入框
        let nameField = UITextField(frame: CGRectMake(20,center.y - 20,(center.x - 20)*2,40))
        nameField.placeholder = "请输入用户名"
        nameField.borderStyle = .Line
        self.nameField = nameField
        self.view.addSubview(nameField)
        
//        连接的按钮
        let button = UIButton(type: .Custom)
        button.frame = CGRectMake(20, center.y + 40, (center.x - 20)*2, 40)
        button.setTitle("登陆", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.addTarget(self, action: #selector(loginClick(_:)), forControlEvents: .TouchUpInside)
        button.backgroundColor = UIColor.purpleColor()
        self.view.addSubview(button)
        
    }
    func loginClick(sender:UIButton){
        print("我登陆了")
//        对外展示的名字和本机的ip
        let username:String! = self.nameField?.text
        let ipStr:String! = GetIPAddress.deviceIPAdress()
        self.ipStr = ipStr
        
//        缓存到本地
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(username, forKey: "name")
        userDefault.setObject(ipStr, forKey: "ipStr")
        
        let infoStr = "小伙伴们，我上线了，我的名字是:\(username):我的ip地址为:\(ipStr)"
        let data = infoStr.dataUsingEncoding(NSUTF8StringEncoding)
        
        let socketRefe = SocketReference.sharedSocetReference()
        socketRefe.SendMsg(data!, ipStr: "255.255.255.255")
        
        let vc = ViewController()
        let secondNav = UINavigationController.init(rootViewController: vc)
        self .presentViewController(secondNav, animated: true) {
            print("跳转成功了")
        }
        
}
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
