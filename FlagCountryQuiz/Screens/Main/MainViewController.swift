//
//  MainViewController.swift
//  FlagCountryQuiz
//
//  Created by Henrik on 2020-02-07.
//  Copyright © 2020 Henrik. All rights reserved.
//

import UIKit

protocol MainViewControllerDelegate: class {
    func mainViewController(_ viewController: MainViewController, didSelect action: MainViewControllerAction)
}

enum MainViewControllerAction {
    case quiz
    case countryList
}

class MainViewController: UIViewController {
    
    weak var delegate: MainViewControllerDelegate?
    
    @IBOutlet weak var detailView: UITextView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var myBtn: UIButton!
    var quizVC = QuizViewController()
    var clVC = CountryListViewController()
    @IBOutlet weak var countryLabel: UILabel!
    var getFlag = GetFlags()
    var list = [Country]()
    var names = [String]()
    @IBOutlet weak var countryTextView: UITextView!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "MainView"
//        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(700)) {
//            self.present(self.clVC, animated: true, completion: nil)
//        }
        
        view.backgroundColor = .myWhite
        myView.backgroundColor = .black
        myView.layer.cornerRadius = myView.bounds.height / 2
        logoLabel.textColor = .black
        buttonOne.backgroundColor = .myYellow
        buttonTwo.backgroundColor = .myBlue
        buttonThree.backgroundColor = .myGreen
        buttonFour.backgroundColor =  .myRed
        buttonOne.mainStyle()
        buttonTwo.mainStyle()
        buttonThree.mainStyle()
        buttonFour.mainStyle()
        animate()
        list = getFlag.readJSONFromFile()
        for i in list {
            let myString = i.name
            names.append(myString)
        }
        let navbar = navigationController?.navigationBar
        navbar?.isHidden = true
        navbar?.prefersLargeTitles = false
        navbar?.barStyle = .default
//        fire()
//        fireDetail()
//        createParticles()
    }
    
    @IBAction func buttonOne(_ sender: Any) {
//        self.present(self.quizVC, animated: true, completion: nil)
        print("Trycker")
        delegate?.mainViewController(self, didSelect: .quiz)
    }
    @IBAction func buttonTwo(_ sender: Any) {
        delegate?.mainViewController(self, didSelect: .countryList)
    }
    @IBAction func buttonThree(_ sender: Any) {
        animate()
    }
    
    func animate() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.buttonOne.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        })
        UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseInOut, animations: {
            self.buttonOne.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseInOut, animations: {
            self.buttonTwo.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        })
        UIView.animate(withDuration: 0.3, delay: 0.6, options: .curveEaseInOut, animations: {
            self.buttonTwo.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        UIView.animate(withDuration: 0.3, delay: 0.6, options: .curveEaseInOut, animations: {
            self.buttonThree.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        })
        UIView.animate(withDuration: 0.3, delay: 0.9, options: .curveEaseInOut, animations: {
            self.buttonThree.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        UIView.animate(withDuration: 0.3, delay: 0.9, options: .curveEaseInOut, animations: {
            self.buttonFour.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        })
        UIView.animate(withDuration: 0.3, delay: 1.2, options: .curveEaseInOut, animations: {
            self.buttonFour.transform = CGAffineTransform(scaleX: 1, y: 1)
        })

    }
    
    
    
    func fire() {
        var index = 0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] timer in
            if index < (self?.names.count)! {
                let char = self!.names[index]
                self!.countryLabel.text! = "Loading data: \(index) \(char)"
                index += 1
            } else {
                timer.invalidate()
            }
        })
    }
    
    func fireDetail()
    {
        var index = 0
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { [weak self] timer in
            if index < (self?.names.count)! {
//                let char = self!.names[index]
                self!.detailView.text! = "Country: \(index) \(self!.list[index].name) \(self!.list[index].capital) \(self!.list[index].region) \(self!.list[index].population) \(self!.list[index].language)"
                index += 1
            } else {
                timer.invalidate()
            }
        })
    }
    
    func createParticles() {
        let particleEmitter = CAEmitterLayer()
        
        particleEmitter.emitterPosition = CGPoint(x: view.center.x, y: -96)
        particleEmitter.emitterShape = .line
        particleEmitter.emitterSize = CGSize(width: view.frame.size.width, height: 1)
        
        let red = makeEmitterCell(color: UIColor.red)
        let yellow = makeEmitterCell(color: UIColor.yellow)
        let cyan = makeEmitterCell(color: UIColor.cyan)
        let white = makeEmitterCell(color: UIColor.white)
        let purple = makeEmitterCell(color: UIColor.purple)
        
        particleEmitter.emitterCells = [red, yellow, cyan, white, purple]
        
        view.layer.addSublayer(particleEmitter)
    }
    
    func makeEmitterCell(color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 5
        cell.lifetime = 6.0
        cell.lifetimeRange = 0
        cell.color = color.cgColor
        cell.velocity = 200
        cell.velocityRange = 80
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.spin = 1
        cell.spinRange = 3
        cell.scaleRange = 1.9
        cell.scaleSpeed = 1.2
        
        cell.contents = UIImage(named: "snowflake1")?.cgImage
        return cell
    }
    
}
