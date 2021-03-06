
import UIKit


public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}


class MainNavigationController: UINavigationController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setRootViewController()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension MainNavigationController {
    func setRootViewController() {
        let mainVC  = MainViewController()
        mainVC.delegate = self
//        let storageController = StorageController()
//        mainVC.storageController = storageController
        viewControllers = [mainVC]
    }
}


extension MainNavigationController: MainViewControllerDelegate {
    
    func mainViewController(_ viewController: MainViewController, didSelect action: MainViewControllerAction) {
        let viewController: UIViewController
        switch action {
        case .quiz:
            viewController = QuizViewController()
        case .countryList:
            viewController = CountryListViewController()
        case .settings:
            viewController = SettingsViewController()
        case .quizB:
            viewController = QuizBViewController()
        }
        pushViewController(viewController, animated: true)
    }
    
}

