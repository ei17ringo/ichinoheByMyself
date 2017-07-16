//
//  DetailGoalViewController.swift
//  ByMyself
//
//  Created by untaka0822 on 2017/07/12.
//  Copyright © 2017年 untaka0822. All rights reserved.
//

import UIKit
import CoreData

class DetailGoalViewController: UIViewController {
    
    @IBOutlet weak var returnButton: UIBarButtonItem!
    
    @IBOutlet weak var mySmallTitle: UITextField!

    @IBOutlet weak var mySmallLimit: UILabel!
    
    @IBOutlet weak var mySmallNote: UITextView!
    
    // 前の画面から何行目が選択されたかわかる行番号を格納するプロパティ
    var sIndex = -1
    
    // 空の変数を作り値を受け取る
    var smallTitleName: String = ""
    
    // メンバ変数を用意 (CRUD処理)
    var SmallGoalSaveDate: Date = Date()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        mySmallTitle.text = smallTitleName
        
        print("前の画面から選択された行:\(sIndex)")
        
        read()
    }
    
    // 既に存在するデータの読み込み処理
    func read() {
        // AppDelegateを使う用意をしておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        
        // どのエンティティからdataを取得してくるか設定
        let query:NSFetchRequest<SmallGoals> = SmallGoals.fetchRequest()
        
        // 絞り込み検索
        // let namePredicte = NSPredicate(format: "saveDate = %@", SmallGoalSaveDate as CVarArg)
        // query.predicate = namePredicte
        
        do {
            // データを一括取得
            let fetchResults = try viewContext.fetch(query)
            
            // データの取得
            for result: AnyObject in fetchResults {
                let title: String = result.value(forKey: "title") as! String
                let time: String = result.value(forKey: "time") as! String
                let memo: String = result.value(forKey: "memo") as! String
                let saveDate: Date = result.value(forKey: "saveDate") as! Date
                
                print("title:\(title) time:\(time) memo:\(memo) saveDate:\(saveDate)")
                
                mySmallTitle!.text = title
                mySmallLimit!.text = time
                mySmallNote!.text = memo
                
                // let df = DateFormatter()
                // df.dateFormat = "yyyy/MM/dd HH:mm:ss"
                // df.locale = NSLocale(localeIdentifier: "ja_JP") as Locale!
                // saveDateLabel.text = df.string(from: saveDate!) 下も直す 

                
            }
        } catch {
            
        }
    }
    

    
    @IBAction func tapReturn(_ sender: UIBarButtonItem) {
        let next = storyboard!.instantiateViewController(withIdentifier: "toFirstView")
        self.present(next,animated: true, completion: nil)
    }
    
    // returnkeyが押された時
    @IBAction func tapReturnKey(_ sender: UITextField) {
    }
    
    
    // 更新する時
    @IBAction func tapSave(_ sender: UIBarButtonItem) {
        
        let next = storyboard!.instantiateViewController(withIdentifier: "toFirstView")
        self.present(next,animated: true, completion: nil)
        
        // AppDelegateを使う用意をしておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        
        // どのエンティティからdataを取得してくるか設定
        let query: NSFetchRequest<SmallGoals> = SmallGoals.fetchRequest()
        
        // 絞り込み検索(更新したいデータを取得する)
        let namePredicte = NSPredicate(format: "saveDate = %@", SmallGoalSaveDate as CVarArg)
        query.predicate = namePredicte
        
        do {
            // データを一括取得
            let fetchResults = try viewContext.fetch(query)
            
            // データの取得
            for result: AnyObject in fetchResults {
                // 更新する準備(NSManagedObjectにダウンキャスト型変換)
                let record = result as! NSManagedObject
                
                // 更新したいデータのセット
                record.setValue(mySmallTitle.text, forKey: "title")
                record.setValue(mySmallLimit.text, forKey: "time")
                record.setValue(mySmallNote.text, forKey: "memo")
                // record.setValue(saveDateLabel, forKey: "saveDate")
                
                do {
                    // レコードの(行)の即時保存
                    try viewContext.save()
                } catch {
                }
            }
        } catch {
            
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
