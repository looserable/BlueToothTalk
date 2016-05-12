//
//  LoginViewController.swift
//  BlueToothChat
//
//  Created by john on 16/5/12.
//  Copyright © 2016年 jhon. All rights reserved.
//

import UIKit
import CocoaAsyncSocket

//绑定的端口号
let port:UInt16 = 9574

class LoginViewController: UIViewController {

    var asyUdpSocket:AsyncUdpSocket?
    var nameField:UITextField?
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
//    初始化一个asyUdpSocket对象
    func initSocket(){
        asyUdpSocket = AsyncUdpSocket.init(delegate: self)
        try! asyUdpSocket?.bindToPort(port)
        try! asyUdpSocket?.enableBroadcast(true)
    }
    
    func loginClick(sender:UIButton){
        print("我登陆了")
        let username = self.nameField?.text
        let ipStr:String! = GetIPAddress.deviceIPAdress()
        
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(username, forKey: "name")
        userDefault.setObject(ipStr, forKey: "ipStr")
        
//        发送udp的广播，告诉局域网里的小伙伴，我上线了。
        let broadCast:String = "小伙伴们,我已经上线了，我的名字是：\(username) 我的ip地址是:\(ipStr)"
        
        let data:NSData! = broadCast.dataUsingEncoding(NSUTF8StringEncoding)
        
        asyUdpSocket?.sendData(data, toHost: "255.255.255.255", port: port, withTimeout: -1, tag: 0)
        
        
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
