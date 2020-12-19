//
//  AppDelegate.swift
//  life_bookstore
//
//  Created by 송지훈 on 2020/09/01.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit
import RealmSwift

struct dummyQuestion {
    var categoryName: String
    var questionData: [String]
}

@UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate {
        
    // MARK: - variables
    let realm = try! Realm()


    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        if UserDefaults.standard.bool(forKey: "firstOpened") != true
        {
            let dummyData: [dummyQuestion] = [
                dummyQuestion(categoryName: "여행", questionData: ["가장 아름다웠던 나라는 무엇인가요?","가장 Flex 했던 나라는 어디인가요?"]),
                dummyQuestion(categoryName: "소확행", questionData: ["오늘 가장 맛있게 먹은 음식은 무엇인가요?","소소한 행복 BEST 5"]),
                dummyQuestion(categoryName: "추억", questionData: ["대학 생활 중 기억에 남는 추억은?","고등학교 생활 중 기억에 남는 추억은?"]),
                dummyQuestion(categoryName: "맛집", questionData: ["혜화 맛집을 정리해볼까요?","가봤던 맛집 중 기억에 남는 가게는?"]),
            ]
            
            dummyData.forEach { (i) in
                
                let category = CategoryContainerDataModelList()
                category.categoryName = i.categoryName
                category.shelves = List<ShelfDataModelList>()
                category.shelves.append(ShelfDataModelList()) // 최소한 1개의 shelves 는 필요하다
                
                for index in 0..<i.questionData.count {
                    
                    let insertQuestion = i.questionData[index]
                    let question = QuestionDataModel()
                    
                    
                    question.categoryName = i.categoryName
                    question.questionTitle = insertQuestion
                    
                    try! self.realm.write {
                        self.realm.add(question)
                    }
                }
                
                try! self.realm.write {
                    self.realm.add(category)
                }
            }
        
            
            UserDefaults.standard.set(true, forKey: "firstOpened")
        }
        
        //Realm Migration
        let config = Realm.Configuration (
            
            // 새로운 스키마 버전을 셋팅한다. 이 값은 이전에 사용했던 버전보다 반드시 커야 된다.
            schemaVersion: 2,

            // 셋팅한 스키마 버전보다 낮을때 자동으로 호출되는 코드 블럭을 셋팅한다.
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 2) {
                    migration.enumerateObjects(ofType: BookDataModelList.className()) { oldObject, newObject in
                        newObject!["questionName"] = ""
                        
                        migration.delete(oldObject!["questionIndex"] as! MigrationObject)
                    }
                }
            }
        )
                
        // 새로운 설정을 기본 저장소에 적용
        Realm.Configuration.defaultConfiguration = config
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

