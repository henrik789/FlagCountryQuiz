
import UIKit

class QuizBViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var labelRight: UILabel!
    @IBOutlet weak var labelLeft: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    var fileViewOrigin: CGPoint!
    
    var getFlags = GetFlags()
    var countryList = [Country]()
    var right = false
    var points = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config() {
        addPanGesture(view: flagImageView)
        fileViewOrigin = flagImageView.frame.origin
        view.bringSubviewToFront(flagImageView)
        view.backgroundColor = .myBeige
        topView.backgroundColor = .myBeige
        mainButton.backgroundColor = .myGreen
        mainButton.layer.cornerRadius = mainButton.bounds.height / 2
        labelRight.layer.cornerRadius = labelRight.bounds.height / 5
        labelRight.layer.masksToBounds = true
        labelLeft.layer.cornerRadius = labelLeft.bounds.height / 5
        labelLeft.layer.masksToBounds = true
        labelRight.backgroundColor = .myEmerald
        labelLeft.backgroundColor = .myBlue
        countryList = getFlags.readJSONFromFile()
        startNewGame()
    }
    
    @IBAction func mainButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // Game ******************************************************************************************************
    func startNewGame() {
        
        let randomCountry = Int.random(in: 0..<countryList.count)
        let fakeCountry = Int.random(in: 0..<countryList.count)
        var flag = countryList[randomCountry].flagUrl
        
        flag = flag.replacingOccurrences(of: ".", with: "")
        
        flagImageView.image = UIImage(named: "\(flag).png") ?? UIImage(named: "globe_white.png")
        if randomCountry % 2 == 0 {
            labelRight.text = "Capital: \(countryList[randomCountry].capital)"
            labelLeft.text = "Capital: \(countryList[fakeCountry].capital)"
            right = true
            countryList.remove(at: randomCountry)
            print(countryList[randomCountry].capital)
            
            print(countryList.count, randomCountry)
        } else {
            labelRight.text = "Capital: \(countryList[fakeCountry].capital)"
            labelLeft.text = "Capital: \(countryList[randomCountry].capital)"
            right = false
            countryList.remove(at: randomCountry)
            print(countryList[randomCountry].capital)
            
            print(countryList.count, randomCountry)
        }

        
    }
    
    func evaluate() {
        
    }
    
    // Pan Handling **********************************************************************************************
    func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(QuizBViewController.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        
        let fileView = sender.view!
        switch sender.state {
        case .began, .changed:
            moveViewWithPan(view: fileView, sender: sender)
        case .ended:
            if fileView.frame.intersects(labelLeft.frame) && !right  {
                deleteView(view: fileView)
                points += 1
                print("point left")
                pointsLabel.text = "Points: \(points)"
            } else if  fileView.frame.intersects(labelRight.frame) && right{
                deleteView(view: fileView)
                points += 1
                pointsLabel.text = "Points: \(points)"
                print("point right")
            } else if fileView.frame.intersects(labelLeft.frame) && right || fileView.frame.intersects(labelRight.frame) && !right{
                deleteView(view: fileView)
                
            } else {
                returnViewToOrigin(view: fileView)
            }
        default:
            break
        }
        
    }
    
    func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
    func returnViewToOrigin(view: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            view.frame.origin = self.fileViewOrigin
        })
    }
    
    func deleteView(view: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            view.alpha = 0.1
        })
        UIView.animate(withDuration: 0.3) {
            self.returnViewToOrigin(view: view)
        }
        UIView.animate(withDuration: 0.3) {
            self.startNewGame()
            view.alpha = 1.0
        }

        
    }
    
    
    
}
