//
//  SettingsViewController.swift
//  Practice1
//
//  Created by Евгений on 01.02.2020.
//  Copyright © 2020 Евгений. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var range : (UInt32, UInt32) = (0, 100)
    
    @IBOutlet weak var max : UITextField!
    @IBOutlet weak var min : UITextField!
    
    weak var delegate: FirstViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func sendUpdateSettings(){
        if let maxValStr = max.text {
            if let minValStr = min.text{
                range = (UInt32(minValStr) ?? 0 , UInt32(maxValStr) ?? 100)
            }
        }
        delegate?.update(range.0, range.1)
    }
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
    }*/

}
