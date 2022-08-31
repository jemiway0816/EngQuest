//
//  ViewController.swift
//  EngQuest
//
//  Created by jemiway on 2022/8/21.
//

import UIKit

class ViewController: UIViewController {

 
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerButton: [UIButton]!
    
    
    @IBOutlet weak var questLbl: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var startOutletButtom: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var downImageView: UIImageView!
    @IBOutlet weak var upImageView: UIImageView!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    
    @IBOutlet weak var clearButton: UIButton!

    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        answerButton[0].layer.cornerRadius = 30
        answerButton[1].layer.cornerRadius = 30
        answerButton[2].layer.cornerRadius = 30
        answerButton[3].layer.cornerRadius = 30
        
        startOutletButtom.layer.cornerRadius = 20
        mainImageView.layer.cornerRadius = 30
        upImageView.layer.cornerRadius = 30
        downImageView.layer.cornerRadius = 30
        clearButton.layer.cornerRadius = 30
        
        
        clearResult()
        
        getTestData()
        
        onPlay()
    }


    func updateUI()
    {
      
        // 顯示按鈕
        startOutletButtom.setTitle("開始", for: .normal)
        startOutletButtom.backgroundColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
    }
    
    var quest = 0
    
    
    func countdown(timer: Timer)
    {
        
        // 顯示訊息框
        let controller = UIAlertController(title: "計時結束",
                                           message: "答對 : \(self.correctNum)題，答錯 : \(self.wrongNum)題",
                                           preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
        
        updateUI()
        
        
    }
    
    func clearResult()
    {
        correctNum = 0
        wrongNum = 0
        correctLabel.text = "答對 : \(correctNum)"
        wrongLabel.text = "答錯 : \(wrongNum)"
    }
    
    @IBAction func clearActBtm(_ sender: Any)
    {
        clearResult()
        nextQuesion()
    }
    
    
    
    @IBAction func startButton(_ sender: UIButton)
    {
        var questIndex = Int(questLbl.text!) ?? 10
        
        questLbl.text
        
        
    }
    
    func isSame(_ key:String , _ value:[String]) -> Bool
    {
        return value.contains(key)
    }
    
    var answerNum = 0
    var correctNum = 0
    var wrongNum = 0
    
    func onPlay()
    {
        // 隨機取得題目與答案
        let topic = vocabularyDic.randomElement()

        questionLabel.text = topic!.key
        answerNum = Int.random(in: 0...3)

        var allAnswer:[String] = ["","","",""]

        answerButton[answerNum].setTitle(topic!.value, for: .normal)
        allAnswer[answerNum] = topic!.value
        
        // 隨機取得錯誤的答案
        for i in 0...3
        {
            if answerNum != i
            {
                var wrong = vocabularyDic.randomElement()
                
                while isSame(wrong!.value, allAnswer)
                {
                    wrong = vocabularyDic.randomElement()
                }
                allAnswer[i] = wrong!.value
                answerButton[i].setTitle(wrong!.value, for: .normal)
            }
        }
    }
    
    @IBAction func showResult(_ sender: UIButton)
    {
        // 偵測按下哪一個按鈕
        var pressNum = 0
        switch sender
        {
            case answerButton[0]:
                pressNum = 0
            
            case answerButton[1]:
                pressNum = 1

            case answerButton[2]:
                pressNum = 2

            case answerButton[3]:
                pressNum = 3

            default:
                break
        }
        
        if answerNum == pressNum
        {
            correctNum += 1
        }
        else
        {
            // 按下錯誤答案
            answerButton[pressNum].backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            
            wrongNum += 1
        }
        
        
        // 正確答案背景改為綠色
        answerButton[answerNum].backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
        
        // 錯誤答案背景改回白色
        for i in 0...3
        {
            if i != answerNum && i != pressNum
            {
                answerButton[i].backgroundColor = UIColor(red: 200/255, green: 223/255, blue: 188/255, alpha: 1)
            }
        }
        correctLabel.text = "答對 : \(correctNum)"
        wrongLabel.text = "答錯 : \(wrongNum)"
        
    }
    
    func nextQuesion()
    {
        // update UI
        for i in 0...3
        {
            answerButton[i].setTitle("", for: .normal)
            answerButton[i].backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 1, alpha: 1)
        }
       
        // 重新出題
        onPlay()
    }
    
    @IBAction func nextButton(_ sender: UIButton)
    {
        nextQuesion()
    }
        
    var vocabularyDic:[String:String] = ["":""]
    
    func getTestData()
    {
        var raw_data = ""
        
        // 從檔案讀取題庫
        if  let url = Bundle.main.url(forResource: "senior_7000_1", withExtension: "txt")
        {
            do
            {
                try raw_data = String(contentsOf: url)
            }
            catch
            {
                print("出錯了！！無法讀取檔案內容")
            }
        }
        
        // 讀入的檔案存成字典
        if raw_data != ""
        {
            let lines = raw_data.split(separator:"\r\n")
            
            for line in lines
            {
                let datas:[Substring] = line.split(separator: ",")
                vocabularyDic[String(datas[0])] = String(datas[1])
            }
        }
    }
}

