//
//  SingleLessonVC.swift
//  SanatVersion2
//
//  Created by Николай Горбачев on 04.05.2021.
//

import UIKit
enum LessonMode {
    case story
    case twoAnswers
    case fourAnswers
    case translation
    case defaultMode
}

class LessonPageViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var upperMenu: UIStackView!
    
    @IBAction func continueLesson( _ seg: UIStoryboardSegue) {
    }
    @IBOutlet weak var checkAnswerButton: UIButton!
    @IBOutlet weak var quitOnLastPageButton: UIButton!
    @IBOutlet weak var lessonPageHeaderLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    
    let buttonUpperLeft = UIButton()
    let buttonLowerRight = UIButton()
    let buttonLowerLeft = UIButton()
    let buttonUpperRight = UIButton()
    
    let translationTextField = UITextView()
    var translationAnswer = ""
    var translationCorrectAnswer = ""
    
    var pageIndex : Int = 0
    var titleText : String = ""
    var imageFile : String = ""
    var nextPageIsUnlocked : Bool = false
    var answerIsCorrect : Bool = false
    var correctAnswer : Int = -1
    var chosenAnswer : Int = -1
    var pagesNumber : Int = 0
    var pageContents = LessonPageContents()
    
    var storyHeaderLabel = UILabel()
    var storyTextLabel = UILabel()
    

    
    
    var lessonMode = LessonMode.fourAnswers
  
    override func viewDidLoad() {
        
        lessonMode = pageContents.mode
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
        
        let pageNumberLabel = lessonPageHeaderLabel
        pageNumberLabel!.text = "\(titleText): \(pageIndex + 1)/\(pagesNumber)"
        pageNumberLabel!.textAlignment = .center
    
        var button : UIButton
        
        if lessonMode == .story {
            button = quitOnLastPageButton!
        } else {
            button = checkAnswerButton!
        }
        
        button.frame = CGRect(x: 20, y: view.frame.height - 110, width: view.frame.width - 40, height: 50)
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.setTitle("Проверить ответ", for: UIControl.State())
        button.addTarget(self, action: #selector(checkButtonAction(button:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: view.frame.width * 0.85).isActive = true
        NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50).isActive = true
        NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -30).isActive = true
        NSLayoutConstraint(item: button, attribute: .leadingMargin, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: view.frame.width * 0.075).isActive = true
        
        
        taskLabel.text = pageContents.question
        taskLabel.frame = CGRect(x: view.frame.width * 0.1, y: view.frame.height*0.05, width: view.frame.width * 0.8, height: view.frame.height * 0.25)
        taskLabel.font = UIFont.boldSystemFont(ofSize: 18)
        taskLabel.lineBreakMode = .byWordWrapping
        taskLabel.numberOfLines = 0
        
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: taskLabel!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: view.frame.width * 0.85).isActive = true
        NSLayoutConstraint(item: taskLabel!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 75).isActive = true
        NSLayoutConstraint(item: taskLabel!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: view.frame.width * 0.075).isActive = true
       
        
        exampleLabel.text = pageContents.phrase
        exampleLabel.frame = CGRect(x: view.frame.width * 0.1, y: view.frame.height*0.1, width: view.frame.width * 0.8, height: view.frame.height * 0.25)
        exampleLabel.lineBreakMode = .byWordWrapping
        exampleLabel.numberOfLines = 0
        exampleLabel.textAlignment = .center
        
        
        exampleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: exampleLabel!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: view.frame.width * 0.85).isActive = true
        NSLayoutConstraint(item: exampleLabel!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: view.frame.width * 0.075).isActive = true
        
        
        if lessonMode == LessonMode.fourAnswers {
            loadFourButtons()
            quitOnLastPageButton!.removeFromSuperview()
            correctAnswer = pageContents.correctAnswerNumber
            NSLayoutConstraint(item: exampleLabel!, attribute: .top, relatedBy: .equal, toItem: taskLabel, attribute: .bottom, multiplier: 1.0, constant: (buttonUpperLeft.frame.minY + taskLabel.frame.maxY) * 0.5).isActive = true
        }
        
        if lessonMode == LessonMode.translation {
            loadTextField()
            quitOnLastPageButton!.removeFromSuperview()
            translationCorrectAnswer = pageContents.correctTranslation
            NSLayoutConstraint(item: exampleLabel!, attribute: .top, relatedBy: .equal, toItem: taskLabel, attribute: .bottom, multiplier: 1.0, constant: (translationTextField.frame.minY + taskLabel.frame.maxY) * 0.5).isActive = true
        }
        
        if lessonMode == .story{
            
            button.removeFromSuperview()
            if pageIndex == pagesNumber - 1 {
                view.addSubview(quitOnLastPageButton)
                quitOnLastPageButton.translatesAutoresizingMaskIntoConstraints = false
                quitOnLastPageButton.setTitle("Выйти", for: UIControl.State())
                NSLayoutConstraint(item: quitOnLastPageButton!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: view.frame.width * 0.85).isActive = true
                NSLayoutConstraint(item: quitOnLastPageButton!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50).isActive = true
                NSLayoutConstraint(item: quitOnLastPageButton!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -30).isActive = true
                NSLayoutConstraint(item: quitOnLastPageButton!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: view.frame.width * 0.075).isActive = true
            }
            view.addSubview(storyHeaderLabel)
            view.addSubview(storyTextLabel)
            
            
            
            
            
            taskLabel.removeFromSuperview()
            exampleLabel.removeFromSuperview()
            checkAnswerButton!.removeFromSuperview()
            nextPageIsUnlocked = true
            
            storyHeaderLabel.text = pageContents.storyHeader
            storyHeaderLabel.frame = CGRect(x: view.frame.width * 0.1, y: view.frame.height*0.05, width: view.frame.width * 0.8, height: view.frame.height * 0.25)
            storyHeaderLabel.font = UIFont.boldSystemFont(ofSize: 18)
            
            storyHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: storyHeaderLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: view.frame.width * 0.85).isActive = true
            NSLayoutConstraint(item: storyHeaderLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 75).isActive = true
            NSLayoutConstraint(item: storyHeaderLabel, attribute: .leadingMargin, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: view.frame.width * 0.075).isActive = true
            
            
            storyTextLabel.text = pageContents.storyText
            storyTextLabel.lineBreakMode = .byWordWrapping
            storyTextLabel.numberOfLines = 0
            storyTextLabel.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            storyTextLabel.frame = CGRect(x: view.frame.width * 0.1, y: view.frame.height * 0.1, width: view.frame.width * 0.8, height: view.frame.height * 0.25)
            
            storyTextLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: storyTextLabel, attribute: .topMargin, relatedBy: .equal, toItem: storyHeaderLabel, attribute: .bottomMargin, multiplier: 1.0, constant: 25).isActive = true
            NSLayoutConstraint(item: storyTextLabel, attribute: .leadingMargin, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: view.frame.width * 0.075).isActive = true
            NSLayoutConstraint(item: storyTextLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: view.frame.width * 0.85).isActive = true
            
            
            
            
            
            if pageContents.imageName != "" {
                loadImage(path: pageContents.imageName)
                
            }
            
        }
        
    }
    
    
    func loadImage(path: String) {
        let image = UIImage(named: path)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: view.frame.width * 0.05, y: view.frame.height * 0.35, width: view.frame.width * 0.9, height: view.frame.width * 0.6)
        self.view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: imageView, attribute: .topMargin, relatedBy: .equal, toItem: storyTextLabel, attribute: .bottomMargin, multiplier: 1.0, constant: 25).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .leadingMargin, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: view.frame.width * 0.05).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .trailingMargin, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -view.frame.width * 0.05).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: imageView.frame.width * 0.6).isActive = true
        
        self.view.bringSubviewToFront(imageView)
    }
  
    func loadTextField() {
        translationTextField.delegate = self
        translationTextField.frame = CGRect(x: view.frame.width/8, y: view.frame.width/2, width: 3*view.frame.width/4, height: view.frame.width/4)
        translationTextField.text = "Введите ответ..."
        translationTextField.textColor = UIColor.lightGray
        translationTextField.tintColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        translationTextField.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        translationTextField.layer.cornerRadius = 0
        translationTextField.layer.borderWidth = 1.0
        translationTextField.layer.masksToBounds = true
        view.addSubview(translationTextField)
        
        
        translationTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: translationTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: view.frame.width * 0.9).isActive = true
        NSLayoutConstraint(item: translationTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 220).isActive = true
        NSLayoutConstraint(item: translationTextField, attribute: .top, relatedBy: .equal, toItem: exampleLabel, attribute: .bottom, multiplier: 1.0, constant: view.frame.height * 0.075).isActive = true
        NSLayoutConstraint(item: translationTextField, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: view.frame.width * 0.05).isActive = true
    }
    
    func fourButtonsConstraints(button : UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: view.frame.width * 0.4).isActive = true
        NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100).isActive = true
    }
    
    func loadFourButtons() {
        
        buttonUpperLeft.frame = CGRect(x: view.frame.width * 0.05, y: view.frame.height * 0.45, width: view.frame.width * 0.4, height: view.frame.height * 0.125)
        buttonUpperLeft.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        buttonUpperLeft.setTitle(pageContents.fourAnswers[0], for: UIControl.State())
        buttonUpperLeft.addTarget(self, action: #selector(answerButtonAction(button:)), for: .touchUpInside)
        buttonUpperLeft.addTarget(self, action: #selector(changeAppearence(button:)), for: .touchDown)
        view.addSubview(buttonUpperLeft)
        
        buttonUpperRight.frame = CGRect(x: view.frame.width * 0.55, y: view.frame.height * 0.45, width: view.frame.width * 0.4, height: view.frame.height * 0.125)
        buttonUpperRight.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        buttonUpperRight.setTitle(pageContents.fourAnswers[1], for: UIControl.State())
        buttonUpperRight.addTarget(self, action: #selector(answerButtonAction(button:)), for: .touchUpInside)
        buttonUpperRight.addTarget(self, action: #selector(changeAppearence(button:)), for: .touchDown)
        view.addSubview(buttonUpperRight)
        
        buttonLowerLeft.frame = CGRect(x: view.frame.width * 0.05, y: view.frame.height * 0.6, width: view.frame.width * 0.4, height: view.frame.height * 0.125)
        buttonLowerLeft.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        buttonLowerLeft.setTitle(pageContents.fourAnswers[2], for: UIControl.State())
        buttonLowerLeft.addTarget(self, action: #selector(answerButtonAction(button:)), for: .touchUpInside)
        buttonLowerLeft.addTarget(self, action: #selector(changeAppearence(button:)), for: .touchDown)
        view.addSubview(buttonLowerLeft)
        
        buttonLowerRight.frame = CGRect(x: view.frame.width * 0.55, y: view.frame.height * 0.6, width: view.frame.width * 0.4, height: view.frame.height * 0.125)
        buttonLowerRight.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        buttonLowerRight.setTitle(pageContents.fourAnswers[3], for: UIControl.State())
        buttonLowerRight.addTarget(self, action: #selector(answerButtonAction(button:)), for: .touchUpInside)
        buttonLowerRight.addTarget(self, action: #selector(changeAppearence(button:)), for: .touchDown)
        view.addSubview(buttonLowerRight)
        
        fourButtonsConstraints(button: buttonUpperLeft)
        fourButtonsConstraints(button: buttonUpperRight)
        fourButtonsConstraints(button: buttonLowerLeft)
        fourButtonsConstraints(button: buttonLowerRight)
        
        NSLayoutConstraint(item: buttonUpperLeft, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: view.frame.width * 0.05).isActive = true
        NSLayoutConstraint(item: buttonUpperLeft, attribute: .bottom, relatedBy: .equal, toItem: buttonLowerLeft, attribute: .top, multiplier: 1.0, constant: -20).isActive = true
        
        NSLayoutConstraint(item: buttonUpperRight, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -view.frame.width * 0.05).isActive = true
        NSLayoutConstraint(item: buttonUpperRight, attribute: .bottom, relatedBy: .equal, toItem: buttonLowerRight, attribute: .top, multiplier: 1.0, constant: -20).isActive = true
        
        NSLayoutConstraint(item: buttonLowerLeft, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: view.frame.width * 0.05).isActive = true
        NSLayoutConstraint(item: buttonUpperLeft, attribute: .top, relatedBy: .equal, toItem: exampleLabel, attribute: .bottom, multiplier: 1.0, constant: view.frame.height * 0.075).isActive = true
        
        NSLayoutConstraint(item: buttonLowerRight, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -view.frame.width * 0.05).isActive = true
        NSLayoutConstraint(item: buttonUpperRight, attribute: .top, relatedBy: .equal, toItem: exampleLabel, attribute: .bottom, multiplier: 1.0, constant: view.frame.height * 0.075).isActive = true
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @objc func scaleAnimationAction(button: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 6, initialSpringVelocity:   4, options: [], animations: {
            button.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.6, usingSpringWithDamping: 2, initialSpringVelocity:     10, options: [], animations: {
                button.transform = CGAffineTransform.identity
            }, completion: nil)
    }
    
    @objc func moveCheckButtonToCenterAnimationAction(button: UIButton) {
        
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 6, initialSpringVelocity:   4, options: [], animations: {
            button.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height * 0.4)
            }, completion: nil)
        self.view.bringSubviewToFront(button)
    }
    
    
    
    @objc func backToIdentityAnimationAction(button: UIButton) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 6, initialSpringVelocity:   4, options: [], animations: {
            button.transform = CGAffineTransform.identity
            }, completion: nil)
    }
    
    
    
    @objc func rotationAnimationAction(button: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 6, initialSpringVelocity:   4, options: [], animations: {
            button.transform = CGAffineTransform(rotationAngle: 0.1)
            }, completion: nil)
        
        UIView.animate(withDuration: 0.1, delay: 0.1, usingSpringWithDamping: 6, initialSpringVelocity:   4, options: [], animations: {
            button.transform = CGAffineTransform(rotationAngle: -0.1)
            }, completion: nil)
        
        UIView.animate(withDuration: 0.1, delay: 0.2, usingSpringWithDamping: 2, initialSpringVelocity:     10, options: [], animations: {
                button.transform = CGAffineTransform.identity
            }, completion: nil)
    }
    
    
    
    @objc func answerButtonAction(button: UIButton) {
        
        switch button {
        case buttonUpperLeft:
            chosenAnswer = 0
        case buttonUpperRight:
            chosenAnswer = 1
        case buttonLowerLeft:
            chosenAnswer = 2
        case buttonLowerRight:
            chosenAnswer = 3
        default:
            scaleAnimationAction(button: button)
        }
    }
    
    
    
    @objc func changeAppearence(button: UIButton) {
        resetAppearence(button: buttonUpperLeft)
        resetAppearence(button: buttonUpperRight)
        resetAppearence(button: buttonLowerLeft)
        resetAppearence(button: buttonLowerRight)
        
        button.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    }
    
    @objc func resetAppearence(button: UIButton) {
        button.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    }
    
    
    
    @objc func checkButtonAction(button: UIButton) {
        if lessonMode == .fourAnswers {
            
            if chosenAnswer == correctAnswer {
                nextPageIsUnlocked = true
                button.setTitle("Правильно!", for: UIControl.State())
                
                switch correctAnswer {
                case 0:
                    scaleAnimationAction(button: buttonUpperLeft)
                case 1:
                    scaleAnimationAction(button: buttonUpperRight)
                case 2:
                    scaleAnimationAction(button: buttonLowerLeft)
                case 3:
                    scaleAnimationAction(button: buttonLowerRight)
                default:
                    scaleAnimationAction(button: button)
                }
                
            } else {
                switch chosenAnswer{
                case -1:
                    button.setTitle("Выберите ответ!", for: UIControl.State())
                default:
                    button.setTitle("Попробуйте снова!", for: UIControl.State())
                }
                resetAppearence(button: buttonUpperLeft)
                resetAppearence(button: buttonUpperRight)
                resetAppearence(button: buttonLowerLeft)
                resetAppearence(button: buttonLowerRight)
                
                rotationAnimationAction(button: buttonUpperLeft)
                rotationAnimationAction(button: buttonUpperRight)
                rotationAnimationAction(button: buttonLowerLeft)
                rotationAnimationAction(button: buttonLowerRight)
            }
        } else if lessonMode == .translation {
            if translationAnswer == translationCorrectAnswer {
                nextPageIsUnlocked = true
                button.setTitle("Верно!", for: UIControl.State())
                scaleAnimationAction(button: button)
            } else {
                switch translationAnswer{
                case "":
                    button.setTitle("Введите ответ!", for: UIControl.State())
                default:
                    button.setTitle("Попробуйте снова!", for: UIControl.State())
                }
                rotationAnimationAction(button: button)
            }
        }
        
        
    }
    
    
    @objc func answerTranslationAction(textView: UITextView) {
        
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        NSLayoutConstraint(item: translationTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50).isActive = true
        moveCheckButtonToCenterAnimationAction(button: checkAnswerButton)
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        checkAnswerButton.addGestureRecognizer(tap)
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Введите ответ..."
            textView.textColor = UIColor.lightGray
        }
        backToIdentityAnimationAction(button: checkAnswerButton)
        
        translationAnswer = textView.text
        print(translationAnswer)
        print(translationCorrectAnswer)
        
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
                    textView.resignFirstResponder()
                    return false
                }
                return true
    }
    
}

