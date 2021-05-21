//
//  UIViewControllerExtension.swift
//  Todoey
//
//  Created by JLCS on 5/11/21.
//

import UIKit


extension UIViewController {
    func createNavBarAppearance(backgroundColor: UIColor, titleTextColor: UIColor, largeTitleTextColor: UIColor) -> UINavigationBarAppearance {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: titleTextColor]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleTextColor]
        navBarAppearance.backgroundColor = backgroundColor
        return navBarAppearance
    }
}
