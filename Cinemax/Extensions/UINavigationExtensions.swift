//
//  UINavigationExtensions.swift
//  Cinemax
//
//  Created by Humberto Rodrigues on 11/01/23.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func setAppearance() {
        self.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .darkGray
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.navigationBar.tintColor = .yellow
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
    }
    
    
    
        
    
}
