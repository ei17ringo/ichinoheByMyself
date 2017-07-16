

import Foundation
import UIKit

class DateManager {
    
    private let formatter = DateFormatter()
    private let date = Date()
    private var dateStr: String?
    private let calendar = Calendar(identifier: .gregorian)
    
    init(){
        formatter.timeZone = NSTimeZone.system
        formatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        dateStr = ""
    }
    
    //現在時刻を返します"yyyy-MM-dd-HH-mm-ss"
    func getNowDate() -> String{
        dateStr = formatter.string(from: date)
        guard let now = dateStr else { return ""}
        return now
    }
    
    //設定したカウントダウンの秒数を返してくれます
    func getXmaxTimeInterval() -> Int {
        guard let goal = calendar.date(from: DateComponents(year: 2017, month: 07, day: 28, hour: 17, minute: 00, second: 00)) else { return 0}
        let spanFromWow = goal.timeIntervalSinceNow
        return Int(floor(spanFromWow))
    }
    
}
