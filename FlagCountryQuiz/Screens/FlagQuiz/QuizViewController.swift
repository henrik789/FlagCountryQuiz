
import UIKit

class QuizViewController: UIViewController {
    
    var givenLand = String()
    var landFullname = String()
    var getFlags = GetFlags()
    var points: Int = 0
    var flagCounter = 0
    var flagLimit = 20
    var randomNumber = 0
    var answer = String()
    var time = 0
    var progress = Progress(totalUnitCount: 10)
    var list = [Country]()
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var countdownLabelHome: UILabel!
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var landOne: UIButton!
    @IBOutlet weak var landTwo: UIButton!
    @IBOutlet weak var landThre: UIButton!
    @IBOutlet weak var landFour: UIButton!
    @IBOutlet weak var mainBtn: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBAction func restartBtn(_ sender: Any) {
        startFresh()
    }
    
    /* Warning: Attempt to present <UIAlertController: 0x10183de00> on <FlagCountryQuiz.QuizBViewController: 0x100b19ca0> whose view is not in the window hierarchy!
     */
    
    
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
        print(flagCounter, points)
        givenLand = getFlags.buildFlagArray()
        flagCounter += 1
        flagImage.image = UIImage(named: givenLand + ".png")
        setCountryName(land: givenLand)
        flagLabel.text = "Flags: \(flagCounter) / \(flagLimit)"
    }
    @IBOutlet weak var flagImage: UIImageView!
    
    @IBAction func mainBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFlags.buildArray()
        config()
        //        list = getFlags.readJSONFromFile()
        //        for i in list {
        //            print("Capital: \(i.capital) Land: \(i.name) Area: \(i.area)")
        //        }
    }
    
    
    func config() {
        guard let user = StorageController.shared.fetchUser() else { return }
        flagLimit = user.flagCount
        view.backgroundColor = .myBeige
        newFlag((Any).self)
        progress = Progress(totalUnitCount: Int64(flagLimit))
        progressView.progressTintColor = .myYellow
        progressView.trackTintColor = UIColor(named: "Hague")
        flagLabel.text = "Flags: \(flagCounter)/\(flagLimit)"
        landOne.commonStyle()
        landTwo.commonStyle()
        landThre.commonStyle()
        landFour.commonStyle()
        mainBtn.backgroundColor = .myYellow
        mainBtn.layer.cornerRadius = mainBtn.bounds.height / 2
        
        //        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
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
        }
        var numberTwo = Int.random(in: 0..<getFlags.totalFlags.count)
        var land2 = getFlags.buildFlagArray1(number: numberTwo)
        while numberTwo == numberOne || land2 == givenLand {
            numberTwo = Int.random(in: 0..<getFlags.totalFlags.count)
            land2 = getFlags.buildFlagArray1(number: numberTwo)
        }
        var numberThree = Int.random(in: 0..<getFlags.totalFlags.count)
        var land3 = getFlags.buildFlagArray1(number: numberThree)
        while numberThree == numberTwo || numberThree == numberOne || land3 == givenLand {
            numberThree = Int.random(in: 0..<getFlags.totalFlags.count)
            land3 = getFlags.buildFlagArray1(number: numberThree)
        }
        let fakeAnswer1 = getFlags.checkCountry(landCode: land1)
        fake1.setTitle(fakeAnswer1, for: .normal)
        let fakeAnswer2 = getFlags.checkCountry(landCode: land2)
        fake2.setTitle(fakeAnswer2, for:  .normal)
        let fakeAnswer3 = getFlags.checkCountry(landCode: land3)
        fake3.setTitle(fakeAnswer3, for:  .normal)
    }
    
    
    func evaluate(button: UIButton) {
        if flagCounter <= flagLimit {
            if button.currentTitle == answer {
                
                UIView.transition(with: button, duration: 0.3, options: .curveEaseOut, animations: {
                    button.backgroundColor = .greenOne
                    button.setTitleColor(.myWhite2, for: .normal)
                })  { _ in
                    self.points = self.points + 1
                    self.pointsLabel.text = "Points: \(self.points)"
                    self.winAnimation()
                    if self.flagCounter != self.flagLimit {
                        self.newFlag((Any).self)
                    }
                    button.backgroundColor = .myWhite2
                    button.setTitleColor(.black, for: .normal)
                }
            }else {
                UIView.transition(with: button, duration: 0.3, options: .curveEaseOut, animations: {
                    button.backgroundColor = .redOne
                    button.setTitleColor(.myWhite2, for: .normal)
                })  { _ in
                    button.backgroundColor = .myWhite2
                    button.setTitleColor(.black, for: .normal)
                    if self.randomNumber == 1 {
                        UIView.transition(with: button, duration: 0.8, options: .curveEaseOut, animations: {
                            self.landOne.backgroundColor = .greenOne
                            self.landOne.setTitleColor(.myWhite2, for: .normal)
                        })  { _ in
                            self.newFlag((Any).self)
                            self.landOne.backgroundColor = .myWhite2
                            self.landOne.setTitleColor(.black, for: .normal)
                        }
                    } else if self.randomNumber == 2 {
                        UIView.transition(with: button, duration: 0.8, options: .curveEaseOut, animations: {
                            self.landTwo.backgroundColor = .greenOne
                            self.landTwo.setTitleColor(.myWhite2, for: .normal)
                        })  { _ in
                            self.newFlag((Any).self)
                            self.landTwo.backgroundColor = UIColor.myWhite2
                            self.landTwo.setTitleColor(.black, for: .normal)
                        }
                    }else if self.randomNumber == 3 {
                        UIView.transition(with: button, duration: 0.8, options: .curveEaseOut, animations: {
                            self.landThre.backgroundColor = .greenOne
                            self.landThre.setTitleColor(.myWhite2, for: .normal)
                        })  { _ in
                            self.newFlag((Any).self)
                            self.landThre.backgroundColor = .myWhite2
                            self.landThre.setTitleColor(.black, for: .normal)
                        }
                    } else if self.randomNumber == 4 {
                        UIView.transition(with: button, duration: 0.8, options: .curveEaseOut, animations: {
                            self.landFour.backgroundColor = .greenOne
                            self.landFour.setTitleColor(.myWhite2, for: .normal)
                        })  { _ in
                            self.newFlag((Any).self)
                            self.landFour.backgroundColor = .myWhite2
                            self.landFour.setTitleColor(.black, for: .normal)
                        }
                    }
                }
                pointsLabel.shake()
            }
        }
        incrementProgress()
        if flagCounter == flagLimit {
            startOver()
        }
    }
    
    func incrementProgress() {
        progress.completedUnitCount += 1
        let progressFloat = Float(progress.fractionCompleted)
        progressView.setProgress(progressFloat, animated: true)
    }
    
    func startOver() {
        //        pointsLabel.text = "Points: \(points)/\(flagLimit)"
        //        timer.invalidate()
        let alert = UIAlertController(title: "Finished", message: "You have completed all flags. You scored \(points + 1) out of \(flagCounter).", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                self.navigationController?.popViewController(animated: true)
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            @unknown default:
                fatalError()
            }}))
        alert.addAction(UIAlertAction(title: "New Game", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                self.startFresh()
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            @unknown default:
                fatalError()
            }}))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func startFresh() {
        progressView.progress = 0
        points = 0
        pointsLabel.text = "Points: \(points)"
        flagCounter = 0
        flagLabel.text = "Flags: \(flagCounter)/\(flagLimit)"
        getFlags.buildArray()
        config()
        //        countdownLabelHome.text = "Time: \(time)"
    }
    
    @objc func update() {
        time += 1
        countdownLabelHome.text = "Time: " + String(time)
    }
    
    func winAnimation() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
            self.pointsLabel.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        })
        UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseInOut, animations: {
            self.pointsLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
}
