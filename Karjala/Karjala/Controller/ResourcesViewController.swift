//
//  ResourcesVC.swift
//  SanatVersion2
//
//  Created by Николай Горбачев on 04.05.2021.
//

import UIKit

extension NSAttributedString {
    func replace(placeholder: String, with hyperlink: String, url: String, size: CGFloat) -> NSAttributedString {
        let mutableAttr = NSMutableAttributedString(attributedString: self)

        let hyperlinkAttr = NSAttributedString(string: hyperlink, attributes: [NSAttributedString.Key.link: URL(string: url)!, NSAttributedString.Key.font: UIFont.systemFont(ofSize: size)])

        let placeholderRange = (self.string as NSString).range(of: placeholder)

        mutableAttr.replaceCharacters(in: placeholderRange, with: hyperlinkAttr)
        return mutableAttr
    }
}

class ResourcesViewController: UIViewController {

    
    @IBOutlet weak var resourcesTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resourcesTextView.font = UIFont.systemFont(ofSize: 18)
        resourcesTextView.isSelectable = true
        resourcesTextView.dataDetectorTypes = .link
        let textFontSize = CGFloat(16)
        //Keeps the original formatting from xib or storyboard
        
        
        let h1 = "При создании приложения были использованы ресурсы:"
        let h2 = "Рекомендуем также дополнительные материалы:"
        
        let text: NSString = "\(h1)\n\n– @Textbook@ \n\n– @Wiki@ \n\n– @Article@ \n\n\(h2)\n\n– @Vkontakte1@ \n\n– @Vkontakte2@" as NSString
        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: text as String)
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: textFontSize)], range: NSRange(location: 0, length: text.length))
        
        
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: textFontSize)], range: NSRange(location: 0, length: h1.count))
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: textFontSize)], range: NSRange(location: 92, length: h2.count))
        
        resourcesTextView.attributedText = attributedText
        
        resourcesTextView.attributedText = resourcesTextView.attributedText?
            .replace(placeholder: "@Wiki@", with: "Материалы о карельском языке на Википедии", url: "https://en.wikipedia.org/wiki/Karelians", size: textFontSize)
            .replace(placeholder: "@Textbook@", with: "Ольга Жаринова. Говорим по-карельски – учебник", url: "http://avtor.karelia.ru/elbibl/zharinova/karjalakse/files/assets/basic-html/page-1.html", size: textFontSize)
            .replace(placeholder: "@Article@", with: "Статья о карельском языке на портале Постнаука", url: "https://postnauka.ru/longreads/155709", size: textFontSize)
            .replace(placeholder: "@Vkontakte1@", with: "Группа Вконтакте \"Учим карельский язык\"", url: "https://vk.com/karjalan_kieli", size: textFontSize)
            .replace(placeholder: "@Vkontakte2@", with: "Ресурсный медиацентр карелов, вепсов и финнов", url: "https://vk.com/mediacenter_periodika", size: textFontSize)
        // Do any additional setup after loading the view.
        resourcesTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: resourcesTextView!, attribute: .top, relatedBy: .equal, toItem: super.view, attribute: .top, multiplier: 1.0, constant: 10).isActive = true
        
        NSLayoutConstraint(item: resourcesTextView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 10).isActive = true
        resourcesTextView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
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
