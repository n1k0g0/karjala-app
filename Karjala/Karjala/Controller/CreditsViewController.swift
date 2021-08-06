//
//  ProgressController.swift
//  SanatVersion2
//
//  Created by Николай Горбачев on 06.07.2021.
//

import UIKit



class CreditsViewController: UIViewController {
    

    @IBOutlet weak var creditsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creditsTextView.font = UIFont.systemFont(ofSize: 18)
        creditsTextView.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        creditsTextView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        creditsTextView.isSelectable = false
        creditsTextView.dataDetectorTypes = .link
        let textFontSize = CGFloat(20)
        //Keeps the original formatting from xib or storyboard
        
        
        let h1 = "KARJALA"
        let h2 = "Цель проекта"
        
        
        let text: NSString = "\(h1) – независимый проект, направленный на популяризацию карельской культуры. \n\n\(h2) –  поднять интерес аудитории к карельскому языку и культуре. \n\nНекоторые материалы приложения, в том числе изображения, могут быть защищены авторским правом. \n\nПодобные материалы представлены в приложении исключительно в познавательных целях, и права на них не оспариваются со стороны разработчиков приложения." as NSString
        
        
        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: text as String)
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: textFontSize), NSAttributedString.Key.foregroundColor: UIColor.white], range: NSRange(location: 0, length: text.length))
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: textFontSize)], range: NSRange(location: 0, length: h1.count))
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: textFontSize)], range: NSRange(location: 83, length: h2.count))
        
        
        
        creditsTextView.attributedText = attributedText
        
        
    
        
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
