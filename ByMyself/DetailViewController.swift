//
//  DetailViewController.swift
//  ByMyself
//
//  Created by untaka0822 on 2017/06/28.
//  Copyright © 2017年 untaka0822. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var alarmName: UILabel!
    
    // 前の画面から何行目が選択されたかわかる行番号を格納するプロパティ
    var sIndex = -1
    
    var name:String = ""
    
    var alarm:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("前の画面から選択された行:\(sIndex)")
            
        myLabel.text = name
        alarmName.text = alarm
        
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
