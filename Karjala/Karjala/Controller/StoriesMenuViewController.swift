//
//  StoriesVC.swift
//  SanatVersion2
//
//  Created by mac on 01.05.2021.
//

import UIKit

var storiesArray = ["Tulgua terveh!", "Travelling", "Tips and Tricks"]
var currentTappedIndex = -1
var storiesDataArray : [LessonData] = []

final class StoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - View Life Cycle

    @IBOutlet weak var storiesViewTable: UITableView!
    @IBAction func unwindFromStory( _ seg: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storiesViewTable.dataSource = self
        storiesViewTable.delegate = self
        storiesViewTable.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        
        storiesViewTable.layer.borderWidth = 0.5
        storiesViewTable.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        storiesViewTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: storiesViewTable!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: view.frame.width + 10).isActive = true
        storiesDataArray.append(LessonData(title: "Карельская культура", pagesContents: [LessonPageContents(mode: .story, storyHeader: "Карельский народ", storyText: "Карелы – один из финноугорских народов, проживающих в России, преимущественно в Республике Карелия. \n\nСреди карельского народа выделяют три крупных субэтноса: собственно карелы, ливвики и людики – каждый из которых имеют существенные отличия по культуре и языку.", imageName: "s1p1"), LessonPageContents(mode: .story, storyHeader: "Карельская культура", storyText: "Карельский этнос оформился в позднее Средневековье и за сотни лет сформировал богатую культурную традицию. Так, уже в VII веке скандинавские саги упоминают карел и Карелию под такими названиями как Karjalabotn, Kirjalabotnar. \n\nВ Древнерусских летописях карелы впервые встречаются под 1143 г. где упоминается их военный поход на соседнюю провинцию Хяме. \n\n"), LessonPageContents(mode: .story, storyHeader: "Карельская культура", storyText: "Согласно Лаврентьевскому списку Новгородской летописи в 1227 году произошло массовое крещение карел, когда князь Ярослав Всеволодович «послав кристи множество Корел, мало не все люди». \n\nС тех пор и по сей день православное христианство неотъемлемая часть карельской культуры: в 1972 году в общецерковный календарь Русской Православной церкви было внесено Празднование Собору Карельских святых."), LessonPageContents(mode: .story, storyHeader: "Карельский язык", storyText: "Карельский, будучи финно-угорским языком изначально восходит к Прауральскому языку-предку, что делает его родственником таким языкам, как финский, удмуртский и венгерский. Ближайший предок карельских диалектов - пракарельский язык, был в ходу в IX в у берегов Ладождского озера"), LessonPageContents(mode: .story, storyHeader: "Карельский язык", storyText: "Древнейшим письменным памятником (XIII век) на карельском языке является Новгородская берестяная грамота № 292 — четыре строки заклинания, оберегающего от молнии. Однако письменности на карельском почти не существовало вплоть XIX века: известны лишь отдельные записи – книг же на нём не писалось и в школах он не преподавался.", imageName: "s1p5"), LessonPageContents(mode: .story, storyHeader: "Карельский язык сегодня", storyText: "Сегодня же, после тяжелой истории карел в XXв. и в век свободной информации, карельский язык переживает двоякую трансформацию. \n\nС одной стороны, число носителей карельского как родного языка неуклонно уменьшается; большинство носителей – люди старшего возраста."), LessonPageContents(mode: .story, storyHeader: "Карельский язык сегодня", storyText: "Тем не менее, в последние годы язык осваивает новые сферы использования: на карельском публикуют журналы, пишут статьи википедии, музыку, снимают влоги. \n\nДля изучения карельского языка появляются специальные языковые гнезда, создаются приложения. \n\nНадеемся, что культура карел не оставит Вас равнодушными, и желаем Вам успехов в изучении карельского языка!")]))
        
        storiesDataArray.append(LessonData(title: "Путешествия", pagesContents: [LessonPageContents(mode: .story, storyHeader: "Заголовок", storyText: "текст"), LessonPageContents(mode: .story, storyHeader: "Заголовок", storyText: "текст"), LessonPageContents(mode: .story, storyHeader: "Отличная работа", storyText: "Вы прошли урок  ")]))
        
        storiesDataArray.append(LessonData(title: "Полезные советы", pagesContents: [LessonPageContents(mode: .story, storyHeader: "Заголовок", storyText: "текст"), LessonPageContents(mode: .story, storyHeader: "Заголовок", storyText: "текст"), LessonPageContents(mode: .story, storyHeader: "Отличная работа", storyText: "Вы прошли урок")]))
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
        return storiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        
        cell.textLabel?.text = storiesDataArray[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        currentTappedIndex = indexPath.row
        performSegue(withIdentifier: "FromMenuToStory", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FromMenuToStory" {
            let destinationVC:StoryViewController = segue.destination as! StoryViewController
            //set properties on the destination view controller
            destinationVC.storyTitle = storiesDataArray[currentTappedIndex].title
            destinationVC.storyData = storiesDataArray[currentTappedIndex]
        }
    }
    
}
