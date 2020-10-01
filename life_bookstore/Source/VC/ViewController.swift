//
//  ViewController.swift
//  life_bookstore
//
//  Created by 송지훈 on 2020/09/01.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // 컬렉션 뷰가 중첩된 형태이기 때문에 구별을 꼭 잘해야 한다 !!
    /*
     
     1.libraryCollectionView
     2.categoryBookCollectionView
     3.shelfCollectionView
     순으로 들어간다!!
     
     */
    
    var categoryContainerData : [CategoryContainerDataModel] = []
    var shelfData : [ShelfDataModel] = []
    var bookData : [BookDataModel] = []
    
    
    @IBOutlet weak var libraryCollectionView: UICollectionView! // 가장 바깥을 감싸는 컬렉션 뷰
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naviSetting()
        defaultSetting()
        
        self.libraryCollectionView.delegate = self
        self.libraryCollectionView.dataSource = self
        
    }
    
    
    func defaultSetting() // 서버 있기전에 더미로 넣는 작업
    {

        

        
        let book1 = BookDataModel()
        let book2 = BookDataModel()
        bookData.append(book1)
        bookData.append(book2)
        
        let shelf1 = ShelfDataModel(books: bookData, index: 0)
        shelfData.append(shelf1)
        
        let category1 = CategoryContainerDataModel(shelves: shelfData, name: "감정")
        categoryContainerData.append(category1)
        

    }
    
    func naviSetting()
    {
        self.navigationController?.navigationBar.isHidden = true
    }


}

extension ViewController : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource
{

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            return self.categoryContainerData.count + 1 // 추가 셀 넣기 위해서
        

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row != self.categoryContainerData.count
        {
            guard let categoryContainerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryContainerCollectionCell", for: indexPath) as? CategoryContainerCollectionCell else { return UICollectionViewCell() }
            
            categoryContainerCell.setName(name: self.categoryContainerData[indexPath.row].categoryName, shelves: self.shelfData)
            

            
            return categoryContainerCell
        }
        else
        {
            
            guard let categoryAddCell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCategoryButtonCell", for: indexPath) as? AddCategoryButtonCell else { return UICollectionViewCell() }
            
     
            
            return categoryAddCell
        }


    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.libraryCollectionView.frame.size.width

        return CGSize(width: width, height: 200)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets { // 섹션 안에 마진 셋팅
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { // 옆라인 간격 조정
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { // 위 아래 간격 조정
        return 0
    }
    
    
}

