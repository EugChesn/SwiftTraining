//
//  ViewController.swift
//  Practice1
//
//  Created by Евгений on 29.01.2020.
//  Copyright © 2020 Евгений. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var user_number: UInt32? = 0
    var rand_number: UInt32 = guess_num() // генерируем число для разгадывания
    
    //Результат угадывания
    @IBOutlet weak var resultLabel: UILabel!
    
    //Вводимое число пользователем
    @IBOutlet weak var inputField: UITextField!
    
    //Количество ходов
    @IBOutlet weak var stepLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startGame(sender : AnyObject) {
        if(inputField.text != ""){
            
            //Увеличиваем счетчик ходов пользователя
            if let anotherStepLabel = stepLabel.text{
                if let intPreviousStep = Int(anotherStepLabel){
                    let resCurrentStep = String(intPreviousStep + 1)
                    stepLabel.text = resCurrentStep
                }
            }
            
            //Считываем число пользователя и обнуляем текстовое поле
            if let anotherFieldText = inputField.text {
                user_number = (UInt32(anotherFieldText))
            inputField.text = ""
            
            
            if let anotherUserNumber = user_number {
                if(anotherUserNumber == rand_number) {
                    resultLabel.text = NSLocalizedString("guessedTextMessage", comment: "")
                }
                else if anotherUserNumber < rand_number {
                    resultLabel.text = NSLocalizedString("fewTextMessage", comment: "")
                }
                else {
                    resultLabel.text = NSLocalizedString("manyTextMessage", comment: "")
                }
            }
            }
        }
        else{
            resultLabel.text = NSLocalizedString("incorrectTextMessage", comment: "")
        }
    }
    
    // Сброс сгенерированного числа
    @IBAction func resetGame(sender : AnyObject) {
        rand_number = guess_num()
        stepLabel.text = "0"
        resultLabel.text = NSLocalizedString("pushPlayTextMessage", comment: "")
    }
}

