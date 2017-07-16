import UIKit

class ModuleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    
    @IBOutlet weak var alarmFunctionTableView: UITableView!
    
    var alarmFunctions = ["Repeat", "title of alarm", "Sound"]
    
    var alarmValues = ["Every Monday", "ランニング", "Wake Me Up"]
    
    // 選択された行番号
    var selectedIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 行数カウント
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        return alarmFunctions.count
    }
    
    // 表示するセルの中身
    func tableView(_ tableView: UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        
        // 定数を表示
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! customCell2
        
        // 表示したい文字の設定 cellの中には最初からtextLabelが入っている
        cell.alarmSettings?.text = alarmFunctions[indexPath.row]
        
        cell.alarmDetailTitle?.text = alarmValues[indexPath.row]
        
        // 文字を設定さいたセル
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("選択されたデータ:\(alarmValues[indexPath.row])")
        
        // 選択された行番号をメンバ変数に格納
        selectedIndex = indexPath.row
        
        // セグエを指定して画面移動
        performSegue(withIdentifier: "showDetailAlarm", sender: nil)
    }
    
    
    // セグエを通って次の画面へ移動するとき
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        // 次の画面をインスタンス化(ダウンキャスト型変換)
        if segue.identifier == "showDetailAlarm" {
            var dvc = segue.destination as! alarmFunctionViewController
            
            // 次の画面のプロパティに選択された行番号を指定
            dvc.sIndex = selectedIndex
            dvc.alarmDetailFunction = alarmValues[selectedIndex]
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
    
    @IBAction func tapCancel(_ sender: UIBarButtonItem) {
        let next = storyboard!.instantiateViewController(withIdentifier: "toSecondView")
        self.present(next,animated: true, completion: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
