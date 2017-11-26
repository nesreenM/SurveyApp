//
//  DataTypes.swift
//  SurveyApp
//
//  Created by Nesreen Mamdouh on 11/26/17.
//  Copyright © 2017 JRany. All rights reserved.
//

import Foundation

class Question {
    var isMultiSelect : Bool
    var body : String
    var active: Bool
    var answer : [Answer]
    var id : Int
    
    init(id : Int , isMultiSelect : Bool,body : String,active: Bool,answer : [Answer]) {
        self.id = id
        self.isMultiSelect = isMultiSelect
        self.active = active
        self.body = body
        self.answer = answer
    }
}

class Answer {
    var questionId : Int
    var isNumerical :Bool
    var value : Int
    var body :String
    var id : Int
    
    init(id: Int, questionId : Int,isNumerical :Bool,value : Int,body :String) {
        self.body = body
        self.questionId = questionId
        self.isNumerical = isNumerical
        self.value = value
        self.id = id
    }
}


