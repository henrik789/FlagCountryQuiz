

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var mainView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                print("still")
        }
        
        headerView.backgroundColor = .myGreen
        settingsBtn.backgroundColor = .myRed
        settingsBtn.layer.cornerRadius = settingsBtn.bounds.height / 2
        mainView.backgroundColor = .myGreen
        
    }
    
    
    @IBAction func settingsBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
