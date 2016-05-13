//
//  ViewController.swift
//  BlueToothChat
//
//  Created by john on 16/5/12.
//  Copyright © 2016年 jhon. All rights reserved.
//

import UIKit

let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var conTableView:UITableView?
    var contactList:[ContactModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        contactList = [ContactModel]()
        self.navigationItem.title = "联系人"
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        conTableView = UITableView(frame: self.view.frame, style: .Plain)
        conTableView?.delegate = self
        conTableView?.dataSource = self
        self.view.addSubview(conTableView!)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(getOnLineUpdate(_:)), name: NOTIFICATIONT_LOGIN, object: nil)
    }
    
    func getOnLineUpdate(noti:NSNotification){
        let userinfoDic:[String:[ContactModel]] = noti.userInfo as! [String:[ContactModel]]
        contactList = userinfoDic["array"]
        self.conTableView?.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.contactList?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cellID")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cellID")
        }
        let contact = contactList![indexPath.row]
        cell?.textLabel?.text = contact.contactName
        
        return cell!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

