//
//  dataModel.swift
//  Code Optimization
//
//  Created by mac on 15/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import SwiftyJSON

class dataModel {
    
    var name = String()
    var username = String()
    var email = String()
    var phone = String()
//    var address = userAddress?()
//    var company = userCompany?()
    
    init(userJSON : JSON) {
        self.name = userJSON["name"].stringValue
        self.username = userJSON["username"].stringValue
        self.email = userJSON["email"].stringValue
        self.phone = userJSON["phone"].stringValue
//        self.address = userAddress(addressJSON : userJSON["address"])
//        self.company = userAddress(addressJSON : userJSON["company"])

    }
}

class userAddress{
    var street = String()
    var city = String()
    var suit = String()
    
    
    init(addressJSON : JSON) {
        self.street = addressJSON["street"].stringValue
        self.city = addressJSON["city"].stringValue
        self.suit = addressJSON["suit"].stringValue
    }
}

class userCompany{
    var companyName = String()
    var phrase = String()
    
    init(companyJSON : JSON) {
        self.companyName = companyJSON["name"].stringValue
        self.phrase = companyJSON["catchPhrase"].stringValue
    }
}
