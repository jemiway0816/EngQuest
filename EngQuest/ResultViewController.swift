//
//  ResultViewController.swift
//  EngQuest
//
//  Created by Jemiway on 2022/8/31.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var backImgView: UIImageView!
    @IBOutlet weak var scoreLbl: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()

        backImgView.layer.cornerRadius = 30
        
        resultLbl.text = "答對\(currentNum)題 , 答錯\(wrongNum)題"
        scoreLbl.text = String(currentNum * 10)
    }
    
    var currentNum = 0
    var wrongNum = 0
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
