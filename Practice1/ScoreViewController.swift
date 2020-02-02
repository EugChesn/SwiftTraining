//
//  ScoreViewController.swift
//  Practice1
//
//  Created by Евгений on 02.02.2020.
//  Copyright © 2020 Евгений. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    var numbersGame : UInt32 = 0
    var numbersWin : UInt32?
    var averageStepForWin: Double = 0
    
    @IBOutlet weak var numbersGameLabel : UILabel!
    @IBOutlet weak var numbersWinLabel : UILabel!
    @IBOutlet weak var numbersAverageLabel : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let numStr = numbersGameLabel.text{
            numbersGameLabel.text = numStr + String(numbersGame)
        }
        
        if let wins = numbersWin{
            if let winsStr = numbersWinLabel.text{
                numbersWinLabel.text = winsStr + String(wins)
            }
            averageStepForWin = Double(numbersGame) / Double(wins)
            if let averageStr = numbersAverageLabel.text{
                numbersAverageLabel.text = averageStr + " \(averageStepForWin)"
            }
        }
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
