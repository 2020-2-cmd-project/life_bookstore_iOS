//
//  CategoryContainerCollectionCell.swift
//  life_bookstore
//
//  Created by 송지훈 on 2020/10/01.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryContainerCollectionCell: UICollectionViewCell {
    @IBOutlet weak var categoryContainerCollectionView: UICollectionView! // 한개 카테고리내에 있는 선반들을 담는 컬렉션 뷰
    
    @IBOutlet weak var categoryName: UILabel!
    let realm = try! Realm()


    var shelfData : [ShelfDataModelList] = []
    var bookData : [BookDataModelList] = []
    
    func setName(name : String, shelves : [ShelfDataModelList], books : [BookDataModelList])
    {
        self.categoryName.text = name
        
        self.categoryName.font = UIFont(name: "BareunBatangOTFPro-1", size: 16)
        
        
        self.shelfData = shelves
        self.bookData = books
        
        
        categoryContainerCollectionView.reloadData()

 
    }
    
    @IBAction func addBookInCategory(_ sender: Any) {
    }
}



extension CategoryContainerCollectionCell : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.shelfData.count


    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        guard let shelfContainerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShelfContainerCollectionCell", for: indexPath) as? ShelfContainerCollectionCell else { return UICollectionViewCell() }
        
        let bookData = Array(shelfData[indexPath.row].books)
        shelfContainerCell.settingBook(book: self.bookData)


        return shelfContainerCell

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.size.width
        return CGSize(width:width , height: 93)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets { // 섹션 안에 마진 셋팅
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { // 옆라인 간격 조정
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { // 위 아래 간격 조정
        return 20
    }
    
    
    
}
