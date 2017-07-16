//
//  FirstViewController.swift
//  ByMyself
//
//  Created by untaka0822 on 2017/06/28.
//  Copyright © 2017年 untaka0822. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController,UITabBarDelegate,UITableViewDataSource {

    @IBOutlet weak var myWords: UILabel!
    
    @IBOutlet weak var myName: UILabel!
    
    @IBOutlet weak var countLabel: SpringLabel!
    
    @IBOutlet weak var countLabel1: SpringLabel!
    
    @IBOutlet weak var bigGoalName: UILabel!
    
    @IBOutlet weak var helpButton: UIButton!
    
    @IBOutlet weak var plusButton: UIButton!

    @IBOutlet weak var smallTableView: UITableView!
    
    @IBAction func goBackFirst(_ segue:UIStoryboardSegue) {}
    
    let date = DateManager()
    
    // 大きい目標用Timer
    var timer: Timer!
    
    // セルの中身ようにTimerを用意
    var celltimer: Timer!
    
    // 小さい目標名
    var smallGoalNames: [String] = ["よしきさん", "冨樫"]
    
    // 小さい目標の時間
    var smallGoalTimes = [""]
    
    // 小さい目標のメモ
    var smallGoalTodo = [""]
    
    // 全く選択されていない時に入る値
    var selectedIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        read()
    }
    
    // 既に存在するデータの読み込み処理
    func read() {
        
        // AppDelegateを使う用意をしておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        
        // どのエンティティからdataを取得してくるか設定
        let query: NSFetchRequest<BigGoal> = BigGoal.fetchRequest()
        
        do {
            // データを一括取得
            let fetchResults = try viewContext.fetch(query)
            
            // データの取得
            for result: AnyObject in fetchResults {
                let title: String? = result.value(forKey: "title") as? String
                let time: String? = result.value(forKey: "time") as? String
                let saveDate: Date? = result.value(forKey: "saveDate") as? Date
                
                print("title:\(bigGoalName) time1:\(countLabel) time2:\(countLabel1) saveDate:\(saveDate)")
            }
        } catch {
            
        }
        
    }
    
    
    // 小さい目標を削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            smallGoalNames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        // カウントダウン処理
        super.viewWillAppear(true)
        //カウントダウン
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        timer.fire()
        
        // Motivation.plistの辞書型
        var person = ["person1","person2","person3","person4","person5","person6","person7","person8","person9","person10","person11","person12","person13","person14","person15","person16","person17","person18","person19","person20", "person21"]
        
        let random = Int(arc4random()) % person.count
        
        // info.plistから引っ張ってくる
        let filePath = Bundle.main.path(forResource: "Motivation", ofType: "plist")
        
        let dic = NSDictionary(contentsOfFile: filePath!)
        let detailInfo:NSDictionary = dic![person[random]] as! NSDictionary
        
        myName.text = "-- " + (detailInfo["name"] as! String) + " --"
        myWords.text = (detailInfo["words"] as! String)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        timer.invalidate()
        timer = nil
    }

    
    // 表示するセルの中身を作る
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellGoal", for: indexPath) as! customCell1
        
        cell.smallGoal.text = smallGoalNames[indexPath.row]
        
        // 各時間帯を時間内に
        var count: Int = date.getXmaxTimeInterval()
        
        var min: Int = count / 60
        
        var hour: Int = min / 60
        
        var day: Int = hour / 24
        
        // 強制終了
        if count <= 0 {
            timer.invalidate()
        }
        
        // 0以下にならないようにする記述
        if count <= 0 {
            count = 0
        }
        
        if min <= 0 {
            min = 0
        }
        
        if hour <= 0 {
            hour = 0
        }
        
        if day <= 0 {
            day = 0
        }
        
        if count % 10 == 0 {
            animateLabel(label: countLabel)
        }
        
        if count % 60 == 0 {
            animateLabel1(label: countLabel)
        }
        
        // 小さい目標の期限
        cell.smallGoal.text = "\(day % 365)日\(hour % 24)時間\(min % 60)分\(count % 60)秒"
        
        // 小さい目標用のタイマー
        cell.setTimer(Label: cell.smallGoal)
        
        // 小さい目標名
        cell.smallGoalNameLabel.text = smallGoalNames[indexPath.row]
        
        return cell
        
    }

    

    func update(tm: Timer) {
        // 各時間帯を時間内に
        var count: Int = date.getXmaxTimeInterval()
        
        var min: Int = count / 60
        
        var hour: Int = min / 60
        
        var day: Int = hour / 24
        
        var year: Int = day / 365
        
        // 強制終了
        if count <= 0 {
            timer.invalidate()
        }
        
        // 0以下にならないようにする記述
        if count <= 0 {
            count = 0
        }
        
        if min <= 0 {
            min = 0
        }
        
        if hour <= 0 {
            hour = 0
        }
        
        if day <= 0 {
            day = 0
        }
        
        if year <= 0 {
            year = 0
        }
        
        if count % 10 == 0 {
            animateLabel(label: countLabel)
        }
        
        if count % 60 == 0 {
            animateLabel1(label: countLabel)
        }
        
        
        // 出力 yearはそのまま 日にちは1年で365日、1日は24時間、1時間は60分、1分は60秒という計算
        countLabel.text = "残り\(year)年\(day % 365)日"
        
        countLabel1.text = "\(hour % 24)時間\(min % 60)分\(count % 60)秒"
        
    }
    
    func animateLabel1(label: SpringLabel) {
        
        countLabel.animation = "flash"
        countLabel.curve = "easeIn"
        countLabel.duration = 0.2
        countLabel.animate()
        
        countLabel1.animation = "flash"
        countLabel1.curve = "easeIn"
        countLabel1.duration = 0.2
        countLabel1.animate()
        
    }
    
    func animateLabel(label: SpringLabel) {
        
        countLabel.animation = "pop"
        countLabel.curve = "easeIn"
        countLabel.duration = 1.0
        countLabel.animate()
        
        countLabel1.animation = "pop"
        countLabel1.curve = "easeIn"
        countLabel1.duration = 1.0
        countLabel1.animate()

    }
    
    // 行数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return smallGoalNames.count
        
    }
    
    // セルがタップされたとき
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("選択されたデータ:\(smallGoalNames[indexPath.row])")
        selectedIndex = indexPath.row
        
        // セグエを通して画面移動
        performSegue(withIdentifier: "showDetailGoal", sender: smallGoalNames[indexPath.row])
        
    }
    
    // セグエを通って次の画面へ移動するとき
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailGoal" {
            //次の画面をインスタンス化(as:ダウンキャスト型変換)
            let dvc = segue.destination as! DetailGoalViewController
    
            //次の画面のプロパティに選択された行番号を指定
            dvc.sIndex = selectedIndex
            dvc.smallTitleName = smallGoalNames[selectedIndex]
            
            //dvc.smallTitleName = smallGoalNames[sender! as! Int] as! String
            // dvc.smallGoalTime = smallGoalTimes[sender! as! Int] as! String
            
        }
    }

    // helpボタン
    @IBAction func helpButton(_ sender: UIButton) {
        // セグエを通して画面移動
        self.performSegue(withIdentifier: "toHelp", sender: nil)
    }

    // plusボタン
    @IBAction func plusButton(_ sender: UIButton) {
        // セグエを通して画面移動
        self.performSegue(withIdentifier: "toAdd", sender: nil)
    }
    
    //ボタン押下時に呼ばれるメソッド
    @IBAction func changeMode(sender: AnyObject) {
        //通常モードと編集モードを切り替える。
        if(smallTableView.isEditing == true) {
            smallTableView.isEditing = false
        } else {
            smallTableView.isEditing = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

