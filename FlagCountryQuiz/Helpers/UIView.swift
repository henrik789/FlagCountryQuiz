
import UIKit


extension UIView {
    
    func animatePopUp(view: UIView, screenWidth: CGFloat, screenHeight: CGFloat){
        addSubview(view)
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
            view.alpha = 1
            view.frame = CGRect(x: 10, y: 200, width: screenWidth - 20, height: screenHeight / 5)
            view.layer.cornerRadius = 20
            view.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
//            let snowView = SnowView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
//            let snowClipView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
//            snowClipView.clipsToBounds = true
//            snowClipView.addSubview(snowView)
//            view.addSubview(snowClipView)
            
        }) { _ in
            
            
        }
    }
    
}
