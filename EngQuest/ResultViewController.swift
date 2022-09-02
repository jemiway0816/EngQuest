//
//  ResultViewController.swift
//  EngQuest
//
//  Created by Jemiway on 2022/8/31.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDataSource
{
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var backImgView: UIImageView!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet var questTableView: UITableView!
    
    weak var ViewController:ViewController!
    
    var currentNum = 0
    var wrongNum = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        backImgView.layer.cornerRadius = 30
        resultLbl.text = "答對\(currentNum)題 , 答錯\(wrongNum)題"
        
        let allNum = currentNum + wrongNum
        
        scoreLbl.text = String(currentNum * 100 / allNum)
        
        questTableView.dataSource = self
        
//        print(ViewController.questTable[10].cht)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ViewController.questTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        
        let quest = ViewController.questTable[indexPath.row]
        cell.textLabel?.text = quest.eng
        cell.detailTextLabel?.text = quest.cht
        
        if quest.result == 1
        {
            cell.backgroundColor = .red
        }
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
