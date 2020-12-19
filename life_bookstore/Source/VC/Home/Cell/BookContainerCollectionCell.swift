//
//  BookContainerCollectionCell.swift
//  life_bookstore
//
//  Created by 송지훈 on 2020/10/01.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class BookContainerCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var bookView: UIView!
    // 컬러도 랜덤으로 뽑아야 한다
    @IBOutlet weak var bookViewHeightConstraint: NSLayoutConstraint! // 랜덤으로 오르락 내리락 해야함
    // 60 ~ 80 사이에서 놀아야 한다
    
    
    func setColor(color : UIColor)
    {
        self.bookView.backgroundColor = color
        self.bookViewHeightConstraint.constant = CGFloat(Int.random(in: 60 ... 80))
    }
    
    
    
    
    
}


