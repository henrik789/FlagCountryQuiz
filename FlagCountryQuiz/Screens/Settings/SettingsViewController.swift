

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var flagSlider: UISlider!
    @IBOutlet weak var timeSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        
    }
    
    
    func config() {
        flagSlider.tintColor = .myBlue
        flagSlider.thumbTintColor = .myBlue
        timeSlider.tintColor = .myEmerald
        
        headerView.backgroundColor = .myBeige
        settingsBtn.backgroundColor = .myRed
        settingsBtn.layer.cornerRadius = settingsBtn.bounds.height / 2
        mainView.backgroundColor = .myBeige
    }
    
    @IBAction func settingsBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
