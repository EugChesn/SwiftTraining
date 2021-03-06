//
//  SettingsViewController.swift
//  Practice1
//
//  Created by Евгений on 01.02.2020.
//  Copyright © 2020 Евгений. All rights reserved.
//

import UIKit

fileprivate enum ResultVerifyDataRange{
    case valid
    case notvalid
}

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var max : UITextField!
    @IBOutlet weak var min : UITextField!
    
    weak var delegate: UpdateSettingsDelegate?
    
    private enum TextMessagesAlert{
        static let error = "errorTextMessage"
        static let notvalid = "notValidTextMessage"
        static let ok = "alertButtonOk"
        static let info = "InfoTitle"
        static let apply = "DataApply"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func alertNotValid(){
        let alert = UIAlertController(title: NSLocalizedString(TextMessagesAlert.error, comment: ""),
                                      message: NSLocalizedString(TextMessagesAlert.notvalid, comment: ""),
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: NSLocalizedString(TextMessagesAlert.ok, comment: ""), style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func alertApply(){
        let alert = UIAlertController(title: NSLocalizedString(TextMessagesAlert.info, comment: ""),
                                      message: NSLocalizedString(TextMessagesAlert.apply, comment: ""),
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: NSLocalizedString(TextMessagesAlert.ok, comment: ""), style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func verifyData(minNum: Int, maxNum: Int) -> ResultVerifyDataRange{
        if minNum >= maxNum{
            return .notvalid
        }
        return .valid
    }
    
    @IBAction func sendUpdateSettings(){
        if let maxValStr = max.text , let minValStr = (min.text){
            if let maxValNum = Int(maxValStr), let minValNum = Int(minValStr){
                switch verifyData(minNum: minValNum, maxNum: maxValNum) {
                case .valid:
                    alertApply()
                    delegate?.update(range: (minValNum, maxValNum))
                case .notvalid:
                    alertNotValid()
                }
            }
        }
    }
    
}
