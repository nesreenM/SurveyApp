//
//  APIManager.swift
//  Do2rom
//
//  Created by Rana on 9/12/17.
//  Copyright © 2017 EverestMinds. All rights reserved.
//

import UIKit

public class APIManager {
//   let baseURL = "http://e1ef1e97.ngrok.io/"
    let baseURL = "http://localhost:1337/"

    var errorMessage = ""
    var GETResponseDictinary = [String : Any]()
    
    func getRequest(_ method: String, parameters: String, queryParameters: [String:AnyObject]?, headers : [String: String]?, completionHandlerForGET: @escaping (_ result: AnyObject?, _ error: NSError? , _ statusCode:Int) -> Void){
        
        var urlString = baseURL + method
        //URL Parameters
        if !parameters.isEmpty {
            
            urlString += parameters
        }
        
        //QUERY PARAMETERS
        if let urlparameters = queryParameters {
            urlString += "?"
            for (paramKey , paramValue) in urlparameters {
                urlString += paramKey + "=" + String(describing: paramValue) + "&"
            }
            
            urlString = urlString.substring(to: urlString.index(before: urlString.endIndex))
        }
        let session = URLSession.shared
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print("URL =======> " , urlString)

        let url = URL(string:  urlString)
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        
        //URL HEADERS
        if let _ = headers{
            for (headerKey , headerValue) in headers! {
                request.addValue(headerValue, forHTTPHeaderField: headerKey)
            }
        }
        request.addValue("true", forHTTPHeaderField: "mobile")
        
        let dataTask = session.dataTask(with: request as URLRequest){ data, response, error in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo), 7)
            }
            if let statusCode = ((response as? HTTPURLResponse)?.statusCode)
            {
                self.convertDataWithCompletionHandler(data!, statusCode: statusCode, completionHandlerForConvertData: completionHandlerForGET)
                
            }
        }
        
        //End of getRequest Method
        dataTask.resume()
    }
    func putRequest(_ method: String, urlparameters: String, jsonBody: [String:  AnyObject]?, headers : [String: String]?, completionHandlerForPOST: @escaping (_ result: AnyObject?, _ error: NSError?,_ statusCode:Int) -> Void) {
        
        var urlString = baseURL + method
        
        //if No parameters needed
        if  !urlparameters.isEmpty {
            urlString += "\(urlparameters)"
        }
        
        let session = URLSession.shared
        let url = URL(string: urlString)
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "PUT"
        
        //if No Headers needed
        if let _ = headers{
            for (headerKey , headerValue) in headers! {
                request.addValue(headerValue, forHTTPHeaderField: headerKey)
            }
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        request.addValue("true", forHTTPHeaderField: "mobile")
        
        //if No JSONBody needed
        if var jsonBody = jsonBody{
            do{
                request.httpBody = try JSONSerialization.data(withJSONObject: jsonBody)
            }
            catch let error {
                print(error.localizedDescription)
            }
        }
        let dataTask = session.dataTask(with: request as URLRequest){ data, response, error in
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForPOST(nil, NSError(domain: "taskForPOSTMethod", code: 1, userInfo: userInfo), 8)
            }
            
            if let statusCode = ((response as? HTTPURLResponse)?.statusCode)
            {
                self.convertDataWithCompletionHandler(data!, statusCode: statusCode, completionHandlerForConvertData: completionHandlerForPOST)
                
            }
            
            
        }
        //End of postRequest Method
        dataTask.resume()
        
    }
    
    func postRequest(_ method: String, urlparameters: [String:  AnyObject]?, jsonBody: [String:  AnyObject]?, headers : [String: String]?, completionHandlerForPOST: @escaping (_ result: AnyObject?, _ error: NSError?,_ statusCode:Int) -> Void) {
        
        var urlString = baseURL + method
        
        //if No parameters needed
        if let urlparameters = urlparameters {
            urlString += "?"
            for (paramKey , paramValue) in urlparameters {
                urlString += paramKey + "=" + (paramValue as! String) + "&"
            }
            
            urlString = urlString.substring(to: urlString.index(before: urlString.endIndex))
        }
        
        let session = URLSession.shared
        let url = URL(string: urlString)
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        
        //if No Headers needed
        if let _ = headers{
            for (headerKey , headerValue) in headers! {
                request.addValue(headerValue, forHTTPHeaderField: headerKey)
            }
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        request.addValue("true", forHTTPHeaderField: "mobile")
        
        //if No JSONBody needed
        if var jsonBody = jsonBody{
            do{
                request.httpBody = try JSONSerialization.data(withJSONObject: jsonBody)
            }
            catch let error {
                print(error.localizedDescription)
            }
        }
        let dataTask = session.dataTask(with: request as URLRequest){ data, response, error in
            print("REQUEST " , request)
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForPOST(nil, NSError(domain: "taskForPOSTMethod", code: 1, userInfo: userInfo), 8)
            }
      
            if let statusCode = ((response as? HTTPURLResponse)?.statusCode)
            {
                self.convertDataWithCompletionHandler(data!, statusCode: statusCode, completionHandlerForConvertData: completionHandlerForPOST)
                
            }
            
            
        }
        //End of postRequest Method
        dataTask.resume()
        
    }
    
    func deleteRequest(_ method: String, parameters: String, queryParameters: [String:AnyObject]?, headers : [String: String]?, completionHandlerForGET: @escaping (_ result: AnyObject?, _ error: NSError? , _ statusCode:Int) -> Void){
        
        var urlString = baseURL + method
        //URL Parameters
        if !parameters.isEmpty {
            
            urlString += parameters
        }
        
        //QUERY PARAMETERS
        if let urlparameters = queryParameters {
            urlString += "?"
            for (paramKey , paramValue) in urlparameters {
                urlString += paramKey + "=" + String(describing: paramValue) + "&"
            }
            
            urlString = urlString.substring(to: urlString.index(before: urlString.endIndex))
        }
        let session = URLSession.shared
        print("URL =======> " , urlString)
        let url = URL(string:  urlString)
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "DELETE"
        
        //URL HEADERS
        if let _ = headers{
            for (headerKey , headerValue) in headers! {
              
                request.addValue(headerValue, forHTTPHeaderField: headerKey)
            }
        }
        request.addValue("true", forHTTPHeaderField: "mobile")
        
        let dataTask = session.dataTask(with: request as URLRequest){ data, response, error in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo), 7)
            }
            if let statusCode = ((response as? HTTPURLResponse)?.statusCode)
            {
                self.convertDataWithCompletionHandler(data!, statusCode: statusCode, completionHandlerForConvertData: completionHandlerForGET)
                
            }
        }
        
        //End of getRequest Method
        dataTask.resume()
    }
   

    
    // given raw JSON, return a usable Foundation object
    private func convertDataWithCompletionHandler(_ data: Data,statusCode : Int ,completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError? ,_ statusCode:Int) -> Void) {
        var parsedResult: AnyObject! = nil
        if statusCode >= 200 && statusCode <= 299{
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
                
            } catch {
                let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
                completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo),statusCode)
                
            }
        }
        
        completionHandlerForConvertData(parsedResult, nil,statusCode)
   
    }
    
    
}

