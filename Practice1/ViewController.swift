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
    
    
    @IBAction func startGame(sender : AnyObject) {
        if(inputField.text != nil && inputField.text != ""){
            user_number = (UInt32(inputField.text!))
            inputField.text = ""
            
            if(user_number == rand_number){
                resultLabel.text = "Угадал)"
            }
            else if user_number! < rand_number {
                resultLabel.text = "Мало("
            }
            else  {
                resultLabel.text = "Много("
            }
        }
        else{
            resultLabel.text = "Не корректное число"
        }
        
    }
    
    @IBAction func resetGame(sender : AnyObject) { // Сброс сгенерированного числа
        rand_number = guess_num()
        resultLabel.text = "Жми играть"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

