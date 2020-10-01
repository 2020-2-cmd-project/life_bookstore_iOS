//
//  BookDataModel.swift
//  life_bookstore
//
//  Created by 송지훈 on 2020/10/01.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation


struct BookDataModel{
    
    var title : String
    var content : String
    var index : Int
    var time : String
    var location : String
    var color : String
    var hashTag : [String]
    var categoryIndex : Int
    var questionIndex : Int
    
    
    init(title : String, content : String, index : Int, time : String, location : String, color : String, hashTag : [String], category : Int, question : Int)
    {
        self.title = title
        self.content = content
        self.index = index
        self.time = time
        self.location = location
        self.color = color
        self.hashTag = hashTag
        self.categoryIndex = category
        self.questionIndex = question
    }
    init()
    {
        self.title = "SAMPLE"
        self.content = ""
        self.index = -1
        self.time = ""
        self.location = ""
        self.color = ""
        self.hashTag = []
        self.categoryIndex = -1
        self.questionIndex = -1
    }
    
}
