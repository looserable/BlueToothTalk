//
//  SocketReference.swift
//  BlueToothChat
//
//  Created by john on 16/5/12.
//  Copyright © 2016年 jhon. All rights reserved.
//

import UIKit
import CocoaAsyncSocket

var once:dispatch_once_t?
var socketRefer:SocketReference?

class SocketReference: NSObject {
    class func sharedSocetReference()->SocketReference{
        dispatch_once(&once!) { 
            socketRefer = SocketReference.init()
        }
        
        return socketRefer!
    }
    
}
