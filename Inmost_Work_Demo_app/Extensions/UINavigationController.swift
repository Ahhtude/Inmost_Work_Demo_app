//
//  UINavigationController.swift
//  Inmost_Work_Demo_app
//
//  Created by Sergey berdnik on 25.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import UIKit

extension UINavigationController {
    var rootVC: UIViewController {
        return viewControllers.first!
    }
}
