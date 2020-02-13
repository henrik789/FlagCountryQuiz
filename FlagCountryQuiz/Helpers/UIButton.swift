
import UIKit


extension UIButton {
    func commonStyle() {
        layer.cornerRadius = self.bounds.height / 2
        layer.masksToBounds = true
        backgroundColor = .myWhite2
    }
}
