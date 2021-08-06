//
//  ProgressController.swift
//  SanatVersion2
//
//  Created by Николай Горбачев on 06.07.2021.
//

import UIKit



class PageHelpViewController: UIViewController {
    
    @IBOutlet weak var pageHelpTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageHelpTextView.font = UIFont.systemFont(ofSize: 18)
        pageHelpTextView.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        pageHelpTextView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        pageHelpTextView.isSelectable = false
        pageHelpTextView.dataDetectorTypes = .link
        let textFontSize = CGFloat(20)
        //Keeps the original formatting from xib or storyboard
        
        
        let h1 = "Чтобы пройти урок/историю:"
        let h2 = "Прочитайте карточку"
        let h3 = "Выполните задание"
        let h4 = "Перейдите к следующей карточке"
        let h5 = "Проведите пальцем вниз чтобы закрыть это окно"
        
        let text: NSString = "\(h1) \n\n– \(h2) \n\n– \(h3): выберите один из вариантов ответа или впишите ответ в текстовое поле \n\n– \(h4): перелистните страницу, потянув за край \n\n\(h5)" as NSString
        
        
        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: text as String)
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: textFontSize), NSAttributedString.Key.foregroundColor: UIColor.white], range: NSRange(location: 0, length: text.length))
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: textFontSize)], range: NSRange(location: 0, length: h1.count))
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: textFontSize)], range: NSRange(location: 31, length: h2.count))
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: textFontSize)], range: NSRange(location: 55, length: h3.count))
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: textFontSize)], range: NSRange(location: 147, length: h4.count))
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: textFontSize)], range: NSRange(location: 220, length: h5.count))
        
        
        pageHelpTextView.attributedText = attributedText
        
        
    
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        print("Sessions View Controller Will Appear")
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("View Will Disappear")
    }
    

}
