//
//  DataTableView.swift
//  Code Optimization
//
//  Created by mac on 15/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import SwiftyJSON

class DataTableView: UITableView , UITableViewDelegate , UITableViewDataSource {
    
    
    var dataSourceArr = [dataModel](){
        didSet{
            
            reloadData()
        }
    }
   
    override init(frame: CGRect, style: UITableViewStyle) {// need when we want table view programatically
        super.init(frame: frame, style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {// call when uitableview drawn from storyboard then this methhod will call
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {// call when table view load
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
        
    }
    
    //MARK: TABLEVIEW DATASOURCE AND DELEGATE
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell  = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
        let myUser = dataSourceArr[indexPath.row]
        cell.name.text = myUser.name
        cell.mobile.text = myUser.username
        cell.address.text = myUser.phone
        cell.company.text = myUser.email

        return cell
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
