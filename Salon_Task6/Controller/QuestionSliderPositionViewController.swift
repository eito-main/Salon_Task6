//
//  ViewController.swift
//  Salon_Task6
//
//  Created by 相良 詠斗 on 2021/07/25.
//

import UIKit

class QuestionSliderPositionViewController: UIViewController {


    private var answerValue:Int = 95{
        didSet{
            answerValueLabel.text = String(answerValue)
        }
    }
    private let randomNumModel = RandomNumModel()

    @IBOutlet weak var answerValueLabel: UILabel!

    @IBOutlet weak var slider: UISlider!{
        didSet{
            slider.minimumValue = 1
            slider.maximumValue = 100
            slider.value = 50
        }
    }

    @IBAction func judge(_ sender: Any) {

        slider.value.round()
        if Int(slider.value) == answerValue {
            Alert(judge: "あたり！")
        } else {
            Alert(judge: "はずれ！")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        randomNumModel.notificationCenter.addObserver(
            forName: .didChangeRandomNumModelthemeNum,
            object: nil,
            queue: OperationQueue.main,
            using: { [weak self] notification in
                if let themeNum = notification.object as? Int {
                    self?.answerValue = themeNum
                }
            }
        )

        randomNumModel.gemerateAnswerValue()
    }

    func Alert(judge:String) {

        let alert = UIAlertController(
            title: "結果",
            message: "\(judge)\nあなたの値：\(Int(slider.value))",
            preferredStyle: .alert)

        let nextChallenge = UIAlertAction(
            title: "再挑戦",
            style: .default) {
            (action) in
            self.slider.value = 50
            self.randomNumModel.gemerateAnswerValue()
            self.dismiss(animated: true, completion: nil)
        }

        alert.addAction(nextChallenge)
        present(alert, animated: true, completion: nil)
    }
}

