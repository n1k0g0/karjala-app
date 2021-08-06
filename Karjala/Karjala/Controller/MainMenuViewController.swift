//
//  MainMenu.swift
//  SanatVersion2
//
//  Created by Николай Горбачев on 03.05.2021.
//

import UIKit

var progress = 0

final class MainMenu: UIViewController {

    enum Mode {
        case lessons, stories, resources, settings, unspecified
    }
    
    var currentMode = Mode.unspecified
    
    @IBOutlet weak var upperMenuView: UIStackView!
    @IBOutlet weak var learnButton: UIButton!
    @IBOutlet weak var storiesButton: UIButton!
    @IBOutlet weak var resourcesButton: UIButton!
    //@IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var modeLabel: UILabel!
    
    private lazy var lessonsViewController: LessonsViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "LessonsViewController") as! LessonsViewController

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)

        return viewController
    }()

    private lazy var storiesViewController: StoriesViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "StoriesViewController") as! StoriesViewController

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var resourcesViewController: ResourcesViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "ResourcesViewController") as! ResourcesViewController

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var settingsViewController: SettingsViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        updateView(targetMode: Mode.lessons)
        
    }

    // MARK: - View Methods

    private func setupView() {
        // Configure Segmented Control
        storiesButton.addTarget(self, action: #selector(storiesSelected(_:)), for: .touchUpInside)
        learnButton.addTarget(self, action: #selector(lessonsSelected(_:)), for: .touchUpInside)
        resourcesButton.addTarget(self, action: #selector(resourcesSelected(_:)), for: .touchUpInside)
        //settingsButton.addTarget(self, action: #selector(settingsSelected(_:)), for: .touchUpInside)
        // Select First Segment
        currentMode = Mode.unspecified
        learnButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        learnButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
    }
    
    private func updateView(targetMode: Mode) {
        if targetMode != currentMode && targetMode != .settings{
            if targetMode == Mode.lessons {
                add(asChildViewController: lessonsViewController)
                learnButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                learnButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                storiesButton.setTitleColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .normal)
                resourcesButton.setTitleColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .normal)
                modeLabel.text = "Уроки"
            } else if targetMode == Mode.stories {
                add(asChildViewController: storiesViewController)
                storiesButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                storiesButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                learnButton.setTitleColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .normal)
                resourcesButton.setTitleColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .normal)
                modeLabel.text = "Истории"
            } else if targetMode == Mode.resources {
                add(asChildViewController: resourcesViewController)
                resourcesButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                resourcesButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                storiesButton.setTitleColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .normal)
                learnButton.setTitleColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .normal)
                modeLabel.text = "Ресурсы"
            } else if targetMode == Mode.settings {
                /*add(asChildViewController: settingsViewController)
                settingsButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                modeLabel.text = "Settings"*/
            }
            
            
            if currentMode == Mode.lessons {
                remove(asChildViewController: lessonsViewController)
                learnButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                print("lessons\n")
            } else if currentMode == Mode.stories {
                remove(asChildViewController: storiesViewController)
                storiesButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                print("stories\n")
            } else if currentMode == Mode.resources {
                remove(asChildViewController: resourcesViewController)
                resourcesButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                print("resources\n")
            } else if currentMode == Mode.settings {
                print("settings\n")
                remove(asChildViewController: settingsViewController)
               // settingsButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
        }
        currentMode = targetMode
        
    }

    
    @objc func lessonsSelected(_ sender: UISegmentedControl) {
        updateView(targetMode: Mode.lessons)
    }
    @objc func storiesSelected(_ sender: UISegmentedControl) {
        updateView(targetMode: Mode.stories)
    }
    @objc func resourcesSelected(_ sender: UISegmentedControl) {
        updateView(targetMode: Mode.resources)
    }
    @objc func settingsSelected(_ sender: UISegmentedControl) {
        updateView(targetMode: Mode.settings)
    }

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)

        // Add Child View as Subview
        view.addSubview(viewController.view)

        // Configure Child View
        viewController.view.frame = CGRect(x: 0, y: 75, width: self.view.frame.width, height: self.view.frame.height - 130)
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

}
