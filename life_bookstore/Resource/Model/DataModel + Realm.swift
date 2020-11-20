//
//  DataModel + Realm.swift
//  life_bookstore
//
//  Created by 송지훈 on 2020/11/19.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation
import RealmSwift



// 책 모델 생성


class BookDataModelList : Object {
    

     @objc dynamic var title = ""
    @objc dynamic var content : String = ""
    @objc dynamic var index : Int = -1
    @objc dynamic var time : String = ""
    @objc dynamic var location : String = ""
    @objc dynamic var color : String = ""
    @objc dynamic var categoryIndex : Int = -1
    @objc dynamic var questionIndex : Int = -1
    
    var hashTag  = List<HashTagObject>()
    
}

class HashTagObject : Object {
    @objc dynamic var hashTag : String = ""
}


// 선반 모델 생성


class ShelfDataModelList : Object {
    var books = List<BookDataModelList>()
    @objc dynamic var shelfIndex = -1
}



// 카테고리 모델 생성


class CategoryContainerDataModelList : Object
{
    @objc dynamic var categoryName = ""
    var shelves = List<ShelfDataModelList>()
}

