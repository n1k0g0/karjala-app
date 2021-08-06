//
//  ViewController.swift
//  SanatVersion2
//
//  Created by mac on 24.04.2021.
//

import UIKit

class LessonData {
    var title: String
    var pagesContents: [LessonPageContents]
    init() {
        self.title = ""
        self.pagesContents = []
    }
    init(title: String, pagesContents: [LessonPageContents]) {
        self.title = title
        self.pagesContents = pagesContents
       }
}

class LessonPageContents {
    var mode: LessonMode = .defaultMode
    var question: String = ""
    var phrase: String = ""
    var fourAnswers: [String] = []
    var correctAnswerNumber: Int = -1
    var correctTranslation: String = ""
    var storyHeader: String = ""
    var storyText: String = ""
    var imageName : String = ""
    init() {
        mode = .defaultMode
        question = ""
        fourAnswers = []
        correctAnswerNumber = -1
        correctTranslation = ""
        storyHeader = ""
        storyText = ""
        imageName  = ""
    }
    init(mode: LessonMode, question: String, phrase: String, fourAnswers : [String], correctAnswerNumber : Int, imageName : String = "") {
        self.mode = mode
        self.question = question
        self.fourAnswers = fourAnswers
        self.phrase = phrase
        self.correctAnswerNumber = correctAnswerNumber
        self.correctTranslation = ""
        self.storyHeader = ""
        self.storyText = ""
        self.imageName = imageName
    }
    init(mode: LessonMode, question: String, phrase: String, correctTranslation : String, imageName : String = "") {
        self.mode = mode
        self.question = question
        self.phrase = phrase
        self.fourAnswers = []
        self.correctAnswerNumber = -1
        self.correctTranslation = correctTranslation
        self.storyHeader = ""
        self.storyText = ""
        self.imageName = imageName
    }
    init(mode: LessonMode, storyHeader : String, storyText : String, imageName : String = "") {
        self.mode = mode
        self.question = ""
        self.fourAnswers = []
        self.correctAnswerNumber = -1
        self.correctTranslation = ""
        self.storyHeader = storyHeader
        self.storyText = storyText
        self.imageName = imageName
    }
}




