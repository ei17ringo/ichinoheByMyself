//
//  AddGoalViewController.swift
//  ByMyself
//
//  Created by untaka0822 on 2017/06/30.
//  Copyright © 2017年 untaka0822. All rights reserved.
//

import UIKit
import CoreData

class AddGoalViewController: UIViewController {
    
    @IBOutlet weak var goalTitle: UITextField!
    
    @IBOutlet weak var goalLimit: UIDatePicker!

    var Goal = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // キャンセルがおされた時
    @IBAction func tapCancel(_ sender: UIBarButtonItem) {

    let next = storyboard!.instantiateViewController(withIdentifier: "toFirstView")
        self.present(next,animated: true, completion: nil)
        
    }
    
    
    // TextFieldのリターンキーが押されたとき
    @IBAction func tapReturnKey(_ sender: UITextField) {
    }
    
    @IBAction func tapDone(_ sender: UIBarButtonItem) {
        
        let next = storyboard!.instantiateViewController(withIdentifier: "toFirstView")
        self.present(next,animated: true, completion: nil)
        
        
        // AppDelegateを使う用意しておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        
        // エンティティ名でオブジェクトを作成
        let BigGoal = NSEntityDescription.entity(forEntityName: "BigGoal", in: viewContext)
        
        // BigGoalエンティティにレコード(行)を挿入するためのオブジェクトを作成
        let newRecord = NSManagedObject(entity: BigGoal!, insertInto: viewContext)
        
        // 値のセット
        newRecord.setValue(goalTitle, forKey: "title") // 値を代入
        newRecord.setValue(goalLimit, forKey: "time")
        
        do {
            // レコード(行)の即時保存
            try viewContext.save()
        } catch {
            
        }

    }
    
    
    
    // 選択された日付が変わった時発動
    @IBAction func tapDatePicker(_ sender: UIDatePicker) {
        
        // 日付を文字列に変換するためのフォーマットを設定
        let df = DateFormatter()
        
        // フォーマットの設定
        df.dateFormat = "yyyy/MM/dd HH:mm"
        
        print(df.string(from: sender.date))
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
