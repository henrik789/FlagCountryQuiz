
import UIKit


public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

class MainNavigationController: UINavigationController {
//    let serviceManager = ServiceManager()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setRootViewController()
        print(screenWidth, screenHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MainNavigationController {
    func setRootViewController() {
        let mainVC  = MainViewController()
        mainVC.delegate = self
        viewControllers = [mainVC]
    }
}


extension MainNavigationController: MainViewControllerDelegate {
    
    
    func mainViewController(_ viewController: MainViewController, didSelect action: MainViewControllerAction) {
        
        let viewController: UIViewController
        switch action {
        case .quiz:
//            let personViewModel = PersonViewModel(dataManager: serviceManager.dataManager)
            viewController = QuizViewController()
        case .countryList:
//            let graphsViewModel = GraphsViewModel(dataManager: serviceManager.dataManager)
            viewController = CountryListViewController()
            
        }
        
        
        pushViewController(viewController, animated: true)
        
    }
    
}

