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
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getTestData()
        
        onPlay()
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
        
     
        let topic = vocabularyDic.randomElement()
        
        questionLabel.text = topic!.key
        answerNum = Int.random(in: 0...3)
        
        var allAnswer:[String] = ["","","",""]
        
        answerButton[answerNum].setTitle(topic!.value, for: .normal)
        allAnswer[answerNum] = topic!.value
        
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
            resultLabel.text = " 正確 !! "
            resultLabel.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            correctNum += 1
        }
        else
        {
            resultLabel.text = " 錯誤 >< "
            resultLabel.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            wrongNum += 1
        }
        
        answerButton[answerNum].backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
        
        for i in 0...3
        {
            if i != answerNum
            {
                answerButton[i].backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            }
        }
        correctLabel.text = "答對 : \(correctNum)"
        wrongLabel.text = "答錯 : \(wrongNum)"
    }
    
    
    
    @IBAction func nextButton(_ sender: UIButton)
    {
        for i in 0...3
        {
            answerButton[i].setTitle("", for: .normal)
            answerButton[i].backgroundColor = UIColor(red: 50/255, green: 173/255, blue: 230/255, alpha: 1)
        }
        resultLabel.text = " 請選擇 "
        resultLabel.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        onPlay()
    }
    
    
    var vocabularyDic:[String:String] = ["":""]
    
    func getTestData()
    {
        var raw_data = ""
        
//            try raw_data = String(contentsOfFile: "/Users/jemiway/code/EngQuest/EngQuest/test.txt")
                                 
        if let url = Bundle.main.url(forResource: "SwiftBook", withExtension: "bundle"), let bundle = Bundle(url: url),let path = bundle.path(forResource: "junior-1200_2", ofType: "txt")
        {
            do
            {
                try raw_data = String(contentsOfFile: path)
            }
            catch
            {
                print("出錯了！！無法讀取檔案內容")
            }
            
//            print("raw_data : \(raw_data)")
        }
    
        if raw_data != ""
        {
            let lines = raw_data.split(separator:"\r\n")
            
            for line in lines
            {
                let datas:[Substring] = line.split(separator: ",")
                vocabularyDic[String(datas[0])] = String(datas[1])
            }
            print(vocabularyDic)
        }
    }
}

