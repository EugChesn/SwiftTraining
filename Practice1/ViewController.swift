//
//  ViewController.swift
//  Practice1
//
//  Created by Евгений on 29.01.2020.
//  Copyright © 2020 Евгений. All rights reserved.
//

import UIKit

protocol FirstViewControllerDelegate: class {
    func update(_ min: UInt32, _ max: UInt32)
}

class ViewController: UIViewController , FirstViewControllerDelegate{
    
    // Границы рандомайзера
    var max: UInt32 = 100
    var min: UInt32 = 0
    
    var user_number: UInt32? = 0
    
    var rand_number: UInt32 = 0 // число для разгадывания
    
    var countStepAll: UInt32 = 0 // количество ходов всего

    var countWin: UInt32? // счет побед в угадайке
    
    //Кнопка начало игры
    @IBOutlet weak var startGameButton: UIButton!
    
    //Результат угадывания
    @IBOutlet weak var resultLabel: UILabel!
    
    //Вводимое число пользователем
    @IBOutlet weak var inputField: UITextField!
    
    //Количество ходов
    @IBOutlet weak var stepLabel: UILabel!
    
    @IBOutlet weak var promptInputLabel: UILabel!
    
    //Кнопка сброса
    @IBOutlet weak var resetButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countWin = UserDefaults.standard.value(forKey: "countWin") as? UInt32
        if let tmpCount = UserDefaults.standard.value(forKey: "countStepAll") as? UInt32{
            countStepAll = tmpCount
        }
        //rand_number = guess_num(min_thresh: min, max_thresh: max)
    }
    
    func prepareForShowingSettings(_ segue: UIStoryboardSegue, sender: Any?){
        guard let destination = segue.destination as? SettingsViewController else { return }
        destination.delegate = self // подписываемся на обновление настроек
    }
    
    func prepareForShowScore(_ segue: UIStoryboardSegue, sender: Any?){
        guard let destination = segue.destination as? ScoreViewController else { return }
        
        destination.numbersGame = countStepAll // отправляем счетчик ходов
        destination.numbersWin = countWin // передаем количество побед
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
          return
        }
        switch identifier {
          case "toSettingsSegue":
            prepareForShowingSettings(segue, sender: sender)
          case "showScore":
            prepareForShowScore(segue, sender: sender)
          default:
            return
        }
    }
    
    func update(_ minVal: UInt32, _ maxVal: UInt32) {
        min = minVal
        max = maxVal
        
        rand_number = guess_num(min_thresh: min, max_thresh: max)
        
        inputField.isEnabled = true
        startGameButton.isEnabled = true
        resetButton.isEnabled = true
        
        promptInputLabel.text = NSLocalizedString("promptInput", comment: "") + NSLocalizedString("rangeTextMessage", comment: "") + "(\(min), \(max))"
        resultLabel.text = NSLocalizedString("pushPlayTextMessage", comment: "")
    }
    
    @IBAction func startGame(sender : AnyObject) {
        if(inputField.text != ""){
            
            //Увеличиваем счетчик ходов пользователя
            if let anotherStepLabel = stepLabel.text{
                if let intPreviousStep = UInt32(anotherStepLabel){
                    stepLabel.text = String(intPreviousStep + 1)
                    countStepAll += 1
                }
            }
            
            //Считываем число пользователя и обнуляем текстовое поле
            if let anotherFieldText = inputField.text {
                user_number = (UInt32(anotherFieldText))
            inputField.text = ""
            
            
            if let anotherUserNumber = user_number {
                if(anotherUserNumber == rand_number) {
                    resultLabel.text = NSLocalizedString("guessedTextMessage", comment: "")
                    startGameButton.isEnabled = false
                    if let count = countWin{
                        countWin = count + 1
                    }else{
                        countWin = 1
                    }
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
        
        UserDefaults.standard.set(countWin, forKey: "countWin")
        UserDefaults.standard.set(countStepAll, forKey: "countStepAll")
    }
    
    // Сброс сгенерированного числа
    @IBAction func resetGame(sender : AnyObject) {
        rand_number = guess_num(min_thresh: min, max_thresh: max)
        startGameButton.isEnabled = true
        stepLabel.text = "0"
        resultLabel.text = NSLocalizedString("pushPlayTextMessage", comment: "")
    }
    
    
    @IBAction func obsStateTextField(sender : AnyObject) {
        resultLabel.isHidden = false
    }
    
    /*@IBAction func saveData(_ unwindSegue: UIStoryboardSegue) {
        guard unwindSegue.identifier == "segueSaveSettings" else {
            return
        }
        guard let source = unwindSegue.source as? SettingsViewController else { return }
        
        min = source.range.0
        max = source.range.1
        rand_number = guess_num(min_thresh: min, max_thresh: max)
        
        inputField.isEnabled = true
        startGameButton.isEnabled = true
        resetButton.isEnabled = true
    }*/
}

