//
//  ContainerViewController.swift
//  twitter
//
//  Created by Karen Levy on 5/30/15.
//  Copyright (c) 2015 Karen Levy. All rights reserved.
//

import UIKit

enum SlideOutState {
    case BothCollapsed
    case LeftPanelExpanded
}


enum MenuItem: Int {
    case Profile
    case Timeline
    case Menions
    
    func viewController() -> UIViewController {
        switch (self) {
        case Profile: return UIStoryboard.accountViewController()!
        case Timeline: return UIStoryboard.centerViewController()!
        case Menions: return UIStoryboard.mentionsViewController()!
        }
    }
}

class ContainerViewController: UIViewController, UIGestureRecognizerDelegate{
    
    var centerNavigationController: UINavigationController!
    var centerViewController: TweetsViewController!
    var currentState: SlideOutState = .BothCollapsed
    var leftViewController: MenuPanelViewController?
    let centerPanelExpandedOffset: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()

        centerViewController = UIStoryboard.centerViewController()
      //  centerViewController.delegate = self
        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        centerNavigationController.didMoveToParentViewController(self)


        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showShadowForCenterViewController(shouldShowShadow: Bool) {
        if (shouldShowShadow) {
            centerNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
        
    }
    
    func collapseSidePanels() {
        switch (currentState) {
        case .LeftPanelExpanded:
            toggleLeftPanel()
        default:
            break
        }
    }
    
    func addLeftPanelViewController() {
        if (leftViewController == nil) {
            leftViewController = UIStoryboard.leftViewController()
             leftViewController!.menuItems = Menu.items()
            
            addChildSidePanelController(leftViewController!)
        }
    }
    
    func animateLeftPanel(#shouldExpand: Bool) {
        if (shouldExpand) {
            currentState = .LeftPanelExpanded
            
            animateCenterPanelXPosition(targetPosition: CGRectGetWidth(centerNavigationController.view.frame) - centerPanelExpandedOffset)
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { finished in
                self.currentState = .BothCollapsed
                
                self.leftViewController!.view.removeFromSuperview()
                self.leftViewController = nil;
            }
        }
    }
    
    func animateCenterPanelXPosition(#targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
            }, completion: completion)
    }
    
    
    func addChildSidePanelController(sidePanelController: MenuPanelViewController) {
        //        view.insertSubview(sidePanelController.view, atIndex: 0)
        //
        //        addChildViewController(sidePanelController)
        //        sidePanelController.didMoveToParentViewController(self)
        // sidePanelController.delegate = centerViewController
        sidePanelController.delegate = self
        
        view.insertSubview(sidePanelController.view, atIndex: 0)
        
        addChildViewController(sidePanelController)
        sidePanelController.didMoveToParentViewController(self)
    }

}



extension ContainerViewController: UIGestureRecognizerDelegate {
    // MARK: Gesture recognizer
    
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        let gestureIsDraggingFromLeftToRight = (recognizer.velocityInView(view).x > 0)
        
        switch(recognizer.state) {
        case .Began:
            if (currentState == .BothCollapsed) {
                if (gestureIsDraggingFromLeftToRight) {
                    addLeftPanelViewController()
                }
                
                showShadowForCenterViewController(true)
            }
        case .Changed:
            recognizer.view!.center.x = recognizer.view!.center.x + recognizer.translationInView(view).x
            recognizer.setTranslation(CGPointZero, inView: view)
        case .Ended:
            if (leftViewController != nil) {
                // animate the side panel open or closed based on whether the view has moved more or less than halfway
                let hasMovedGreaterThanHalfway = recognizer.view!.center.x > view.bounds.size.width
                animateLeftPanel(shouldExpand: hasMovedGreaterThanHalfway)
            }
        default:
            break
        }
    }
    
}
extension ContainerViewController: MenuPanelViewControllerDelegate {
    func itemSelected(item: MenuItem) {
        let vc = item.viewController()
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .Plain, target: self, action: "toggleLeftPanel")
        self.centerNavigationController.viewControllers = [vc]
        self.collapseSidePanels()
    }
}

private extension UIStoryboard {
  class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
  
  class func leftViewController() -> MenuPanelViewController? {
    return mainStoryboard().instantiateViewControllerWithIdentifier("MenuPanelViewController") as? MenuPanelViewController
  }
  
  
  class func centerViewController() -> TweetsViewController? {
    return mainStoryboard().instantiateViewControllerWithIdentifier("TweetsViewController") as? TweetsViewController
  }
    
    
    class func accountViewController() -> AccountViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("AccountViewController") as? AccountViewController
    }
    
    class func mentionsViewController() -> TwitterMentionsViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("TwitterMentionsViewController") as? TwitterMentionsViewController
    }
  
}





//extension ContainerViewController: TweetsViewControllerDelegate {
//    
//    
//}

