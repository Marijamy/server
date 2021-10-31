//
//  FriendsAPI.swift
//  Server_AksenovaMV
//
//  Created by Klepa on 31.10.2021.
//

import Foundation
import Alamofire

struct Friend {
    
}

final class FriendsAPI {
    
    let token = MySession.shared.token
    let userID = MySession.shared.userId
    let baseURL = "https://api.vk.com/method"
    let version = "5.81"
    
    func getFriends(completion: @escaping([Friend])->()) {
        
        let method = "friends.get"
        
        let parameters: Parameters = [
            "user_id": userID,
            "order": "name",
            "fields": "photo_100",
            "count": 10,
            "acces_token": token,
            "v": version,
        ]
        let url = baseURL + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            print(response.value)
        }
    }
}
