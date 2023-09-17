//
//  UIController+Additions.swift
//  Dailymotion
//
//  Created by Tannu Kaushik on 16/09/23.
//


import UIKit
/**
 UIViewController extension
 */
extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

extension UINavigationController {
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = self.navigationBar.standardAppearance
        self.navigationBar.tintColor = .white
    }
}


