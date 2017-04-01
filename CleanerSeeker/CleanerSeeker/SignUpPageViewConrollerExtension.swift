//
//  SignUpPageViewConrollerExtension.swift
//  CleanerSeeker
//
//  Created by Orest Hazda on 29/03/17.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import Foundation
import UIKit

extension SignUpPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    // MARK: DataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = registrationSteps.index(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else {
            return nil
        }

        guard registrationSteps.count > previousIndex else {
            return nil
        }

        return registrationSteps[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = registrationSteps.index(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1
        let registrationStepsCount = registrationSteps.count

        guard registrationStepsCount != nextIndex else {
            return nil
        }

        guard registrationStepsCount > nextIndex else {
            return nil
        }

        return registrationSteps[nextIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageVC = pageViewController.viewControllers![0]
        self.pageControl.currentPage = registrationSteps.index(of: pageVC)!
    }

}
