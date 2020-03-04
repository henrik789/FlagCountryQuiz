

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var flagSlider: UISlider!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        
    }
    
    
    func config() {
        view.backgroundColor = .myWhite
        headerView.backgroundColor = .myWhite
        mainView.backgroundColor = .myWhite
        
        firstView.backgroundColor = .myGreen
        firstView.layer.cornerRadius = firstView.bounds.height / 6
        flagSlider.tintColor = .myYellow
        flagSlider.thumbTintColor = .myYellow
        
        secondView.backgroundColor = .myBlue
        secondView.layer.cornerRadius = secondView.bounds.height / 6
        timeSlider.tintColor = .myRed
        timeSlider.thumbTintColor = .myRed
        
        settingsBtn.backgroundColor = .myRed
        settingsBtn.layer.cornerRadius = settingsBtn.bounds.height / 2
        
    }
    
    @IBAction func settingsBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
