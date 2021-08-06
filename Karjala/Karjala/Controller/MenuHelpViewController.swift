//
//  ProgressController.swift
//  SanatVersion2
//
//  Created by Николай Горбачев on 06.07.2021.
//

import UIKit



class MenuHelpViewController: UIViewController {
    
    @IBOutlet weak var menuHelpTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuHelpTextView.font = UIFont.systemFont(ofSize: 18)
        menuHelpTextView.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        menuHelpTextView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        menuHelpTextView.isSelectable = false
        menuHelpTextView.dataDetectorTypes = .link
        let textFontSize = CGFloat(20)
        //Keeps the original formatting from xib or storyboard
        
        
        let h1 = "Выберите один из разделов:"
        let h2 = "Уроки"
        let h3 = "Истории"
        let h4 = "Ресурсы"
        let h5 = "Проведите пальцем вниз чтобы вернуться в меню"
        
        let text: NSString = "\(h1)\n\n– \(h2): изучение основ карельского языка в игровой форме \n\n– \(h3): узнать интересные факты о карелах и Карелии \n\n– \(h4): дополнительные материалы для дальнейшего изучения \n\n\(h5)" as NSString
        
        
        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: text as String)
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: textFontSize), NSAttributedString.Key.foregroundColor: UIColor.white], range: NSRange(location: 0, length: text.length))
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: textFontSize)], range: NSRange(location: 0, length: h1.count))
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: textFontSize)], range: NSRange(location: 30, length: h2.count))
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: textFontSize)], range: NSRange(location: 90, length: h3.count))
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: textFontSize)], range: NSRange(location: 147, length: h4.count))
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: textFontSize)], range: NSRange(location: 208, length: h5.count))
        
        menuHelpTextView.attributedText = attributedText
        
        
    
        
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
