//
//  BookCategoryViewController.swift
//  life_bookstore
//
//  Created by taehy.k on 2020/12/11.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit
import RealmSwift

struct cellData {
    var opened = Bool()
    var categoryName = String()
    var sectionData = [String]()
}


class BookCategoryViewController: UIViewController {

    //MARK: - IBOutlet Part
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!
    
    
    //MARK: - Variable Part
    let realm = try! Realm()
    var categoryArray : [CategoryContainerDataModelList] = []
    var questionArray : [QuestionDataModel] = []
    var tableViewData : [cellData] = [
        
    
//        cellData(opened: false, categoryName: "여행", sectionData: ["가장 아름다웠던 나라는 무엇인가요?","가장 Flex 했던 나라는 어디인가요?"]),
//        cellData(opened: false, categoryName: "소확행", sectionData: ["오늘 가장 맛있게 먹은 음식은 무엇인가요?","소소한 행복 BEST 5"]),
//        cellData(opened: false, categoryName: "추억", sectionData: ["대학 생활 중 기억에 남는 추억은?","고등학교 생활 중 기억에 남는 추억은?"]),
//        cellData(opened: false, categoryName: "맛집", sectionData: ["혜화 맛집을 정리해볼까요?","가봤던 맛집 중 기억에 남는 가게는?"]),
    ]
    
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        dataLoadFromRealm()
        
    }
    
    
    
    //MARK: - Default Setting
    func dataLoadFromRealm()
    {
        let list = realm.objects(CategoryContainerDataModelList.self)
        let questionList = realm.objects(QuestionDataModel.self)
        
        let categoryRealmArray = Array(list)
        let questionRealmArray = Array(questionList)
        
        
        categoryArray.removeAll()
        categoryArray = categoryRealmArray
        
        questionArray.removeAll()
        questionArray = questionRealmArray
        
        for i in 0..<categoryArray.count {
            
            
            var questionStringList : [String] = []
            let object = realm.objects(QuestionDataModel.self).filter("categoryName == '\(categoryArray[i].categoryName)'")
            
            
            let questionList = Array(object)
            
            
            if questionList.count > 0
            {
                for i in 0 ... questionList.count - 1
                {
                    questionStringList.append(questionList[i].questionTitle)
                }
            }
            
            tableViewData.append(cellData(opened: false, categoryName: categoryArray[i].categoryName, sectionData: questionStringList))
            
        }
        

        
        tableView.reloadData()
    }
    
    
    //MARK: - IBAction
    @IBAction func closeButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}


//MARK: - TableView Extension
extension BookCategoryViewController: UITableViewDelegate, UITableViewDataSource {


    // 섹션 수
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryArray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 44
        } else {
            return 52
        }
    }

    
    // 섹션 밑에 데이터 행
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            if tableViewData[section].opened == true {

                return tableViewData[section].sectionData.count + 1

            } else {

                return 1

            }

    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        if indexPath.row == 0 {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoryTableCell", for: indexPath) as? CategoryTableViewCell else {
                return UITableViewCell()
            }


            cell.categoryTitleLabel.text = tableViewData[indexPath.section].categoryName

            return cell

        } else {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "questionTableCell", for: indexPath) as? QuestionTableViewCell else {
                return UITableViewCell()
            }

//            print(tableViewData[indexPath.section].sectionData[indexPath.row - 1])
            cell.backgroundColor = .init(red: 90/255, green: 178/255, blue: 174/255, alpha: 1)
            cell.setData(content: tableViewData[indexPath.section].sectionData[indexPath.row - 1])

            return cell
        }
        

    }
    

    
    
// MARK: - Table Expansion
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
          
            
            if tableViewData[indexPath.section].opened == true {

                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)

            } else {

                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
            
            
        } else {
            
            print(tableViewData[indexPath.section].categoryName)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "clickedQuestionCell"), object: tableViewData[indexPath.section].sectionData[indexPath.row - 1])
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "clickedCategoryCell"), object: tableViewData[indexPath.section].categoryName)
            
            
            dismiss(animated: true, completion: nil)
            
            
        }

        
    }
    
}

