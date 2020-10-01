//
//  ShelfDataModel.swift
//  life_bookstore
//
//  Created by 송지훈 on 2020/10/01.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation

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
