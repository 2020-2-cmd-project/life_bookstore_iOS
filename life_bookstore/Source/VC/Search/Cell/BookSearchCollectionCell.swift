//
//  BookSearchCollectionCell.swift
//  life_bookstore
//
//  Created by 송지훈 on 2020/12/19.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class BookSearchCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var bookBackgroundView: UIView!
    
    
    func setData(title: String, date : String, coverImageData : Data,color : String)
    {
        
        self.titleLabel.text = title
        self.dateLabel.text = date
        
        if !coverImageData.isEmpty
        {
            self.coverImageView.image = UIImage(data: coverImageData)
        }
        
        
        bookBackgroundView.backgroundColor = .init(red: 212/255, green: 212/255, blue: 212/255, alpha: 1)
        
        
    }
}
