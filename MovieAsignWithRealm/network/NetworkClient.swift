//
//  NetworkClient.swift
//  The Movie App
//
//  Created by saw pyaehtun on 08/09/2019.
//  Copyright © 2019 Ye Ko Ko Htet. All rights reserved.
//

import Foundation
import Alamofire
import Reachability
import SystemConfiguration
import SwiftyJSON


class NetworkClient {
    //MARK:- NETWORK CALLS
    static let shared = NetworkClient()
    
    public func request(url : String,
                        method : HTTPMethod = .get,
                        parameters : Parameters = [:],
                        headers : HTTPHeaders = [:],
                        success : @escaping (Data) -> Void,
                        failure : @escaping (String) -> Void){
        print("url . . . : \(url)")
        
        Alamofire.request(url, method: method, parameters: parameters, headers: headers).validate().responseData { (response) in
            switch response.result {
            case .success(let data) :
//                let json = JSON(data)
//                let jsonString = json.rawString()
//                print(jsonString)
                success(data)
            case .failure(let err) :
                failure(err.localizedDescription)
                break
            }
        }
    }
    
    public func requestWithoutCache (url: String,
                                     method : HTTPMethod = .get,
                                     parameters : Parameters = [:],
                                     headers : HTTPHeaders = [:],
                                     success : @escaping (Data) -> Void,
                                     failure : @escaping (String) -> Void){
        print("url . . . : \(url)")
        Alamofire.SessionManager.default.request(url, method: method, parameters: parameters, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let data) :
                success(data)
            case .failure(let err) :
                failure(err.localizedDescription)
                break
            }
        }
        
    }
}

//MARK:- CHECK NETWORK
extension NetworkClient {
    
    static func isOnline(callback: @escaping (Bool) -> Void){
        //declare this property where it won't go out of scope relative to your listener
        let reachability = Reachability()!
        
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
                callback(true)
            } else {
                print("Reachable via Cellular")
                callback(true)
            }
        }
        
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            callback(false)
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
            callback(false)
        }
    }
    
    static func checkReachable() -> Bool{
        let reachability = SCNetworkReachabilityCreateWithName(nil, "www.raywenderlich.com")
        
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability!, &flags)
        
        if (isNetworkReachable(with: flags))
        {
            print (flags)
            if flags.contains(.isWWAN) {
                return true
            }
            
            //            self.alert(message:"via wifi",title:"Reachable")
            
            return true
        }
        else if (!isNetworkReachable(with: flags)) {
            //            self.alert(message:"Sorry no connection",title: "unreachable")
            print (flags)
            return false
        }
        
        return false
    }
    
    static func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
    }
    
}
