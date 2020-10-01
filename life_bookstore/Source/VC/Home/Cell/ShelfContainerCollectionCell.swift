//
//  ShelfContainerCollectionCell.swift
//  life_bookstore
//
//  Created by 송지훈 on 2020/10/01.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class ShelfContainerCollectionCell: UICollectionViewCell {
    @IBOutlet weak var bookConainerCollectionView: UICollectionView! // 책 담는 컬렉션 뷰
    
    @IBOutlet weak var shelfWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bookShelfImage: UIImageView!
    var bookData : [BookDataModel] = []
    
    func settingBook(book : [BookDataModel])
    {
        self.bookData = book
        
        let width = UIScreen.main.bounds.size.width

        self.shelfWidthConstraint.constant = width - 78
    }
}



extension ShelfContainerCollectionCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bookData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let bookContainerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookContainerCollectionCell", for: indexPath) as? BookContainerCollectionCell else { return UICollectionViewCell() }
        
        return bookContainerCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        

            return CGSize(width: 14, height: 80)
    }

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets { // 섹션 안에 마진 셋팅
        
        return UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { // 옆라인 간격 조정
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { // 위 아래 간격 조정
        return 3
    }
    
    
    
}
