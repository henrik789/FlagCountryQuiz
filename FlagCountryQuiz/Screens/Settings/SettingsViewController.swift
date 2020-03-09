

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var flagSlider: UISlider!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var timeNumber = 60
    var flagNumber = 200
    var storageController = StorageController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()

    }
    
    
    func config() {
        let user = StorageController.shared.fetchUser()
        view.backgroundColor = .myWhite
        headerView.backgroundColor = .myWhite
        mainView.backgroundColor = .myWhite
        
        firstView.backgroundColor = UIColor(named: "PaleWhite")
        firstView.layer.cornerRadius = firstView.bounds.height / 7
        flagSlider.tintColor = .myBlue
        flagSlider.thumbTintColor = .myBlue
        flagSlider.value = Float(user!.flagCount)
        
        secondView.backgroundColor = UIColor(named: "PaleWhite")
        secondView.layer.cornerRadius = secondView.bounds.height / 7
        timeSlider.tintColor = .myRed
        timeSlider.thumbTintColor = .myRed
        timeSlider.value = Float(user!.timeCount) 
        
        settingsBtn.backgroundColor = .myRed
        settingsBtn.layer.cornerRadius = settingsBtn.bounds.height / 2
        
        flagLabel.text = String(flagSlider.value)
        timeLabel.text = String(timeSlider.value)
        
    }
    
    @IBAction func flagSlider(_ sender: Any) {
        let step: Float = 10
        let roundedValue = round(flagSlider.value / step) * step
        flagNumber = Int(roundedValue)
        save()
        flagLabel.text = String(flagNumber)
    }
    
    @IBAction func timeSlider(_ sender: Any) {
        let step: Float = 10
        let roundedValue = round(timeSlider.value / step) * step
        timeNumber = Int(roundedValue)
        timeLabel.text = String(timeNumber)
        save()
    }
    
    func save() {
        var user = StorageController.shared.fetchUser()
        user?.timeCount = timeNumber
        user?.flagCount = flagNumber
        storageController.save(user!)
    }
    
    @IBAction func settingsBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
