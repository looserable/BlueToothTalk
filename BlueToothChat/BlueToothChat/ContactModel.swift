//
//  ContactModel.swift
//  BlueToothChat
//
//  Created by john on 16/5/13.
//  Copyright © 2016年 jhon. All rights reserved.
//

import UIKit

class ContactModel: NSObject {
    
    var contactName:String?
    var contactIpStr:String?
    
    class func makeContactModel(infoStr:String)->ContactModel{
        let contactModel = ContactModel()
        
        let infoArray:[String] = infoStr.componentsSeparatedByString(":")
        contactModel.contactName = infoArray[1]
        contactModel.contactIpStr = infoArray[3]
        return contactModel
    }

}