final class LessonsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var learnViewTable: UITableView!
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
    
    var currentTappedIndex : Int = -1
    let titlesArray = ["Alphabet", "Basic Phrases", "My name is", "Questions", "Home and Family", "Food and Shopping", "Work and Hobby", "Time", "Seasons and Weather", "Travelling"]
    var lessonsDataArray : [LessonData] = []
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        learnViewTable.dataSource = self
        learnViewTable.delegate = self
        learnViewTable.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        learnViewTable.layer.borderWidth = 0.5
        learnViewTable.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        learnViewTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: learnViewTable!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: view.frame.width + 10).isActive = true
        
        lessonsDataArray.append(LessonData(title: "Алфавит", pagesContents: [LessonPageContents(mode: .story, storyHeader: "Карельский алфавит", storyText: "Добро пожаловать на изучение ливвиковского наречия карельского языка! \n\nПри письме на карельском языке используется латинский алфавит с дополнительными символами. Всего в карельском алфавите 28 букв:", imageName: "l1p1"), LessonPageContents(mode: .story, storyHeader: "Гласные", storyText: "В карельском языке восемь кратких гласных звуков: \na, o, u, e, i, ä, ö, у. \n\nГласные делятся на переднеязычные (ä, ö, у), заднеязычные (а, о, и) и нейтральные (e, i).\n\nГармония гласных: в одном слове или части сложного слова переднеязычные гласные ä, ö, у (kylä ‘деревня’) не могут употребляться вместе с заднеязычными гласными а, о, u (ruado ‘работа’)."),LessonPageContents(mode: .fourAnswers, question: "Выберите верное утверждение:", phrase: "Нейтральными гласными считаются", fourAnswers: ["a, o, u", "ä, ö, y", "e, i", "b, č"], correctAnswerNumber: 2), LessonPageContents(mode: .fourAnswers, question: "Переведите на русский", phrase: "Kylä", fourAnswers: ["Привет", "Деревня", "Работа", "Спасибо"], correctAnswerNumber: 1), LessonPageContents(mode: .story, storyHeader: "Согласные", storyText: "Согласные в карельском делятся на краткие: b, č, d, dž, f, g, h, j, k, l, m, n, p, r, s, š, z, ž, t, v, \nи долгие: \nčč, d’d’, nn, n’n’, pp, kk, ll, l'l', mm, rr, ss, šš, tt, vv. \n\nДолгота согласных различает смыслы слов: \nvilu ‘холод’— villu ‘шерсть’. \n\nСогласные t, d, l, n, г, s могут быть мягкими, при этом перед гласным заднего ряда ставится знак смяг­чения: t'outa ‘тётя’, vil'l'u ‘зерновые’." ),LessonPageContents(mode: .fourAnswers, question: "Выберите долгий вариант буквы", phrase: "Č", fourAnswers: ["C", "Čč", "Cč", "Ččč"], correctAnswerNumber: 1),  LessonPageContents(mode: .translation, question: "Переведите на карельский", phrase: "Тётя", correctTranslation: "T'outa"), LessonPageContents(mode: .story, storyHeader: "Ударение", storyText: "Главное ударение в карельском языке всегда падает на первый слог. \nТретий и после него каждый нечётный слог имеет второстепен­ное ударение, последний слог всегда безударный: \nPÄI-väi-(ne) ‘сол­нышко’, 'O-pas-(tu)-mmo ‘учимся’." ), LessonPageContents(mode: .story, storyHeader: "Отличная работа!", storyText: "Вы прошли урок")]))
        
        lessonsDataArray.append(LessonData(title: "Базовые фразы", pagesContents: [LessonPageContents(mode: .fourAnswers, question: "Переведите на русский: ", phrase: "Terveh", fourAnswers: ["Привет", "пока", "я", "ты"], correctAnswerNumber: 0), LessonPageContents(mode: .translation, question: "Переведите на карельский", phrase: "Здравствуй", correctTranslation: "Terveh"), LessonPageContents(mode: .story, storyHeader: "Отличная работа", storyText: "Вы прошли урок")]))
        
        lessonsDataArray.append(LessonData(title: "Меня зовут", pagesContents: [LessonPageContents(mode: .fourAnswers, question: "Переведите на русский: ", phrase: "Terveh", fourAnswers: ["Привет", "пока", "я", "ты"], correctAnswerNumber: 0), LessonPageContents(mode: .translation, question: "Переведите на карельский", phrase: "Здравствуй", correctTranslation: "Terveh"), LessonPageContents(mode: .story, storyHeader: "Отличная работа", storyText: "Вы прошли урок")]))
        
        lessonsDataArray.append(LessonData(title: "Вопросы", pagesContents: [LessonPageContents(mode: .fourAnswers, question: "Переведите на русский: ", phrase: "Terveh", fourAnswers: ["Привет", "пока", "я", "ты"], correctAnswerNumber: 0), LessonPageContents(mode: .translation, question: "Переведите на карельский", phrase: "Здравствуй", correctTranslation: "Terveh"), LessonPageContents(mode: .story, storyHeader: "Отличная работа", storyText: "Вы прошли урок")]))
        
        lessonsDataArray.append(LessonData(title: "Семья и дом", pagesContents: [LessonPageContents(mode: .fourAnswers, question: "Переведите на русский: ", phrase: "Terveh", fourAnswers: ["Привет", "пока", "я", "ты"], correctAnswerNumber: 0), LessonPageContents(mode: .translation, question: "Переведите на карельский", phrase: "Здравствуй", correctTranslation: "Terveh"), LessonPageContents(mode: .story, storyHeader: "Отличная работа", storyText: "Вы прошли урок")]))
        
        lessonsDataArray.append(LessonData(title: "Еда и магазин", pagesContents: [LessonPageContents(mode: .fourAnswers, question: "Переведите на русский: ", phrase: "Terveh", fourAnswers: ["Привет", "пока", "я", "ты"], correctAnswerNumber: 0), LessonPageContents(mode: .translation, question: "Переведите на карельский", phrase: "Здравствуй", correctTranslation: "Terveh"), LessonPageContents(mode: .story, storyHeader: "Отличная работа", storyText: "Вы прошли урок")]))
        
        lessonsDataArray.append(LessonData(title: "Работа и отдых", pagesContents: [LessonPageContents(mode: .fourAnswers, question: "Переведите на русский: ", phrase: "Terveh", fourAnswers: ["Привет", "пока", "я", "ты"], correctAnswerNumber: 0), LessonPageContents(mode: .translation, question: "Переведите на карельский", phrase: "Здравствуй", correctTranslation: "Terveh"), LessonPageContents(mode: .story, storyHeader: "Отличная работа", storyText: "Вы прошли урок")]))
        
        lessonsDataArray.append(LessonData(title: "Время", pagesContents: [LessonPageContents(mode: .fourAnswers, question: "Переведите на русский: ", phrase: "Terveh", fourAnswers: ["Привет", "пока", "я", "ты"], correctAnswerNumber: 0), LessonPageContents(mode: .translation, question: "Переведите на карельский", phrase: "Здравствуй", correctTranslation: "Terveh"), LessonPageContents(mode: .story, storyHeader: "Отличная работа", storyText: "Вы прошли урок")]))
        
        lessonsDataArray.append(LessonData(title: "Погода", pagesContents: [LessonPageContents(mode: .fourAnswers, question: "Переведите на русский: ", phrase: "Terveh", fourAnswers: ["Привет", "пока", "я", "ты"], correctAnswerNumber: 0), LessonPageContents(mode: .translation, question: "Переведите на карельский", phrase: "Здравствуй", correctTranslation: "Terveh"), LessonPageContents(mode: .story, storyHeader: "Отличная работа", storyText: "Вы прошли урок")]))
        
        lessonsDataArray.append(LessonData(title: "Путешествия", pagesContents: [LessonPageContents(mode: .fourAnswers, question: "Переведите на русский: ", phrase: "Terveh", fourAnswers: ["Привет", "пока", "я", "ты"], correctAnswerNumber: 0), LessonPageContents(mode: .translation, question: "Переведите на карельский", phrase: "Здравствуй", correctTranslation: "Terveh"), LessonPageContents(mode: .story, storyHeader: "Отличная работа", storyText: "Вы прошли урок")]))
        
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        print("Sessions View Controller Will Appear")
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("View Will Disappear")
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        //cell.textLabel?.text = titlesArray[indexPath.row]
        cell.textLabel?.text = lessonsDataArray[indexPath.row].title
        //cell.target(forAction: #selector(lessonChosen), withSender: self)
        return cell
    }
    
    /*private lazy var menuViewController: LessonsViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "LessonsViewController") as! LessonsViewController

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)

        return viewController
    }()*/
    
    
    /*private lazy var lessonViewController: LessonViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "SingleLessonViewController") as! LessonViewController
        
        viewController.lessonTitle = titlesArray[currentTappedIndex]
        viewController.lessonData = lessonsDataArray[currentTappedIndex]
        print(titlesArray[currentTappedIndex])
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        return viewController
    }()*/
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentTappedIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: false)
        performSegue(withIdentifier: "FromMenuToLesson", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    /*
    @objc func lessonChosen(sender:AnyObject) {
        remove(asChildViewController: menuViewController)
        add(asChildViewController: lessonViewController)
    }
    */
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)

        // Add Child View as Subview
        view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = CGRect(x: 0, y: 60, width: self.view.frame.width, height: self.view.frame.height - 120)
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)

        // Remove Child View From Superview
        viewController.view.removeFromSuperview()

        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FromMenuToLesson" {
            let destinationVC:LessonViewController = segue.destination as! LessonViewController
            //set properties on the destination view controller
            destinationVC.lessonTitle = titlesArray[currentTappedIndex]
            destinationVC.lessonData = lessonsDataArray[currentTappedIndex]
        }
    }
    
}




