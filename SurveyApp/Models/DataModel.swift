//
//  DataModel.swift
//  SurveyApp
//
//  Created by Nesreen Mamdouh on 11/20/17.
//  Copyright © 2017 JRany. All rights reserved.
//

import Foundation

class DataModel {
    static let sharedInstance = DataModel()
    typealias questionAnswerTupleType = (questionID: Int, answerID: Int)
    
    var currentIndexGreen = 0
    var currentIndexRed = 0
    
    
    var activeQuestions : [Question] = []
    // Key = QuestionId , Value = Array of AnswerID
    var questionAnswerDictionary: [Int:[Int]] = [:]
    
    private init(){}
    
    public func getQuestionByID(id: Int) -> Question? {
        for qs in activeQuestions {
            if(qs.id == id){
                return qs
            }
        }
        return nil
        
    }
    
}
