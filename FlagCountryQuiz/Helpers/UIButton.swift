
import UIKit


extension UIButton {
    func commonStyle() {
        layer.cornerRadius = self.bounds.height / 2
        layer.masksToBounds = true
        backgroundColor = .myWhite2
    }
    
    func mainStyle() {
        layer.cornerRadius = self.bounds.height / 2
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        layer.shadowRadius = 4
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
    
}
