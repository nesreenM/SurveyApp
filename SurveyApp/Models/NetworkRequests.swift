//
//  NetworkRequests.swift
//  Do2rom
//
//  Created by Nesreen Mamdouh on 9/23/17.
//  Copyright © 2017 EverestMinds. All rights reserved.
//

import Foundation
import UIKit

class NetworkRequests
{
    
    func createAnswersFromData(answersData : [[String:Any]]) -> [Answer]{
        var answersArray : [Answer] = []
        for ans in answersData {
            let question = ans["question"] as? Int ?? 0
            let isNumerical = ans["isNumerical"] as? NSNumber ?? 0
            let value = ans["value"] as? Int ?? 0
            let body = ans["body"] as? String ?? ""
            let id = ans["id"] as? Int ?? 0
            
            let answer = Answer.init(id: id, questionId: question, isNumerical: isNumerical.boolValue, value: value, body: body)
            answersArray.append(answer)
        }
        return answersArray
    }
    
    func getActiveQuestions( sender:
        NetworkRequestsCompletionHandler ){
      
        APIManager().getRequest("questions/getActiveQuestions/", parameters: "" , queryParameters: nil ,headers: nil , completionHandlerForGET:{
            (data,error,statuscode) in
            if statuscode >= 200 && statuscode <= 299 {
                if  let _ = data!["error"] as? NSNumber {
  
                    let dataArray =  data!["data"] as? [[String:Any]] ?? []
                    
                    for qs in dataArray{
                        let isMultiSelect = qs["isMultiSelect"] as? NSNumber ?? 0
                        let active = qs["active"] as? NSNumber ?? 0
                        let body = qs["body"] as? String ?? ""
                        let id = qs["id"] as? Int ?? 0
                        
                        let answerData = qs["answers"] as? [[String:Any]] ?? []
                        let answersArray = self.createAnswersFromData(answersData: answerData)
                        let question = Question.init(id: id, isMultiSelect: isMultiSelect.boolValue, body: body, active: active.boolValue, answer: answersArray)
                        DataModel.sharedInstance.activeQuestions.append(question)
                    }
                    
                    for item in DataModel.sharedInstance.activeQuestions {
                        
                        print("Active Question id: \(item.id) answers: " , item.answer)
                       
                    }
                    
                    DispatchQueue.main.async {
                        sender.onCompleteUpdateView("getActiveQuestions")
                    }
                    
                }
                else
                {
                    let error = data!["error"] as! String
                    DispatchQueue.main.async {
                        sender.onErrorUpdateView(error,"getActiveQuestions")
                    }
                    
                }
            }
            else {
                
                DispatchQueue.main.async {
                    sender.onErrorUpdateView("Server error","getActiveQuestions")
                }
            }
            
        })
    }
    
    func postResponse(questionId:Int,answerId:[Int],responseId:Int,sender:NetworkRequestsCompletionHandler){
       
        var jsonBody:[String:Any] = ["questionId":questionId]
        jsonBody["answers"] = answerId
        jsonBody["responseId"] = responseId

        
        APIManager().postRequest("questionRespones/addResponse", urlparameters: nil, jsonBody: jsonBody as [String : AnyObject], headers: nil, completionHandlerForPOST: {
            (data,error,statuscode) in
            
            if statuscode >= 200 && statuscode <= 299 {
                if  let _ = data!["error"] as? NSNumber {
                    
                    DispatchQueue.main.async {
                        sender.onCompleteUpdateView("postResponse")
                    }
                    
                }
                else
                {
                    let error = data!["error"] as! String
                    DispatchQueue.main.async {
                        sender.onErrorUpdateView(error,"postResponse")
                    }
                    
                }
            }
            else {
                
                DispatchQueue.main.async {
                    sender.onErrorUpdateView("Server error","postResponse")
                }
            }
            
        })
        
    }
}

protocol NetworkRequestsCompletionHandler {
    
    func onCompleteUpdateView(_ methodName : String)
    func onErrorUpdateView(_ errorMessage : String , _ methodName : String)
    
}


