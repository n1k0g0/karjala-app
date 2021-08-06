//
//  StoryPageViewController.swift
//  SanatVersion2
//
//  Created by Николай Горбачев on 06.05.2021.
//

import UIKit



class StoryPageViewController: UIViewController {
    
    @IBOutlet weak var finalPageButton: UIButton!
    @IBOutlet weak var storyPageHeaderLabel: UILabel!
    
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
  
    var storyMode = LessonMode.story
    
    override func viewDidLoad() {
        storyMode = pageContents.mode
        super.viewDidLoad()
    
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200))
        label.textColor = .white
        label.text = titleText
        label.textAlignment = .center
        view.addSubview(label)
    
        
        storyPageHeaderLabel!.text = "\(titleText): \(pageIndex + 1)/\(pagesNumber)"
        storyPageHeaderLabel!.textAlignment = .center
        
        if storyMode == .story{
            finalPageButton.frame = CGRect(x: 20, y: view.frame.height - 110, width: view.frame.width - 40, height: 50)
            finalPageButton.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            finalPageButton.setTitle("Назад к историям", for: UIControl.State())
            finalPageButton.addTarget(self, action: #selector(Action(button:)), for: .touchUpInside)
            
            finalPageButton.removeFromSuperview()
            if pageIndex == pagesNumber - 1 {
                view.addSubview(finalPageButton)
                finalPageButton.translatesAutoresizingMaskIntoConstraints = false
                finalPageButton.setTitle("Выйти", for: UIControl.State())
                finalPageButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: UIControl.State())
                NSLayoutConstraint(item: finalPageButton!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: view.frame.width * 0.85).isActive = true
                NSLayoutConstraint(item: finalPageButton!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50).isActive = true
                NSLayoutConstraint(item: finalPageButton!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -30).isActive = true
                NSLayoutConstraint(item: finalPageButton!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: view.frame.width * 0.075).isActive = true
            }
            

            
            storyHeaderLabel.text = pageContents.storyHeader
            storyTextLabel.text = pageContents.storyText
            storyTextLabel.frame = CGRect(x: view.frame.width/8, y: 3*view.frame.width/4, width: 3*view.frame.width/4, height: view.frame.width/8)
            storyHeaderLabel.frame = CGRect(x: view.frame.width/8, y: view.frame.width/2, width: 3*view.frame.width/4, height: view.frame.width/8)
            view.addSubview(storyHeaderLabel)
            view.addSubview(storyTextLabel)
            
            storyHeaderLabel.frame = CGRect(x: view.frame.width * 0.1, y: view.frame.height*0.05, width: view.frame.width * 0.8, height: view.frame.height * 0.25)
            storyHeaderLabel.font = UIFont.boldSystemFont(ofSize: 18)
            storyHeaderLabel.lineBreakMode = .byWordWrapping
            storyHeaderLabel.numberOfLines = 0
            
            storyHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: storyHeaderLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: view.frame.width * 0.85).isActive = true
            NSLayoutConstraint(item: storyHeaderLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 75).isActive = true
            NSLayoutConstraint(item: storyHeaderLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: view.frame.width * 0.075).isActive = true
            
            
            storyTextLabel.frame = CGRect(x: view.frame.width * 0.1, y: view.frame.height*0.1, width: view.frame.width * 0.8, height: view.frame.height * 0.25)
            storyTextLabel.lineBreakMode = .byWordWrapping
            storyTextLabel.numberOfLines = 0
            storyTextLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: storyTextLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: view.frame.width * 0.85).isActive = true
            NSLayoutConstraint(item: storyTextLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: view.frame.width * 0.075).isActive = true
            NSLayoutConstraint(item: storyTextLabel, attribute: .topMargin, relatedBy: .equal, toItem: storyHeaderLabel, attribute: .bottomMargin, multiplier: 1.0, constant: 25).isActive = true
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
  
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func Action(button: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 6, initialSpringVelocity:   4, options: [], animations: {
            button.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }, completion: nil)
    
        UIView.animate(withDuration: 0.5, delay: 0.6, usingSpringWithDamping: 2, initialSpringVelocity:     10, options: [], animations: {
                button.transform = CGAffineTransform.identity
            }, completion: nil)
        
        correctAnswer = 1
    }

}
