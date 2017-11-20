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

    var currentIndexGreen = 0
    var currentIndexRed = 0

    var questionsGreen = ["Whats up?" , "How was the food?" , "Marry Me"]
    var questionsRed = ["FUck you" , "YAY"]
    private init(){
        
    }
}
