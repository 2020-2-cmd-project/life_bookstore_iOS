//
//  ShelfDataModel.swift
//  life_bookstore
//
//  Created by 송지훈 on 2020/10/01.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation
import RealmSwift

struct ShelfDataModel
{
    var books : [BookDataModel]
    var shelfIndex : Int
 
    
    
    
    init(index : Int) // 새로 만들 때,
    {
        self.books = []
        self.shelfIndex = index
    }
    
    init(books : [BookDataModel], index : Int)
    {
        self.books = books

        self.shelfIndex = index
    }
}



//class BookDataModelList : Object {
//
//
//     @objc dynamic var title = ""
//    @objc dynamic var content : String = ""
//    @objc dynamic var index : Int = -1
//    @objc dynamic var time : String = ""
//    @objc dynamic var location : String = ""
//    @objc dynamic var color : String = ""
//    @objc dynamic var categoryIndex : Int = -1
//    @objc dynamic var questionIndex : Int = -1
//
//    let hashTag  = List<HashTagObject>()
//
//}
