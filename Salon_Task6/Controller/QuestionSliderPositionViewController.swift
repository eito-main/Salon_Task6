//
//  ViewController.swift
//  Salon_Task6
//
//  Created by 相良 詠斗 on 2021/07/25.
//

import UIKit

class QuestionSliderPositionViewController: UIViewController {

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

        if Int(slider.value) == randomNumModel.answerValue {
            presentAlert(judge: "あたり！")
        } else {
            presentAlert(judge: "はずれ！")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        randomNumModel.notificationCenter.addObserver(
            forName: .didChangeRandomNumModelthemeNum,
            object: nil,
            queue: OperationQueue.main,
            using: { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.answerValueLabel.text = String(strongSelf.randomNumModel.answerValue)
            }
        )

        randomNumModel.generateAnswerValue()
    }

    func presentAlert(judge: String) {

        let alert = UIAlertController(
            title: "結果",
            message: "\(judge)\nあなたの値：\(Int(slider.value))",
            preferredStyle: .alert)

        let nextChallenge = UIAlertAction(
            title: "再挑戦",
            style: .default) { [weak self] _ in
            self?.slider.value = 50
            self?.randomNumModel.generateAnswerValue()
        }

        alert.addAction(nextChallenge)
        present(alert, animated: true, completion: nil)
    }
}
