//
//  APIManager.swift
//  APIHelper
//
//  Created by Thabresh on 22/02/18.
//  Copyright © 2018 Vivid. All rights reserved.
//

import UIKit

class APIManager: NSObject {

    static let sharedInstance = APIManager()
    
    func postRequestCall(postURL:String,parameters:[String:Any],senderVC:UIViewController, onSuccess: @escaping((_ success:NSDictionary,JSON) -> Void), onFailure: @escaping(Error) -> Void){
        
        OperationQueue.main.addOperation {
           SVProgressHUD.show()
//            MBProgressHUD.showAdded(to: senderVC.view, animated: true)
        }
        let url = URL(string: postURL)!
        var request = URLRequest(url: url)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("en", forHTTPHeaderField: "Accept-Language")
        request.httpMethod = "POST"

        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            request.httpBody = jsonData
        }
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: senderVC as? URLSessionDelegate, delegateQueue:OperationQueue.main)
        let task = session.dataTask(with: request){ data, response, error in
            print(response as Any)
            OperationQueue.main.addOperation {
                                SVProgressHUD.dismiss()
            }
            guard let data = data, error == nil else {
                onFailure(error!)
                return
            }
            do {
                let uval = UserDefaults.standard.bool(forKey: "tasklist")
                if(uval)
                {
                  UserDefaults.standard.removeObject(forKey: "Taskdata")
                    UserDefaults.standard.setValue(data, forKey: "Taskdata")
                    UserDefaults.standard.set(false, forKey: "tasklist")
                }
                let sval  = UserDefaults.standard.bool(forKey: "pickerdata")
                if(sval)
                {
                    UserDefaults.standard.removeObject(forKey: "pickervalue")
                    UserDefaults.standard.setValue(data, forKey: "pickervalue")
                    UserDefaults.standard.set(false, forKey: "pickerdata")
                }
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: [])
                print(jsonObj)
               
                
                print("-----**Start**------\n\n=========\n\(postURL):\n=========  \n\n \(postURL) \n-----**End**-------")
                guard let _:Dictionary = jsonObj as? [String:AnyObject] else{
                    return
                }
                self.checkCookie(httpResponse: response as! HTTPURLResponse,ServiceURL:postURL)

                let result = try JSON(data: data)
               
                onSuccess(jsonObj as! NSDictionary, result)
//                self.setCookieStorage(httpResponse: response as! HTTPURLResponse, ServiceURL: postURL)
            }catch {
                onFailure(error)
            }
            
        }
        task.resume()
    }
    
    func postRequestCalls(postURL:String,parameters:[String:Any],senderVC:UIViewController, onSuccess: @escaping((_ success:NSDictionary,JSON) -> Void), onFailure: @escaping(Error) -> Void){
        
        OperationQueue.main.addOperation {
            // SVProgressHUD.show()
            //            MBProgressHUD.showAdded(to: senderVC.view, animated: true)
        }
        let url = URL(string: postURL)!
        var request = URLRequest(url: url)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("en", forHTTPHeaderField: "Accept-Language")
        request.httpMethod = "POST"
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            request.httpBody = jsonData
        }
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: senderVC as? URLSessionDelegate, delegateQueue:OperationQueue.main)
        let task = session.dataTask(with: request){ data, response, error in
            print(response as Any)
            OperationQueue.main.addOperation {
                //                MBProgressHUD.hide(for: senderVC.view, animated: true)
                //SVProgressHUD.dismiss()
            }
            guard let data = data, error == nil else {
                onFailure(error!)
                return
            }
            do {
                let uval = UserDefaults.standard.bool(forKey: "tasklist")
                if(uval)
                {
                    UserDefaults.standard.removeObject(forKey: "Taskdata")
                    UserDefaults.standard.setValue(data, forKey: "Taskdata")
                    UserDefaults.standard.set(false, forKey: "tasklist")
                }
                let sval  = UserDefaults.standard.bool(forKey: "pickerdata")
                if(sval)
                {
                    UserDefaults.standard.removeObject(forKey: "pickervalue")
                    UserDefaults.standard.setValue(data, forKey: "pickervalue")
                    UserDefaults.standard.set(false, forKey: "pickerdata")
                }
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: [])
                print(jsonObj)
                
                
                print("-----**Start**------\n\n=========\n\(postURL):\n=========  \n\n \(postURL) \n-----**End**-------")
                guard let _:Dictionary = jsonObj as? [String:AnyObject] else{
                    return
                }
                self.checkCookie(httpResponse: response as! HTTPURLResponse,ServiceURL:postURL)
                
                let result = try JSON(data: data)
                onSuccess(jsonObj as! NSDictionary, result)
                
                
                
                //                self.setCookieStorage(httpResponse: response as! HTTPURLResponse, ServiceURL: postURL)
            }catch {
                onFailure(error)
            }
            
        }
        task.resume()
    }
    func checkCookie(httpResponse:HTTPURLResponse,ServiceURL:String){
        if isKeyPresentInUserDefaults(key: "usercookie"){
        }else{
          //  if ServiceURL == loginURL{
                var setCookie:String = ""
                let cookies = HTTPCookie.cookies(withResponseHeaderFields: httpResponse.allHeaderFields as! [String: String], for: (httpResponse.url!))
                for cookie in cookies{
                    setCookie = String(format: "%@=%@;path=%@", cookie.name,cookie.value,cookie.path)
                    debugPrint(setCookie)
                }
                setDefaultKeyandValue(keyName: "usercookie", valueOfKey: setCookie)
          //  }
        }
    }
    
    func setCookieStorage(httpResponse:URLResponse,ServiceURL:String){
        
        if isKeyPresentInUserDefaults(key: "usercookie"){
            
        }else{
            if ServiceURL == packagesURL{
                
                
                
                //"usercookie"
                let cityName = UserDefaults.standard.value(forKey: "usercookie")
                
                if cityName == nil{
//                    var setCookie:String = ""
//                    let cookies = HTTPCookie.cookies(withResponseHeaderFields: httpResponse.allHeaderFields as! [String: String], for: (httpResponse.url!))
//                    for cookie in cookies{
//                        setCookie = String(format: "%@=%@;path=%@", cookie.name,cookie.value,cookie.path)
//                        debugPrint(setCookie)
//                    }
//                    print(setCookie)
//                    setDefaultKeyandValue(keyName: "usercookie", valueOfKey: setCookie)
                }
            }
        }
        
    }
    
    //SET USERDEFAULT KEY AND VALUES
    func setDefaultKeyandValue(keyName:String,valueOfKey:String){
        UserDefaults.standard.set(valueOfKey, forKey: keyName)
    }
    
    func getUserDefaultValues(keyName:String) -> String{
        if isKeyPresentInUserDefaults(key: keyName) {
            return UserDefaults.standard.value(forKey: keyName) as! String
        }
        return ""
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    //MARK: -
    static func convertDicToString(sender:[String:AnyObject]) -> String {
        var returnString = ""
        for item in sender {
            returnString += item.key + "=" + (item.value as! String) + "&"
        }
        returnString.removeLast()
        print(returnString)
        return returnString
    }
}
extension Dictionary {
    func nullKeyRemoval() -> Dictionary {
        var dict = self
        
        let keysToRemove = Array(dict.keys).filter { dict[$0] is NSNull }
        for key in keysToRemove {
            dict.removeValue(forKey: key)
        }
        
        return dict
    }
}
