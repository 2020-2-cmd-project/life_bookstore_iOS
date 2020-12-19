//
//  ViewController.swift
//  life_bookstore
//
//  Created by 송지훈 on 2020/09/01.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit
import RealmSwift


class ViewController: UIViewController {
    
    
    
    
    
    // 컬렉션 뷰가 중첩된 형태이기 때문에 구별을 꼭 잘해야 한다 !!
    /*
     
     1.libraryCollectionView
     2.categoryBookCollectionView
     3.shelfCollectionView
     순으로 들어간다!!
     
     */
    
    var categoryItems : List<CategoryContainerDataModelList>?
    let realm = try! Realm()

    
 
    
    var categoryArray : [CategoryContainerDataModelList] = [] // REALM에서 조회해 와서 여기에 있는 어레이로 바꿔치기
    var shelfArray : [ShelfDataModelList] = []
    var bookArray : [BookDataModelList] = []
    
    var bookListInCategory : [[BookDataModelList]] = []
    
    
//    var categoryContainerData : [CategoryContainerDataModel] = []
//    var shelfData : [ShelfDataModel] = []
//    var bookData : [BookDataModel] = []
    
    
    @IBOutlet weak var libraryCollectionView: UICollectionView! // 가장 바깥을 감싸는 컬렉션 뷰
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naviSetting()
    
        
        self.libraryCollectionView.delegate = self
        self.libraryCollectionView.dataSource = self
        
        print("path =  \(Realm.Configuration.defaultConfiguration.fileURL!)")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name("reloadBookData"), object: nil)

        dataLoadFromRealm()
//     writeBooks()


    }
    
    @objc func reloadData()
    {
        print("다시 다ㅣㅣㅏ")
        bookListInCategory.removeAll()
        dataLoadFromRealm()
    }
    
    func writeBooks()
    {
        let book = BookDataModelList()
        book.title = "헤헤의 추억"
        book.content = "할로"
        book.categoryName = "소확행"
        book.questionName = "인생에 있어서 행복한 기억"
        book.time = "20.12.25"
        book.location = "혜화동"
        try! self.realm.write {
            self.realm.add(book)
            
          }
        
        
    }
    
    func dataLoadFromRealm()
    {
        let list = realm.objects(CategoryContainerDataModelList.self)
        
        let categoryRealmArray = Array(list)

        categoryArray.removeAll()
        categoryArray = categoryRealmArray
        
        libraryCollectionView.reloadData()
        
        
        let booklist = realm.objects(BookDataModelList.self)
        let bookRealmArray = Array(booklist)
        
        bookArray.removeAll()
        bookArray = bookRealmArray
        
        
        
        if categoryArray.count > 0
        {
            for i in 0 ... categoryArray.count - 1
            {
                let bookRealmData = realm
                    .objects(BookDataModelList.self)
                    .filter("categoryName == '\(categoryArray[i].categoryName)'")
                

                
                bookListInCategory.append(Array(bookRealmData))
                
                
            }
        }
        print("지금 데이터 상황",bookListInCategory)
        
        self.libraryCollectionView.reloadData()

        
 
        
    }
    

    
    func naviSetting()
    {
        self.navigationController?.navigationBar.isHidden = true
    }

    
    @IBAction func searchButtonClicked(_ sender: Any) {
        
        let searchStoryboard = UIStoryboard(name: "bookSearch", bundle: nil)
        
        guard let searchVC =  searchStoryboard.instantiateViewController(identifier: "BookSearchViewController") as? BookSearchViewController else {return}
        
        self.navigationController?.pushViewController(searchVC, animated: true)
        
    
        
    
    }
    
    
    
    

}

extension ViewController : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource
{

    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == categoryArray.count
        {
            
            let alertController = UIAlertController(title: "새 카테고리 만들기" , message: "추가할 카테고리를 입력해주세요", preferredStyle: .alert)
            
            alertController.addTextField { (myTextField) in
                myTextField.placeholder = "이름을 입력해주세요..."
            }
            let okAction = UIAlertAction(title: "확인", style: .default) { (_) in
           
                
                let text = alertController.textFields?[0].text
                
                
                let category = CategoryContainerDataModelList()
                
                category.categoryName = text ?? ""
                category.shelves = List<ShelfDataModelList>()
                category.shelves.append(ShelfDataModelList()) // 최소한 1개의 shelves 는 필요하다 
                
                
                try! self.realm.write {
                    self.realm.add(category)
                    
                  }
                
                
                let alert = UIAlertController(title: "알림", message: "카테고리가 추가되었습니다", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default) { (_) in
                    self.dataLoadFromRealm()
                }
                alert.addAction(ok)
                
                
                self.present(alert, animated: true, completion: nil)
                
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            
            self.present(alertController, animated: true, completion: nil)
            
            
            
        }
        
        else // 일반 셀을 클릭한 경우 뷰로 넘어가야 합니다
        {
            
            let searchStoryboard = UIStoryboard(name: "bookSearch", bundle: nil)
            
            guard let searchVC =  searchStoryboard.instantiateViewController(identifier: "BookSearchViewController") as? BookSearchViewController else {return}
            
            searchVC.bookData = bookListInCategory[indexPath.row]
            searchVC.categoryName = categoryArray[indexPath.row].categoryName
            searchVC.isViewMode = true
            
            self.navigationController?.pushViewController(searchVC, animated: true)
            
        
            
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            return self.categoryArray.count + 1 // 추가 셀 넣기 위해서
        

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row != self.categoryArray.count
        {
            guard let categoryContainerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryContainerCollectionCell", for: indexPath) as? CategoryContainerCollectionCell else { return UICollectionViewCell() }
            
            let shelvesData = Array(categoryArray[indexPath.row].shelves)

            categoryContainerCell.setName(name: categoryArray[indexPath.row].categoryName, shelves: shelvesData,books: bookListInCategory[indexPath.row])
            

            
            
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

