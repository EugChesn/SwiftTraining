//
//  ViewController.swift
//  Practice1
//
//  Created by Евгений on 29.01.2020.
//  Copyright © 2020 Евгений. All rights reserved.
//

import UIKit

protocol UpdateSettingsDelegate: class {
    func update(range: (Int, Int))
}

class ViewController: UIViewController{
    
    lazy var dataModel = Model()
    var userNumber: Int?
    
    private enum GameTextMessage{
        static let guessed = "guessedTextMessage"
        static let many = "manyTextMessage"
        static let few = "fewTextMessage"
        static let incorrect = "incorrectTextMessage"
        static let pushPlay = "pushPlayTextMessage"
        static let range = "rangeTextMessage"
        static let prompt = "promptInput"
    }
    
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
        
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tapScreen)
    }
    @objc func dismissKeyboard(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    func prepareForShowingSettings(_ segue: UIStoryboardSegue, sender: Any?){
        guard let destination = segue.destination as? SettingsViewController else { return }
        destination.delegate = self // подписываемся на обновление настроек
    }
    
    func prepareForShowScore(_ segue: UIStoryboardSegue, sender: Any?){
        guard let destination = segue.destination as? ScoreViewController else { return }
        destination.dataScore = dataModel.getScores()
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
    
    private func increaseCountStep(){
        if let anotherStepLabel = stepLabel.text{
            if let intPreviousStep = Int(anotherStepLabel){
                stepLabel.text = String(intPreviousStep + 1)
                dataModel.increaseCountStepAll()
            }
        }
    }
    
    private func alertWin(){
        let alert = UIAlertController(title: "Победа", message: "Ходов: \(dataModel.getCountAll())", preferredStyle: .alert)
         let action = UIAlertAction(title: "Ok!", style: .default, handler: nil)
         alert.addAction(action)
         present(alert, animated: true, completion: nil)
    }
    
    @IBAction func startGame(sender : AnyObject) {
        
        if(inputField.text != ""){
            
            //Увеличиваем счетчик ходов пользователя
            increaseCountStep()
            
            //Считываем число пользователя и обнуляем текстовое поле
            if let anotherFieldText = inputField.text {
                userNumber = (Int(anotherFieldText))
            inputField.text = ""
            
                if let anotherUserNumber = userNumber {
                    switch dataModel.compareWithUserNumber(userNumber: anotherUserNumber) {
                    case .guessed:
                        alertWin()
                        
                        dataModel.increaseCountWin()
                        dataModel.resetScore()
                        dataModel.saveUserDefaultScore()
                        
                        resultLabel.text = NSLocalizedString(GameTextMessage.guessed, comment: "")
                        startGameButton.isEnabled = false
                    
                        break
                    case .many:
                        resultLabel.text = NSLocalizedString(GameTextMessage.many, comment: "")
                        break
                    case .few:
                        resultLabel.text = NSLocalizedString(GameTextMessage.few, comment: "")
                        break
                    }
                    
                }
            }
        }
        else{
            resultLabel.text = NSLocalizedString(GameTextMessage.incorrect, comment: "")
        }
    }
    
    // Сброс сгенерированного числа
    @IBAction func resetGame(sender : AnyObject) {
        dataModel.resetScore()
        dataModel.saveUserDefaultScore()
        dataModel.generateRandNumber()
        
        startGameButton.isEnabled = true
        stepLabel.text = "0"
        resultLabel.text = NSLocalizedString(GameTextMessage.pushPlay, comment: "")
    }
    
    @IBAction func obsStateTextField(sender : AnyObject) {
        resultLabel.isHidden = false
    }
}

extension ViewController: UpdateSettingsDelegate{
    func update(range: (Int, Int)) {
        dataModel.setUpdateRange(range: range)
        dataModel.generateRandNumber()
        
        inputField.isEnabled = true
        startGameButton.isEnabled = true
        resetButton.isEnabled = true
        stepLabel.text = "0"
        
        promptInputLabel.text = NSLocalizedString(GameTextMessage.prompt, comment: "") + NSLocalizedString(GameTextMessage.range, comment: "") + "(\(range.0), \(range.1))"
        resultLabel.text = NSLocalizedString(GameTextMessage.pushPlay, comment: "")
    }
}
