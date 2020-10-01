//
//  CategoryContainerDataModel.swift
//  life_bookstore
//
//  Created by 송지훈 on 2020/10/01.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation


struct CategoryContainerDataModel
{
    var shelves : [ShelfDataModel]
    var categoryName : String
    
    
    
    init(name : String)
    {
        self.categoryName = name
        self.shelves = []
    }
    
    init(shelves : [ShelfDataModel], name : String)
    {
        self.categoryName = name
        self.shelves = shelves
    }
}
