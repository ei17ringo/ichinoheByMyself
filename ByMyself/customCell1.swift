//
//  customCell1.swift
//  ByMyself
//
//  Created by untaka0822 on 2017/07/06.
//  Copyright © 2017年 untaka0822. All rights reserved.
//

import UIKit

class customCell1: UITableViewCell {

    @IBOutlet weak var smallGoal: SpringLabel!
    
    @IBOutlet weak var smallGoalNameLabel: SpringLabel!
    
    var smallGoalTime = ""
    
    var smallGoalName:String = ""
    
    var timer: Timer!
    
    let date = DateManager()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setTimer(Label:UILabel) {
        
        //カウントダウン
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func update(tm: Timer) {
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
            animateLabel(label: smallGoal)
        }
        
        if count % 60 == 0 {
            animateLabel1(label: smallGoal)
        }
        

        // 出力 yearはそのまま 日にちは1年で365日、1日は24時間、1時間は60分、1分は60秒という計算
        smallGoal.text = "\(day % 365)日\(hour % 24)時間\(min % 60)分\(count % 60)秒"
    
    }
    
    
    func animateLabel1(label: SpringLabel) {
        
        label.animation = "flash"
        label.curve = "easeIn"
        label.duration = 0.2
        label.animate()
        
        label.animation = "flash"
        label.curve = "easeIn"
        label.duration = 0.2
        label.animate()
        
    }
    
    func animateLabel(label: SpringLabel) {
        
        label.animation = "pop"
        label.curve = "easeIn"
        label.duration = 1.0
        label.animate()
        
        label.animation = "pop"
        label.curve = "easeIn"
        label.duration = 1.0
        label.animate()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
