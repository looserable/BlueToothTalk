//
//  SocketReference.swift
//  BlueToothChat
//
//  Created by john on 16/5/12.
//  Copyright © 2016年 jhon. All rights reserved.
//

import UIKit
import CocoaAsyncSocket

var once:dispatch_once_t = 0
var socketRefer:SocketReference?

let NOTIFICATIONT_LOGIN = "login"

//绑定的端口号
let port:UInt16 = 8888

class SocketReference: NSObject,AsyncUdpSocketDelegate {
    
    var clientSocket:AsyncUdpSocket?
    var serverSocket:AsyncUdpSocket?
    
    var modelArray  :[ContactModel]?
    var ipStr       :String?
    
//  单例的类方法
    class func sharedSocetReference()->SocketReference{

        dispatch_once(&once) {
            socketRefer = SocketReference.init()
        }
        return socketRefer!
    }
//   发送消息
    func SendMsg(data:NSData,ipStr:String){
        let res = clientSocket?.sendData(data, toHost:ipStr, port: port, withTimeout: 3000, tag: 0)
        if res == false {
            print("send failed")
        }
    }
//    单例对象的初始化
    override init() {
        super.init()
        self.initSocket()
    }
    
    //MARK: 初始化一个asyUdpSocket对象
    func initSocket(){
        //        这三个属性进行初始化
        ipStr = GetIPAddress.deviceIPAdress()
        modelArray = [ContactModel]()
        
        clientSocket = AsyncUdpSocket.init(delegate: self)
        try! clientSocket?.enableBroadcast(true)

        serverSocket = AsyncUdpSocket.init(delegate:self)
        do{
            try serverSocket?.bindToPort(port)
        }catch{
            print("绑定端口失败")
        }
        //        启动接收线程
        serverSocket?.receiveWithTimeout(-1, tag: 0)
    }
    
//   接收socket的回调方法
    func onUdpSocket(sock: AsyncUdpSocket!, didReceiveData data: NSData!, withTag tag: Int, fromHost host: String!, port: UInt16) -> Bool {

        
        let infoStr = String.init(data: data, encoding: NSUTF8StringEncoding)
        let contact = ContactModel.makeContactModel(infoStr!)
        if contact.contactIpStr != ipStr {
            modelArray!.append(contact)
            
            let userinfoDic:[String:[ContactModel]] = ["array":modelArray!]
            let noti = NSNotification(name: NOTIFICATIONT_LOGIN, object: nil, userInfo: userinfoDic)
            NSNotificationCenter.defaultCenter().postNotification(noti)
        }
        print("did receive")
        serverSocket?.receiveWithTimeout(-1, tag: 0)
        
        return true
    }
    
    func onUdpSocket(sock: AsyncUdpSocket!, didNotSendDataWithTag tag: Int, dueToError error: NSError!) {
        print("does not send")
    }
    
    func onUdpSocket(sock: AsyncUdpSocket!, didNotReceiveDataWithTag tag: Int, dueToError error: NSError!) {
        print("does not receive")
    }
    
    func onUdpSocket(sock: AsyncUdpSocket!, didSendDataWithTag tag: Int) {
        print("did send")
    }
    
    func onUdpSocketDidClose(sock: AsyncUdpSocket!) {
        print("did Close")
    }
    
    

    

    
}
