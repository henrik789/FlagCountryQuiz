//
//  QuizViewController.swift
//  FlagCountryQuiz
//
//  Created by Henrik on 2020-02-07.
//  Copyright © 2020 Henrik. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    var givenLand = String()
    var landFullname = String()
    var getFlags = GetFlags()
    var points: Int = 0
    var flagCounter = 0
    var randomNumber = 0
    var answer = String()
    var time = 0
    var timer = Timer()
    var list = [Country]()
    
    @IBOutlet var startView: UIView!
//    @IBOutlet weak var flagView: UIView!
    @IBOutlet weak var countdownLabelHome: UILabel!
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var landOne: UIButton!
    @IBOutlet weak var landTwo: UIButton!
    @IBOutlet weak var landThre: UIButton!
    @IBOutlet weak var landFour: UIButton!
    @IBOutlet weak var restartBtn: UIButton!
    @IBAction func restartBtn(_ sender: Any) {
        startFresh()
    }
//    @IBOutlet weak var back: UIButton!
    @IBAction func backBtn(_ sender: Any) {
        print("working")
        startView.removeFromSuperview()
    }
//    @IBOutlet weak var highscore: UIButton!
    
    @IBAction func landOne(_ sender: Any) {
        let buttonOne = sender
        evaluate(button: buttonOne as! UIButton)
    }
    @IBAction func landTwo(_ sender: Any) {
        let buttonTwo = sender
        evaluate(button: buttonTwo as! UIButton)
    }
    @IBAction func landThree(_ sender: Any) {
        let buttonThree = sender
        evaluate(button: buttonThree as! UIButton)
    }
    @IBAction func landFour(_ sender: Any) {
        let buttonFour = sender
        evaluate(button: buttonFour as! UIButton)
    }
    @IBAction func newFlag(_ sender: Any) {
        flagCounter = flagCounter + 1
        givenLand = getFlags.buildFlagArray()
        flagImage.image = UIImage(named: givenLand + ".png")
        setCountryName(land: givenLand)
//        flagLabel.text = "Flags: \(flagCounter) / \(getFlags.totalFlags.count)"
        //        timer?.fire()
    }
    @IBOutlet weak var flagImage: UIImageView!
    
    @IBAction func menuButton(_ sender: Any) {
        startView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        //        startView.layer.cornerRadius = screenHeight / 4
        startView.layer.masksToBounds = true
        view.addSubview(startView)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getFlags.buildArray()
        config()
        list = getFlags.readJSONFromFile()
        for i in list {
            print("Capital: \(i.capital) Land: \(i.name) Area: \(i.area)")
        }
    }
    
    
    func config() {
        newFlag((Any).self)
        landOne.commonStyle()
        landTwo.commonStyle()
        landThre.commonStyle()
        landFour.commonStyle()
//        restartBtn.commonStyle()
//        back.commonStyle()
//        highscore.commonStyle()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
    }
    
    func setCountryName(land: String) {
        answer = getFlags.checkCountry(landCode: land)
        randomNumber = Int.random(in: 1...4)
        if randomNumber == 1 {
            landOne.setTitle(answer, for: .normal)
            setOtherNames(fake1: landTwo, fake2: landThre, fake3: landFour)
        } else if randomNumber == 2 {
            landTwo.setTitle(answer, for: .normal)
            setOtherNames(fake1: landOne, fake2: landThre, fake3: landFour)
        } else if randomNumber == 3 {
            landThre.setTitle(answer, for: .normal)
            setOtherNames(fake1: landOne, fake2: landTwo, fake3: landFour)
        } else if randomNumber == 4 {
            landFour.setTitle(answer, for: .normal)
            setOtherNames(fake1: landOne, fake2: landTwo, fake3: landThre)
        }
    }
    
    func setOtherNames(fake1: UIButton, fake2: UIButton, fake3: UIButton) {
        
        var numberOne = Int.random(in: 0..<getFlags.totalFlags.count)
        var land1 = getFlags.buildFlagArray1(number: numberOne)
        while land1 == givenLand {
            numberOne = Int.random(in: 0..<getFlags.totalFlags.count)
            land1 = getFlags.buildFlagArray1(number: numberOne)
            print("Match!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        }
        var numberTwo = Int.random(in: 0..<getFlags.totalFlags.count)
        var land2 = getFlags.buildFlagArray1(number: numberTwo)
        while numberTwo == numberOne || land2 == givenLand {
            numberTwo = Int.random(in: 0..<getFlags.totalFlags.count)
            land2 = getFlags.buildFlagArray1(number: numberTwo)
            print("Match!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        }
        var numberThree = Int.random(in: 0..<getFlags.totalFlags.count)
        var land3 = getFlags.buildFlagArray1(number: numberThree)
        while numberThree == numberTwo || numberThree == numberOne || land3 == givenLand {
            numberThree = Int.random(in: 0..<getFlags.totalFlags.count)
            land3 = getFlags.buildFlagArray1(number: numberThree)
            print("Match!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        }
        let fakeAnswer1 = getFlags.checkCountry(landCode: land1)
        fake1.setTitle(fakeAnswer1, for: .normal)
        let fakeAnswer2 = getFlags.checkCountry(landCode: land2)
        fake2.setTitle(fakeAnswer2, for:  .normal)
        let fakeAnswer3 = getFlags.checkCountry(landCode: land3)
        fake3.setTitle(fakeAnswer3, for:  .normal)
    }
    
    
    func evaluate(button: UIButton) {
        if flagCounter <= getFlags.totalFlags.count {
            if button.currentTitle == answer {
                
                UIView.transition(with: button, duration: 0.3, options: .curveEaseOut, animations: {
                    button.backgroundColor = .greenOne
                    button.setTitleColor(.white, for: .normal)
                })  { _ in
                    self.points = self.points + 1
                    self.pointsLabel.text = "Points: \(self.points)"
                    //                    self.timer?.invalidate()
                    self.newFlag((Any).self)
                    button.backgroundColor = UIColor.white
                    button.setTitleColor(.black, for: .normal)
                }
                
            }else {
                UIView.transition(with: button, duration: 0.3, options: .curveEaseOut, animations: {
                    button.backgroundColor = .redOne
                    button.setTitleColor(.white, for: .normal)
                })  { _ in
                    button.backgroundColor = UIColor.white
                    button.setTitleColor(.black, for: .normal)
                    print(self.randomNumber)
                    if self.randomNumber == 1 {
                        UIView.transition(with: button, duration: 1.0, options: .curveEaseOut, animations: {
                            self.landOne.backgroundColor = .greenOne
                            self.landOne.setTitleColor(.white, for: .normal)
                        })  { _ in
                            //                            self.pointsLabel.text = "Points: \(self.points)"
                            self.newFlag((Any).self)
                            self.landOne.backgroundColor = UIColor.white
                            self.landOne.setTitleColor(.black, for: .normal)
                        }
                    } else if self.randomNumber == 2 {
                        UIView.transition(with: button, duration: 1.0, options: .curveEaseOut, animations: {
                            self.landTwo.backgroundColor = .greenOne
                            self.landTwo.setTitleColor(.white, for: .normal)
                        })  { _ in
                            //                            self.pointsLabel.text = "Points: \(self.points)"
                            self.newFlag((Any).self)
                            self.landTwo.backgroundColor = UIColor.white
                            self.landTwo.setTitleColor(.black, for: .normal)
                        }
                    }else if self.randomNumber == 3 {
                        UIView.transition(with: button, duration: 1.0, options: .curveEaseOut, animations: {
                            self.landThre.backgroundColor = .greenOne
                            self.landThre.setTitleColor(.white, for: .normal)
                        })  { _ in
                            //                            self.pointsLabel.text = "Points: \(self.points)"
                            self.newFlag((Any).self)
                            self.landThre.backgroundColor = UIColor.white
                            self.landThre.setTitleColor(.black, for: .normal)
                        }
                    } else if self.randomNumber == 4 {
                        UIView.transition(with: button, duration: 1.0, options: .curveEaseOut, animations: {
                            self.landFour.backgroundColor = .greenOne
                            self.landFour.setTitleColor(.white, for: .normal)
                        })  { _ in
                            //                            self.pointsLabel.text = "Points: \(self.points)"
                            self.newFlag((Any).self)
                            self.landFour.backgroundColor = UIColor.white
                            self.landFour.setTitleColor(.black, for: .normal)
                        }
                    }
                }
            }
            
        }else {
            startOver()
        }
    }
    
    func startOver() {
        pointsLabel.text = "All flags done"
    }
    
    func startFresh() {
        timer.invalidate()
        points = 0
        pointsLabel.text = "Points: \(points)"
        flagCounter = 0
        flagLabel.text = "Flags: \(flagCounter) / \(getFlags.totalFlags.count)"
        getFlags.buildArray()
        config()
        startView.removeFromSuperview()
        countdownLabelHome.text = "Time: \(time)"
    }
    
    @objc func update() {
        time += 1
        countdownLabelHome.text = String(time)
    }

}
