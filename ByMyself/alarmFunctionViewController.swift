//
//  alarmFunctionViewController.swift
//  ByMyself
//
//  Created by untaka0822 on 2017/07/13.
//  Copyright © 2017年 untaka0822. All rights reserved.
//

import UIKit

class alarmFunctionViewController: UIViewController {
    
    @IBOutlet weak var alarmFunction: UITextField!

    var sIndex = -1
    
    var alarmDetailFunction: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        alarmFunction.text = alarmDetailFunction
        
    }

    @IBAction func tapReturnKet(_ sender: UITextField) {
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
