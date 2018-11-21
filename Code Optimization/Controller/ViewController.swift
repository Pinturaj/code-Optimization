//
//  ViewController.swift
//  Code Optimization
//
//  Created by mac on 15/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var tableView: DataTableView!
    
    var response : JSON!
    var userArr : [dataModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Code Optimization"
        self.navigationController?.isNavigationBarHidden = false
        self.tableView.register(UINib(nibName: "MyCell", bundle: nil), forCellReuseIdentifier: "MyCell")
        fetchUsers()
    }
    func fetchUsers(){
        APIManager.sharedInstance.apiCall1(dataAPI , [:]){ (status , result) in
            print(result)
            for i in 0..<result.count{
                let SU = dataModel(userJSON: result[i])
                self.userArr.append(SU)
            }
            DispatchQueue.main.async {
                self.tableView.dataSourceArr = self.userArr
                
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

